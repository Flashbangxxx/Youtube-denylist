# Youtube-denylist

A macOS **device-level** configuration profile for Brave that blocks
`youtube.com` / `youtu.be` (so you can't fall into watching videos) while
still allowing `studio.youtube.com` (so you can manage and upload to your
channel).

This is a **System**-scope profile: it applies to Brave for every macOS
user account on the Mac (not just the account that installed it), and
requires an admin password to install and to remove.

## Install (macOS)

1. Download
   [`profile/brave-youtube-denylist.mobileconfig`](profile/brave-youtube-denylist.mobileconfig)
   (click it, then "Download raw file").
2. Double-click the downloaded file. macOS opens **System Settings**.
3. Go to **General → Device Management** (macOS Sonoma/Ventura) or
   **Profiles** (older macOS), select **"YouTube Denylist for Brave"**, and
   click **Install**. You'll be prompted for an **administrator** password
   — this is a device-level (System) profile, so it needs admin rights to
   install.
4. Quit and reopen Brave.

That's it — Brave is now configured to block YouTube while still allowing
YouTube Studio, device-wide, for every account on this Mac.

### How it works

The profile sets Brave's (Chromium) `URLBlocklist` / `URLAllowlist` managed
policies:

```
URLBlocklist: ["youtube.com", "youtu.be"]
URLAllowlist: ["studio.youtube.com"]
```

- `youtube.com` in the blocklist blocks that domain and all its subdomains
  (`www.youtube.com`, `m.youtube.com`, `music.youtube.com`, etc.).
- `studio.youtube.com` in the allowlist is more specific than the
  blocklist entry, so per Chromium's policy rules it wins and stays
  reachable.
- `youtu.be` (YouTube's short-link domain) is blocked too.

Because this uses Brave's built-in enterprise policy support rather than
Shields/ad-block, it can't be turned off from inside Brave's UI (e.g. by
toggling Shields) — only by removing the profile in System Settings.

### Verify it works

- Visit `youtube.com` → Brave shows a "blocked by your organization" page.
- Visit `studio.youtube.com` → loads normally, so you can sign in and
  post/manage videos.
- `brave://policy` will list `URLBlocklist` / `URLAllowlist` as active,
  and `brave://settings` will show "Managed by your organization" — that's
  expected, it's just how Brave reports that a config profile is applied.

### Removing it

System Settings → General → Device Management (or Profiles) → select
"YouTube Denylist for Brave" → the **−** button → enter your admin
password → confirm. Restart Brave afterward.

## Alternative: Shields custom filter list (per Brave profile only)

If you'd rather scope the block to a single Brave "Person" profile instead
of your whole Mac account, [`filters/youtube-denylist.txt`](filters/youtube-denylist.txt)
is an Adblock/uBlock-style filter list you can add under
`brave://settings/shields/filters` → **Add filter list by URL**:

```
https://raw.githubusercontent.com/Flashbangxxx/Youtube-denylist/main/filters/youtube-denylist.txt
```

This is easier to toggle off (just remove the filter list from Shields
settings), which is a downside if the point is to resist temptation, but
useful if you want the block on one profile only.
