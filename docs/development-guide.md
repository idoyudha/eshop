# Development Guide

This doc explains how to build and run the Eshop source code locally using [makefile](https://www.gnu.org/software/make/manual/make.html).

## Prerequisites

- [Docker for Desktop](https://www.docker.com/products/docker-desktop)
- [Git](https://git-scm.com/downloads)
- [Makefile](https://www.gnu.org/software/make/manual/make.html)
- [Github SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

## How to run locally
1. Clone all the repository.
    ```
    make clone
    ```
   
2. Build and up.
    ```
    make up
   ```
   
3. Open `localhost:3000` for customer page and `localhost:3001` for admin page.