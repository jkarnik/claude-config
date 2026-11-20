# Mention watcher for the Claude desktop app

Every hour, this scheduled task finds Slack messages and Jira and Confluence comments addressed to you, and drafts replies. It sends nothing: Slack replies wait in Slack's Drafts & Sent for you to press Enter, and Jira and Confluence replies are listed in the task's results with links.

"Addressed to you" means @-mentions of you, DMs to you, and comments on Jira tickets you're assigned to or reported and on Confluence pages you created. Mail isn't covered until a mail connector is installed.

## Set it up

1. Paste `CLAUDE-desktop.md` from this folder into Settings > Cowork > Global instructions (Settings > Your Claude in the newer layout). The task relies on its "Draft, never send" rule.
2. Recommended: in Customize > Connectors, open Slack, then its Permissions tab, and set the tools that send and schedule messages to "Blocked". Then nothing can be sent even if Claude slips. Drafts use a separate tool, so they keep working.
3. Check that the folder `~/Claude/mention-watcher` exists, and create it if not. The task keeps its log there, so it never drafts a reply to the same comment twice.
4. Click "Scheduled" in the left sidebar, then "New task", then "Set up manually", and fill in:
   - **Task name:** Mention watcher
   - **Prompt:** everything under "Task prompt" below
   - **Approval mode:** Auto, if the app offers a choice
   - **Frequency:** Hourly
   - **Folder:** `~/Claude/mention-watcher`, if the app offers one
5. Run the task once from the Scheduled page to check it. The first run looks back 24 hours.

A task that uses a folder on your computer runs only while the computer is awake and the app is open. So does every task when the app runs on a cloud provider such as Amazon Bedrock.

## Task prompt

Find messages and comments addressed to me since the last run, and draft replies. Never send or post anything; the "Draft, never send" rule in your instructions applies in full.

1. Read `handled.md` in your working folder, or in `~/Claude/mention-watcher` if you have no folder. Its first line is the start time of the last run, and the rest lists items already handled. If the file doesn't exist yet, look back 24 hours. If you can't read or write files at all, look back 2 hours and say at the top of the results that the log is unavailable.
2. Find what's new since then:
   - Slack: messages that @-mention me, and DMs to me, one-to-one or group. Skip @channel, @here and user-group mentions, and my own messages.
   - Jira: comments that @-mention me, and new comments on tickets where I'm the assignee or reporter.
   - Confluence: comments that @-mention me, and new comments on pages I created.
3. Drop items already in `handled.md`, items I've already replied to, and items that need no reply, such as thanks, FYIs and emoji-only messages.
4. For each item left, read the whole thread, ticket or page, and a few of my own recent messages there to match my voice. Then draft a reply that follows the writing rules. Use only facts from what you read; where the reply needs something only I know, leave a marked gap like [ETA?].
   - Slack: save the draft in the same thread or DM with `slack_send_message_draft`.
   - Jira and Confluence: don't post. Put the draft in the results.
5. Write the results, newest first. For each item give who, where (with a link), what they asked, and the draft, or "draft saved in Slack". Put items with gaps first, under "Needs your input". If a search failed, say which at the top, so a failed search isn't read as nothing new. If every search worked and nothing is new, the whole result is "Nothing new."
6. Update `handled.md`: replace the first line with this run's start time, and add a line for each item you handled, with its link and what you did.
