# Freqtrade Strategy Docker Wrapper

This project is a clean, opinionated wrapper around [Freqtrade](https://www.freqtrade.io/) designed to simplify managing and running multiple strategies using Docker. It enforces a strict isolation pattern where each strategy has its own dedicated configuration, database, and logs.

## 🚀 Features

- **Strategy Isolation**: Each strategy lives in its own folder (`user_data/<StrategyName>/`) containing its unique config, code, and runtime data.
- **Easy Execution**: Single script (`run_strategy.sh`) to launch any strategy in a Docker container.
- **Dynamic Container Naming**: Docker containers are named `freqtrade-<StrategyName>` for easy identification.
- **Interactive Logging**: Automatically tails logs upon startup and offers options to keep the container running or kill it upon exit.
- **Clean Workspace**: `.gitignore` is pre-configured to keep sensitive API keys and massive log files out of version control.

## 📂 Project Structure

The structure is enforced to keep things organized.

```
.
├── run_strategy.sh         # Main execution script
├── RULES.md               # Rules for AI agents & developers
├── user_data/
│   └── MyStrategy/         # Dedicated Strategy Folder
│       ├── MyStrategy.json             # Runtime Config (GitIgnored)
│       ├── MyStrategy.example.json     # Template Config (Committed)
│       ├── strategies/
│       │   └── MyStrategy.py           # Strategy Logic
│       ├── logs/                       # (Generated) Runtime Logs
│       └── tradesv3.sqlite             # (Generated) Strategy DB
└── ...
```

## 🛠 Prerequisites

- **Docker** & **Docker Compose** installed.
- **Linux/WSL2** environment (for the shell script).

## 🏁 Getting Started

### 1. Test with Sample Strategy

We have included a `SampleStrategy` to verify your setup.

```bash
./run_strategy.sh SampleStrategy
```
This will:
1.  Verify `user_data/SampleStrategy` exists.
2.  Start a Docker container named `freqtrade-SampleStrategy`.
3.  Mount only the `SampleStrategy` folder to the container.
4.  Begin tailing the logs.

### 2. Create a New Strategy

To add a new strategy named `DeepThought`:

1.  **Create the directory structure**:
    ```bash
    mkdir -p user_data/DeepThought/strategies
    ```
2.  **Add your strategy file**:
    Place `DeepThought.py` inside `user_data/DeepThought/strategies/`.
3.  **Add your configuration**:
    Copy a template or existing config to `user_data/DeepThought/DeepThought.json`.
    *Note: `*.json` files in these folders are gitignored by default. Use `*.example.json` for templates you want to commit.*

### 3. Run Your Strategy

```bash
./run_strategy.sh DeepThought
```

## 📝 Configuration

- **API Keys**: Add your Exchange API keys to your strategy-specific `.json` file.
- **Pairs**: Configure your whitelist/blacklist in the same file.

**Security Note**: strict `.gitignore` rules are in place to prevent accidental commitment of your `*.json` config files containing secrets. Always use `*.example.json` if you need to share a config structure without keys.

## 🤖 AI Agent Rules

If you are using an AI agent to assist with this project, ensure it reads [RULES.md](RULES.md). This file contains strict instructions on maintaining the folder structure and naming conventions.

## 📋 TODO

Check [TODO.md](TODO.md) for planned improvements, such as dynamic port allocation.
