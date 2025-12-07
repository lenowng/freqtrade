#!/bin/bash

# Usage: ./run_strategy.sh <StrategyName> [ConfigFile]
# Example: ./run_strategy.sh SampleStrategy

STRATEGY_NAME=$1
CONFIG_FILE=${2:-"${STRATEGY_NAME}.json"}

if [ -z "$STRATEGY_NAME" ]; then
  echo "Usage: $0 <StrategyName> [ConfigFile]"
  echo "Example: $0 MyStrategy"
  exit 1
fi

CONTAINER_NAME="freqtrade-${STRATEGY_NAME}"

# Check if strategy specific folder exists
STRATEGY_DIR="user_data/${STRATEGY_NAME}"
if [ ! -d "$STRATEGY_DIR" ]; then
  echo "Error: Strategy directory $STRATEGY_DIR does not exist."
  echo "Expected structure: user_data/$STRATEGY_NAME/strategies/$STRATEGY_NAME.py"
  exit 1
fi

# Ensure logs directory exists inside the strategy folder
mkdir -p "${STRATEGY_DIR}/logs"

# Cleanup any existing container with the same name to avoid conflicts
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "Starting strategy: $STRATEGY_NAME with config: $CONFIG_FILE"
echo "Mounting $STRATEGY_DIR to /freqtrade/user_data"

# Run in detached mode
docker run -d \
  --name "$CONTAINER_NAME" \
  -v "$(pwd)/${STRATEGY_DIR}:/freqtrade/user_data" \
  -p 8080:8080 \
  freqtradeorg/freqtrade:stable \
  trade \
  --logfile /freqtrade/user_data/logs/freqtrade.log \
  --db-url sqlite:////freqtrade/user_data/tradesv3.sqlite \
  --config /freqtrade/user_data/${CONFIG_FILE} \
  --strategy "${STRATEGY_NAME}"

echo "Container $CONTAINER_NAME started."
echo "Tailing logs... Press Ctrl+C to stop viewing logs."

# Trap SIGINT (Ctrl+C) so it doesn't kill the script, just the log tailing
trap : INT

# Tail logs
docker logs -f "$CONTAINER_NAME"

# Reset trap
trap - INT

echo ""
echo "Log viewing stopped."
read -p "Do you want to keep the container running in the background? (y/N): " choice

if [[ "$choice" =~ ^[Yy]$ ]]; then
  echo "Container $CONTAINER_NAME is running in the background."
else
  echo "Stopping and removing container $CONTAINER_NAME..."
  docker stop "$CONTAINER_NAME" >/dev/null 2>&1
  docker rm "$CONTAINER_NAME" >/dev/null 2>&1
  echo "Done."
fi
