cleanup_sensitive_configs() {
    local k8s_dir="k8s"
    
    # Find and process all configmap files
    find "$k8s_dir" -name "*configmap.yaml" | while read -r file; do
        echo "Processing $file..."
        
        # Check if file contains environment variables (including .env.local content)
        if grep -q "AWS_\|DB_\|API_\|SECRET_\|PASSWORD\|KEY\|TOKEN\|NEXT_\|GOOGLE_\|FIREBASE_" "$file"; then
            local service_name=$(basename "$file" | sed 's/-configmap.yaml//' | sed 's/-cm[0-9]*//' | sed 's/-env//')
            local secret_name="${service_name}-env"
            
            # Create secret YAML with proper base64 encoding
            echo "apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
  labels:
    io.kompose.service: ${service_name}
type: Opaque
data:" > "${k8s_dir}/${service_name}-secret.yaml"

            # Process both .env and .env.local sections if they exist
            {
                # Extract variables from .env section
                awk '/\.env:/{p=1;next} /[^ ]:/{if(p){exit}}p' "$file"
                # Extract variables from .env.local section
                awk '/\.env\.local:/{p=1;next} /[^ ]:/{if(p){exit}}p' "$file"
            } | while read -r line; do
                # Skip empty lines and those starting with #
                [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
                
                # Extract key and value
                if [[ "$line" =~ ^[[:space:]]*([A-Z_][A-Z0-9_]*)=(.*)$ ]]; then
                    key="${BASH_REMATCH[1]}"
                    value="${BASH_REMATCH[2]}"
                    
                    # Base64 encode the value
                    encoded_value=$(echo -n "$value" | base64 | tr -d '\n')
                    
                    # Add to secret YAML if not empty
                    if [ ! -z "$key" ] && [ ! -z "$value" ]; then
                        echo "  $key: $encoded_value" >> "${k8s_dir}/${service_name}-secret.yaml"
                    fi
                fi
            done

            # Remove the original configmap sections with sensitive data
            if [ -f "$file" ]; then
                tmp_file=$(mktemp)
                awk '
                BEGIN {print_line=1}
                /\.env:/ {print_line=0}
                /\.env\.local:/ {print_line=0}
                {if(print_line) print $0}
                /^[^ ]/ {print_line=1}
                ' "$file" > "$tmp_file"
                mv "$tmp_file" "$file"
                
                # Remove empty ConfigMaps
                if ! grep -q "data:" "$file" || [ $(grep -v "^#" "$file" | grep -v "^$" | wc -l) -le 3 ]; then
                    echo "Removing empty ConfigMap: $file"
                    rm "$file"
                fi
            fi
        fi
    done
}

# Function to validate secret yaml
validate_secret() {
    local file="$1"
    if [ -f "$file" ]; then
        if ! grep -q "data:" "$file" || ! grep -q "  [A-Z_]\+:" "$file"; then
            echo "Warning: Invalid secret format in $file, removing..."
            rm "$file"
            return 1
        fi
    fi
    return 0
}

# Main execution
cleanup_sensitive_configs

# Validate all generated secrets
find k8s -name "*-secret.yaml" | while read -r secret_file; do
    validate_secret "$secret_file"
done

echo "Config cleanup completed"