# Youtube-denylist

Blocks `youtube.com` / `youtu.be` on your Mac — device-wide, for every user
account and every browser — while leaving `studio.youtube.com` untouched
so you can still manage and upload to your channel.

## Install (device-wide, all users, all browsers)

This uses `/etc/hosts`, which is a system file — editing it requires an
admin password and the effect applies to the whole Mac, not just one user
account or one browser. This is what actually gives you a **device-level**
block (see [Why not a `.mobileconfig`?](#why-not-a-mobileconfig) below for
why that alternative can't).

1. Clone or download this repo.
2. Make the scripts executable and run the blocker:

   ```
   chmod +x scripts/*.sh
   ./scripts/block-youtube.sh
   ```

   You'll be prompted for your Mac password (it uses `sudo` to edit
   `/etc/hosts`).
3. Restart your browser(s). `youtube.com` and `youtu.be` now fail to load
   for every account on the Mac; `studio.youtube.com` is a different
   hostname and loads normally.

To remove the block later:

```
./scripts/unblock-youtube.sh
```

### What it does

`scripts/block-youtube.sh` appends entries like this to `/etc/hosts`,
between marker comments so it can be cleanly removed later:

```
127.0.0.1 youtube.com
127.0.0.1 www.youtube.com
127.0.0.1 m.youtube.com
127.0.0.1 music.youtube.com
127.0.0.1 youtu.be
127.0.0.1 www.youtu.be
```

`studio.youtube.com` is deliberately never added, so it keeps resolving
normally and stays reachable.

## Why not a `.mobileconfig`?

An earlier version of this repo shipped a Brave configuration profile
using `PayloadScope: System` to try to get a device-wide block. It turns
out that doesn't work: since macOS Big Sur, Apple only honors "Device"
scope for profiles pushed by an actual MDM server — anything installed by
double-clicking a `.mobileconfig` (with or without admin rights) is
silently installed as a **user**-level profile, no matter what
`PayloadScope` the file declares. There's no supported way around this
without enrolling the Mac in an MDM, which is well beyond what's needed
here. The `/etc/hosts` approach above sidesteps this entirely since it's
a plain system file, not a profile.

## Brave-only alternatives (per-user, not device-wide)

If you specifically want the block scoped to Brave only (leaving other
browsers unaffected) and are fine with it being per-user rather than
device-wide, two options are still in this repo:

- [`profile/brave-youtube-denylist.mobileconfig`](profile/brave-youtube-denylist.mobileconfig) —
  installs a Brave-only policy for the current macOS user account
  (System Settings → General → Device Management → Install). Sets
  Brave's `URLBlocklist`/`URLAllowlist` so it can't be toggled off from
  inside Brave's UI — only by removing the profile.
- [`filters/youtube-denylist.txt`](filters/youtube-denylist.txt) — a
  Shields custom filter list, scoped to a single Brave "Person" profile.
  Add it under `brave://settings/shields/filters` → **Add filter list by
  URL**:

  ```
  https://raw.githubusercontent.com/Flashbangxxx/Youtube-denylist/main/filters/youtube-denylist.txt
  ```

  Easiest to toggle off, so weakest if the goal is resisting temptation.
