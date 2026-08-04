#!/bin/bash
set -e

APP_DIR="/home/ec2-user/app"
cd $APP_DIR

# Load environment variables
if [ -f .env ]; then
  export $(cat .env | xargs)
fi

# Install Python if not present
if ! command -v python3 &> /dev/null; then
  sudo yum install -y python3
fi

# Kill existing app process if running
pkill -f "python3 app.py" || true

# Start the app in background
nohup python3 app.py > app.log 2>&1 &

echo "App deployed successfully on $APP_ENV"
