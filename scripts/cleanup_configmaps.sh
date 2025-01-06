cleanup_sensitive_configs() {
    local k8s_dir="k8s"
    
    # Find and process all configmap files
    find "$k8s_dir" -name "*configmap.yaml" | while read -r file; do
        echo "Processing $file..."
        
        # Check if file contains environment variables
        if grep -q "AWS_\|DB_\|API_\|SECRET_\|PASSWORD\|KEY\|TOKEN" "$file"; then
            local service_name=$(basename "$file" | sed 's/-configmap.yaml//' | sed 's/-cm[0-9]*//' | sed 's/-env//')
            local secret_name="${service_name}-env"
            
            # Create temporary file
            tmp_file=$(mktemp)
            
            # Extract environment variables to create secret
            if grep -q "kind: ConfigMap" "$file"; then
                echo "Creating secret from ConfigMap: $file"
                
                # Create secret yaml
                echo "apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
  labels:
    io.kompose.service: ${service_name}
type: Opaque
data:" > "${k8s_dir}/${service_name}-secret.yaml"
                
                # Extract data section and convert to secret
                awk '/data:/,/kind:/ {
                    if ($1 ~ /^[A-Z]/) {
                        printf "  %s: %s\n", $1, system("echo -n \"" $2 "\" | base64")
                    }
                }' "$file" >> "${k8s_dir}/${service_name}-secret.yaml"
                
                # Remove sensitive data from ConfigMap
                sed -i '/AWS_/d; /DB_/d; /API_/d; /SECRET_/d; /PASSWORD/d; /KEY/d; /TOKEN/d' "$file"
                
                # Remove empty ConfigMaps
                if ! grep -q "data:" "$file" || ! grep -q "  [A-Z]" "$file"; then
                    echo "Removing empty ConfigMap: $file"
                    rm "$file"
                fi
            fi
        fi
    done
}

# Main execution
cleanup_sensitive_configs
echo "Config cleanup completed"