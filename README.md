# Youtube-denylist

A Brave browser filter list that blocks `youtube.com` / `youtu.be` (so you
can't fall into watching videos) while still allowing `studio.youtube.com`
(so you can manage and upload to your channel).

It works as a **Brave Shields custom filter list**, applied to a dedicated
Brave profile so your other profiles are unaffected.

## What's in this repo

- [`filters/youtube-denylist.txt`](filters/youtube-denylist.txt) — the filter
  rules, in Adblock Plus / uBlock syntax (the format Brave's Shields engine
  uses):

  ```
  ||youtube.com^$document
  ||youtu.be^$document

  @@||studio.youtube.com^$document
  ```

  - `||youtube.com^$document` blocks any page load under `youtube.com`
    (including `www.youtube.com`, `m.youtube.com`, `music.youtube.com`, etc.)
  - `||youtu.be^$document` blocks YouTube's short-link domain.
  - `@@||studio.youtube.com^$document` is an **exception rule** that
    re-allows `studio.youtube.com`, since it's a subdomain that would
    otherwise be caught by the first rule.

## Setup: create a dedicated Brave profile

1. Open Brave, click your **profile icon** (top-right corner) → **Add
   Person**.
2. Name it something like `YouTube Denylist`, pick an icon, and click
   **Add**. Brave opens a new window for this profile — do the rest of the
   steps in that window, so only this profile is affected.
3. Go to `brave://settings/shields/filters`.
4. Under **Custom filter lists**, click **Add filter list by URL** and
   paste:

   ```
   https://raw.githubusercontent.com/Flashbangxxx/Youtube-denylist/main/filters/youtube-denylist.txt
   ```

   Brave will fetch it and periodically re-check it for updates. (If you'd
   rather not depend on a live URL, use the **Custom filters** text box
   further down the same page instead, and paste the three rules above
   directly.)
5. Make sure Shields is turned **on** for this profile (it's on by
   default). The custom filter list is enforced regardless of whether
   Shields is set to Standard or Aggressive.

## Verify it works

- In the `YouTube Denylist` profile, visit `youtube.com` → Shields should
  block the page.
- Visit `studio.youtube.com` → it should load normally, so you can sign in
  and post/manage videos.
- Your other Brave profiles are untouched — this filter list only applies
  to the profile you added it to.

## Notes

- To temporarily lift the block (e.g. you genuinely need YouTube for
  something), either switch to a different Brave profile, or go back to
  `brave://settings/shields/filters` and remove/disable the custom list.
- If you ever want to also block YouTube embedded on other websites, you
  can add `||youtube.com/embed^` (without `$document`) as an extra rule,
  though this will also break legitimate embedded videos on other sites.
