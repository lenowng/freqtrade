# Project TODOs

- [ ] Enhance `run_strategy.sh` to check for the next available port.
    - Currently, the script hardcodes port 8080.
    - Since this runs in WSL2, mapped ports are exposed to the host.
    - The script should find the next available incremental port to avoid conflicts when running multiple strategies simultaneously.

- [x] Refactor folder structure to fully isolate strategy data.
    - Currently, mounting the entire `user_data/` folder causes all containers to share and populate the same subdirectories (logs, db, etc.).
    - Goal: Mount a dedicated folder per strategy (e.g., `user_data/MyStrategy/`) as `/freqtrade/user_data` in the container.
    - This ensures that all generated artifacts (logs, SQLite DBs, backtest results) are contained within that strategy's specific folder.
    - Requires restructuring so that the strategy file and config are correctly placed/mounted within this isolated environment.
