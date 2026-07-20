# Website Maintenance

This is the release checklist and messaging guide for the Not There Yet website. Keep it short, current, and useful.

## Ownership

The product owner owns the core positioning, feature names, release story, and final copy approval. The person preparing a release owns the cross-surface audit, asset updates, link checks, and deployment verification.

When wording differs between the app, App Store, and website, resolve the difference with the product owner. Do not let one surface silently become the source of truth.

## Message Contract

Primary positioning:

> Not There Yet is a family road-trip game built for the miles between here and there.

Repeat these durable ideas consistently wherever they are relevant:

- Family-first road-trip play
- Six included games
- One shared device
- iPhone and iPad
- No account required
- No ads
- No subscriptions
- No analytics or tracking
- Works offline
- Adventures stay on the device

Use the official product terms exactly:

- Road Crew
- Adventure
- Adventure Log
- License Plate Challenge
- Alphabet Hunt
- Vehicle Bingo
- Roadside Oddities
- Road Chain
- Roadside Challenge

Use **shared device** as the noun phrase. Prefer natural wording such as “play together on one shared device” instead of technical phrases such as “local-only,” “server connection,” or “remote configuration” outside the Privacy page.

Capitalize **Adventure** only when referring to the product feature: “Start an Adventure.” Use lowercase for general language: “Every road trip becomes an adventure.”

Use these canonical game descriptions:

- **License Plate Challenge:** Spot license plates from all 50 states.
- **Alphabet Hunt:** Find every letter from A to Z on signs, vehicles, and license plates.
- **Vehicle Bingo:** Look for cars, trucks, buses, and other vehicles along the way.
- **Roadside Oddities:** Discover giant objects, unusual landmarks, funny signs, and other roadside surprises.
- **Road Chain:** Take turns finding something that starts with the last letter of the previous answer.
- **Roadside Challenge:** Complete fun roadside spotting challenges and race to the winning score.

Preferred experience copy:

- Play together on one shared device.
- Add your Road Crew.
- Start an Adventure.
- Play a single game or keep your Road Crew together across a full Adventure.
- Just pass the device, look outside, and make the miles more fun.

## Release Workflow

### 1. Before App Store submission

- Confirm the public version number and official feature names from the app build.
- Draft the App Store description, promotional text, release notes, and website release story together.
- Decide whether the website should publish at submission, approval, or release.
- Capture final screens from the submitted build on iPhone and iPad.
- Check that screenshots show the current game count, terminology, navigation, and visual design.

### 2. Prepare the website

Pages that normally change every release:

- `index.html`: release callout, headline feature, feature count, and current screenshots
- `release-notes.html`: newest release entry at the top
- `WEBSITE-BACKLOG.md`: close completed work and record genuine follow-ups

Pages that change only when the product promise changes:

- `about.html`: positioning, ways to play, supported devices, and trust messaging
- `faq.html`: included games, devices, pricing model, offline behavior, and common questions
- `support.html`: support topics, email address, and diagnostic guidance
- `privacy.html`: data practices only; update its “Last updated” date whenever the policy wording changes

Files that rarely change:

- `styles.css`: change only when content creates a real layout or accessibility need
- Brand mark, fonts, App Store badge, footer legal text, and navigation

### 3. Synchronize the product surfaces

Compare the website with the App Store listing line by line:

- Version number and release headline
- Number and names of included games
- Family and shared device positioning
- iPhone and iPad support
- No account required, no ads, and no subscriptions
- Offline behavior and privacy claims
- Support email and website URL
- Screenshot order, captions, and visible UI

A submitted version may appear on the website before it appears in the public App Store listing. Treat that as an intentional release-state difference and verify synchronization again when the version becomes available.

### 4. Maintain release notes

- Put the newest version first and keep earlier entries below it.
- Lead with the customer benefit, then explain the main addition in plain language.
- Use a short highlights list only when it helps scanning.
- Preserve historically accurate names when explaining a rename, such as the original Trip History becoming the Adventure Log.
- Avoid internal implementation details, ticket language, and exhaustive changelogs.

### 5. Maintain screenshots

- Use real screens from the final submitted build; do not recreate the interface as an illustration.
- Keep the same number and story order for iPhone and iPad App Store sets.
- Include game selection, active gameplay, and Adventure results or history.
- Replace images that show an old game count, obsolete terminology, or retired UI.
- Store raw gameplay captures in `assets/app-store/gameplay-masters/`.
- Store final App Store exports in `assets/app-store/exports/<device>/`.
- Store only the optimized images used by the website in `assets/screenshots/`.
- Give website images specific alternative text that describes the useful screen content.

## Pre-Publish Checklist

- Read every page once as a first-time visitor and once as an editor.
- Search the repository for old version numbers, game counts, retired names, and “Trip History.”
- Confirm the App Store URL and badge.
- Confirm every internal link, image, font, and email link resolves.
- Check desktop and mobile layouts for overflow, clipping, unreadable text, and awkward wrapping.
- Confirm page titles, descriptions, and Open Graph metadata reflect the current positioning.
- Run `git diff --check` and review the complete diff.
- Publish, then verify the deployed homepage, Release Notes, About, FAQ, Support, and Privacy pages.
- Confirm the deployed screenshot assets load successfully.

## Completion Standard

A website release is complete when the live site, current app, App Store listing, release notes, and screenshots tell the same product story—or when any temporary difference is intentional, documented, and scheduled for a follow-up check.
