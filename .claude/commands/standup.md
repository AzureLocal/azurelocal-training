---
description: Produce a standup summary — what was done, what's in progress, what's blocked, what's next.
---

Invoke the `training-pm` agent to produce a standup summary. The agent should:

1. Read `git log --since="1 day ago"` for completed work
2. Read `repo-management/status/module-status.md` for current state
3. Read recent `repo-management/status/standups/*.md` for context continuity
4. (Optional) Query ADO for active work items in `AzureLocal\Training` if `az boards` is configured
5. Produce a standup file at `repo-management/status/standups/YYYY-MM-DD.md` with sections: **Done**, **In Progress**, **Blocked**, **Next**

The standup summary should be terse, useful, and chronologically dated. Bullet points only.

After writing the file, summarize the key items in chat.
