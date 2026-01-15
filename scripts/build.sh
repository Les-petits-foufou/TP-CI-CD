#!/bin/bash
set -e
TAG=${1:-local}
echo "🐳 Build Image ($TAG)..."
docker build -f docker/Dockerfile -t ghcr.io/les-petits-foufou/tp-ci-cd:$TAG .
