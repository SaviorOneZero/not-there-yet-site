# Not There Yet website

This repository contains the public website for **Not There Yet**, a family road-trip game for iPhone and iPad. The site introduces the app, explains how it works, publishes release notes, answers common questions, provides support information, and states the app's privacy practices.

The website supports the Not There Yet iOS application, but it is a separate project with a separate deployment lifecycle. Website copy and screenshots should accurately reflect the released app and its App Store listing.

## Repository scope

This repository contains:

- The static HTML pages published at <https://savioronezero.github.io/not-there-yet-site/>
- Shared website styling, fonts, brand assets, and optimized screenshots
- App Store screenshot masters and exports used during release preparation
- Website release procedures, messaging guidance, and follow-up work

This repository does **not** contain:

- The iOS application's Swift or SwiftUI source code
- Application architecture or implementation documentation
- Product vision, product planning, or the application backlog
- App build, test, signing, or App Store submission configuration

Those materials are maintained in the separate [Not There Yet iOS application repository](https://github.com/SaviorOneZero/not-there-yet-ios). Changes to app behavior or product scope should be designed and documented there first, then reflected here when they affect the public website.

## Repository structure

```text
.
├── index.html                 # Homepage and current release callout
├── about.html                 # Product overview and ways to play
├── faq.html                   # Frequently asked questions
├── release-notes.html         # Public version history
├── support.html               # Support guidance and contact details
├── privacy.html               # Public privacy policy
├── age-suitability.html       # Family content, reading, and supervision guidance
├── styles.css                 # Shared site styles
├── assets/
│   ├── app-store/             # App Store screenshot masters and exports
│   ├── fonts/                 # Locally hosted website fonts
│   ├── screenshots/           # Optimized screenshots used by the site
│   └── *.svg                  # Brand mark and App Store badge
├── WEBSITE_MAINTENANCE.md     # Release workflow, message contract, and checks
└── WEBSITE-BACKLOG.md         # Website-only follow-up work and release gates
```

The site has no build step, package manager, JavaScript application, or server-side component. All public pages are standalone HTML files using the shared stylesheet and repository assets.

## Working locally

Most content can be reviewed by opening `index.html` directly. To check the site with normal HTTP behavior, run a local static server from the repository root:

```sh
python3 -m http.server 8000
```

Then open <http://localhost:8000/> and review every public page at desktop and mobile widths. Before proposing a change, follow the checks in [WEBSITE_MAINTENANCE.md](WEBSITE_MAINTENANCE.md).

## Deployment

Production is served by GitHub Pages from the `main` branch. The normal workflow is:

1. Prepare and review website changes on a dedicated branch.
2. Follow the release and pre-publish checks in [WEBSITE_MAINTENANCE.md](WEBSITE_MAINTENANCE.md).
3. Confirm that any release-specific gates in [WEBSITE-BACKLOG.md](WEBSITE-BACKLOG.md) are satisfied, or document an
   explicitly approved temporary difference.
4. Merge the reviewed branch into `main` when the website is ready to publish.
5. GitHub Pages deploys the new `main` revision automatically.
6. Verify the live homepage, all public pages, links, and image assets after deployment.

Coordinate release timing with the iOS app and App Store listing. A temporary difference is acceptable only when it is intentional, documented, and assigned a follow-up check.

## Repository documentation

- [WEBSITE_MAINTENANCE.md](WEBSITE_MAINTENANCE.md) is the authoritative website release checklist and messaging guide. It covers ownership, approved terminology, page responsibilities, screenshots, cross-surface synchronization, and production verification.
- [WEBSITE-BACKLOG.md](WEBSITE-BACKLOG.md) tracks website-only follow-ups, prepared release changes, and conditions that must be met before those changes are published.

Application architecture, implementation decisions, product vision, product plans, and the application backlog belong in the [iOS application repository](https://github.com/SaviorOneZero/not-there-yet-ios), not in these website documents.
