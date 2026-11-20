# token-reducer: ask at the start of every session

At the start of every new session, before doing any work on the user's first request, ask:

> Use token-reducer for this session? (Yes / No)

- **Yes**: for the rest of the session, before reading whole files or searching the codebase to answer a question, run the token-reducer pipeline first with a short, specific query and the relevant paths as `--inputs`. Work from the compressed context packet it returns, and only open full files when the packet is not enough. Show the estimated token savings it reports.
  - Prefer the `token-reducer` skill or `/token-reducer` command from the `claude-token-reducer` plugin.
  - If the plugin is not loaded (common in web sessions), run the pinned copy directly:
    `python3 ~/.token-reducer/scripts/context_pipeline.py run --inputs <paths> --query "<question>" --top-k 3 --db ~/.token-reducer/.cache/index.db`
- **No**: work normally for the rest of the session and don't ask again.

Ask once per session only.
