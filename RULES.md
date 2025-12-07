# Project Rules

These rules must be followed by the AI agent when working on this project.

1.  **Strategy-Specific Configurations**:
    - When creating a new strategy file (e.g., `MyStrategy.py`), ALWAYS create a corresponding configuration file with the same name (e.g., `MyStrategy.json`).
    - Do not rely on a universal `config.json` for strategies. Each strategy should have its own dedicated configuration.
    - The configuration file should be placed in `user_data/<StrategyName>/`.
    - The strategy file should be placed in `user_data/<StrategyName>/strategies/`.
    - ALL generated files (DB, logs) will be created inside `user_data/<StrategyName>/`.

2.  **Enforce Project Structure**:
    - If you (the AI agent) or the user create a new strategy that violates the isolated folder structure (e.g., placing files directly in `user_data/strategies/`), you MUST strictly enforce the pattern defined above.
    - Proactively restructure the files to `user_data/<StrategyName>/` or explicitly remind the user to follow the defined structure to maintain consistency.
