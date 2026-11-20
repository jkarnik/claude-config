# Hourly brief for the Claude desktop app

Every hour, this scheduled task tells you what needs you and drafts replies to what's addressed to you. The first run each day is a full brief of your calendar, email, Slack messages and to-dos, Jira and Confluence; later runs list only what's new since the last run. It sends nothing: Slack replies wait in Slack's Drafts & Sent for you to press Enter, and Jira and Confluence replies are listed in the task's results with links.

"Addressed to you" means @-mentions of you, DMs to you, replies in Slack threads you started, and comments on Jira tickets you're assigned to or reported and on Confluence pages you created. Calendar and mail join in once their connectors are installed.

## Set it up

1. Paste `CLAUDE-desktop.md` from this folder into Settings > Cowork > Global instructions (Settings > Your Claude in the newer layout). The task relies on its "Draft, never send" rule.
2. Recommended: in Customize > Connectors, open Slack, then its Permissions tab, and set the tools that send and schedule messages to "Blocked". Then nothing can be sent even if Claude slips. Drafts use a separate tool, so they keep working.
3. Check that the folder `~/Claude/hourly-brief` exists, and create it if not. The task keeps its log there, so it knows what's new and never drafts a reply to the same comment twice.
4. Click "Scheduled" in the left sidebar. If you already have a morning brief task, open it and edit it; otherwise click "New task", then "Set up manually". Fill in:
   - **Task name:** Hourly brief
   - **Prompt:** everything under "Task prompt" below
   - **Approval mode:** Auto, if the app offers a choice
   - **Frequency:** Hourly
   - **Folder:** `~/Claude/hourly-brief`, if the app offers one
5. Run the task once from the Scheduled page to check it. Its first run gives the full brief.

A task that uses a folder on your computer runs only while the computer is awake and the app is open. So does every task when the app runs on a cloud provider such as Amazon Bedrock.

## Task prompt

Every hour, tell me what needs me and draft replies to what's addressed to me. The first run each day is a full brief; later runs report only what's new since the last run. Never send or post anything; the "Draft, never send" rule in your instructions applies in full. My time zone is IST (Asia/Kolkata), and "today" means today in IST.

1. Run `date` to get this run's start time in IST. Then read `handled.md` in your working folder, or in `~/Claude/hourly-brief` if you have no folder. Its first line is the start time of the last run, and the rest lists messages and comments already handled.
2. Set the window and the run type. With no `handled.md`, look back 24 hours; otherwise look back to the last run. If you can't read or write files at all, look back 2 hours and say at the top of the results that the log is unavailable. The run is the first of the day when there's no log or the last run was on an earlier day in IST; any other run is an update.
3. Look up who I am: my Slack user with `slack_read_user_profile` and no user ID, and my Atlassian account with `atlassianUserInfo`.
4. On every run, find what's new in the window, skipping any source whose connector isn't available:
   - Slack: messages that @-mention me, DMs to me (one-to-one or group), and replies in threads I started. Skip @channel, @here and user-group mentions, bot and alert noise, and my own messages.
   - Jira: comments that @-mention me, and new comments on tickets where I'm the assignee or reporter.
   - Confluence: comments that @-mention me, and new comments on pages I created.
   - Email: important unread mail, meaning direct asks of me, mail from my manager, leadership or customers, and anything about deadlines or approvals. Skip newsletters, automated notifications and FYIs.
   - Calendar, on updates only: meetings starting in the next hour that need preparation.
5. On the first run of the day, also gather:
   - Calendar: today's meetings with start time, title and anything to prepare, such as a linked doc or an agenda that asks for my input. Flag overlaps and meetings starting before 10:00.
   - Jira: my open issues (`assignee = currentUser() AND statusCategory != Done`) that are due today, overdue, or high or highest priority.
   - Slack to-dos: messages I've saved for later, found with the `is:saved` search filter, and the open items in my Slack to-do list, meaning those not marked done. Read the list with `slack_read_list`, trying the titles "To-do", "Todo" and "Tasks" until one matches.
6. Drop messages and comments already in `handled.md`, and ones I've already replied to.
7. For each message or comment that needs a reply, read the whole thread, ticket or page, and a few of my own recent messages there to match my voice. Then draft a reply that follows the writing rules. Skip messages that need no reply, such as thanks and FYIs. Use only facts from what you read; where the reply needs something only I know, leave a marked gap like [ETA?].
   - Slack: save the draft in the same thread or DM with `slack_send_message_draft`.
   - Email: save it as a draft in the mail app.
   - Jira and Confluence: don't post. Put the draft in the results.
8. Write the results as described below. Then update `handled.md`: replace its first line with this run's start time, and add a line for each message or comment you handled, with its link and what you did.

### Results

- Each item is one line: what it is, who it's from, the action, and a link wherever the source gives one. For a reply, add "draft saved in Slack", or put the draft under the line. Start the line with "Needs your input:" when the draft has a gap.
- **First run of the day:** under about 300 words, not counting drafts, in these sections, skipping any that are empty:
  - **Today: <Weekday, date>**
  - **Needs you today:** the 3 to 5 most urgent items from all sources, to-dos included, most urgent first. This is the section to read if nothing else.
  - **Calendar:** `HH:MM–HH:MM  Title`, plus any prep note.
  - **To-dos:** my saved messages and open list items, at most 10, most urgent first, with due dates where the list has them and a count of any beyond 10. Name the list you read, so I can correct it if it's the wrong one; if no list matched, say so under Notes.
  - **Slack, Email, Jira, Confluence:** one section each for everything else.
  - **Notes:** one line on any connector that isn't available, such as "Calendar and email not connected."
- **Updates:** a "Since <time of last run>" heading, then only the new items, most urgent first. If every search worked and nothing is new, the whole result is "Nothing new."
- If a search failed, say which at the top, so a failed search isn't read as nothing new.
- No intro or closing summary, and no item in more than one section.
