# Writing for human readers

This applies to every document a person reads: design docs, PRDs, Jira tickets, Confluence pages, blog posts, PR descriptions, READMEs and emails. CLAUDE.md lists the six rules; this file shows how to apply each one.

## Say each thing once

- Beside a table, diagram or embedded plan, write only what it doesn't say: conditions, assumptions, limits, dependencies, out of scope. If a sentence repeats a row, delete the sentence.
- Skip the intro that previews the sections and the closing that recaps them. The headings already show the structure.
- Watch for a phrase or sentence shape that keeps coming back, and reword or cut the repeats.

> Before: a rollout table with three stages, followed by three paragraphs that describe each stage again.
> After: the table, then two bullets: "Stage 2 waits on the billing team's API" and "Out of scope: EU regions."

## Lead with the point

- The first two lines state the problem or the answer plainly, then what the document covers.
- Put the strongest specifics first, such as the decision or the number that matters, so a reader who stops early still has them.
- Organize by the reader's question, not by screen, feature or tool.

> Before: "Observability has never been more important. In this post we'll explore…"
> After: "Checkout requests failed for 12 minutes on May 4. This post walks through how we found the cause."

## Keep one thread

- Each section answers one question. Before adding a step, a number or a side fact, check that it moves that question forward; if it doesn't, cut it.
- Prefer two or three clear steps to six thorough ones, so the reader never loses track of what's being investigated or decided.
- When the setup is hard to picture, add a diagram up front. A caption says exactly what the image shows.

> Before: step 4 of 7, "We also checked DNS, which was fine, and noted the CDN cache hit rate was 94%."
> After: the DNS and CDN checks are gone; only the steps that led to the cause remain.

## Few numbers, each with context

- Keep about three numbers per section of prose, the ones that carry the point. Move the rest to a table or cut them.
- Give each number its unit and baseline: "p95 latency rose from 180 ms to 2.4 s" rather than "latency rose 1,200%".
- Say what a percentage is a share of. "40% of requests" leaves the reader asking: of all requests, or of requests to this service?
- A claim with no number, such as "much faster", gets one or goes.

> Before: "Errors spiked 640% across 14 services on 3 clusters, with 2,113 failed calls (4.7%)."
> After: "Failed calls rose from about 20 an hour to 2,100 in the hour after the deploy."

## Plain, specific words

- Use names and values instead of adjectives: "the payments database in us-east-1" rather than "a critical backend system".
- Write for a reader outside the specialty. Describe what people see, or explain a term once where it first appears: "customers can't sign in" rather than "the auth service returns 503s".
- Give each thing one name and keep it. If it's "the dashboard" in one section, it's the dashboard in every section.
- Use bullets only for real lists. A single idea stays a sentence.

> Before: "Leverage our seamless, powerful experience to unlock insights."
> After: "The Errors page groups failures by endpoint, with the noisiest at the top."

## No generated-sounding patterns

| Pattern | Fix |
|---|---|
| The "It isn't X. It's Y." antithesis | State Y with its evidence. Use the shape once per document at most. |
| Aphorisms ("Data doesn't lie.") | Cut them. |
| A cold open ("The pager goes off at 3 a.m.…") and an ending that calls back to it | Open on the problem; end on the next step. |
| Reflexive lists of three | List what's real, whether that's one item or five. |
| "Every X" titles ("…problems every team hits") | Name the specific problem. |
| Grand claims with no number ("dramatically faster", "effortless") | Add the number, or cut the claim. |
| Bold words mid-sentence | Bold only a label at the start of a bullet. |
| The same scaffold in every section, such as a definition at the top and a "Key takeaways" list at the end | Shape each section to its own content. |
| A tag line on every step | Drop it, or keep one line that adds information. |
| Filler transitions and metaphors ("Let's dive in", "at the end of the day") | Delete them; the next sentence usually stands alone. |
| A marketing closer ("…unlocks the full power of your data") | End with what to do next, or a link. |

## Length

- Write to the target length. If the draft runs over, hand it over anyway with its word count and offer specific cuts; the user chooses them.
- A piece that runs well past its target may be two pieces. Suggest the split rather than squeezing one.

## Before handing it over

1. Do one read just for repetition: compare each paragraph with the tables, headings and earlier sections, and cut what's already said.
2. Check that the first paragraph states the point.
3. Count the numbers in each section's prose, and keep the ones that carry the point.
4. Search for the patterns in the table above.
5. Compare the word count with the target, and report both.
