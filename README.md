# GitHub Pages hosting

See [GITHUB_PAGES.md](GITHUB_PAGES.md) for one-click-on-push deployment instructions.

# Padel Alliance v0.4 — Explore + Social & Club Hub

Preserves the v0.3 newcomer Explore landing page and returning-player Home dashboard. Adds an independent Social & Club Hub accessible from the header or the top of the page.

## Run
```sh
npm install
npm run dev
```

## Features
Explore: original city/club discovery, availability and booking demo. Home: original returning-player dashboard, quick rebooking and sharing.

Social & Club Hub: games and RSVP, waitlists, shareable link preview, recurring flag, nearby player discovery (opt-in design), match suggestions, private circles, WhatsApp share, WeChat copy workflow, local chat, play-again entry points, results, league leaderboard, rewards, club onboarding and court blocks, simulated payment splits, city ambassador referral codes, player skill profiles and integration notes.

**Important:** This is an offline-capable frontend prototype using localStorage. It does not offer real authentication, shared inventory, cross-device persistence, real-time messages, external notifications, or actual payments. Social sign-in and payments require credentials, backend services and market-specific review. No actual booking is placed.

## Backend
See `backend/schema.sql` and `backend/PRODUCTION_PLAN.md` for a relational starting model, security requirements, deployment sequence, and 10 additional operator features. SQL is illustrative, not production-ready or safe to expose without RLS and exclusion constraints.

## v0.5: Operator workflows 21–30

In **Member Hub → Club ops**, an additional operator workbench now provides interactive local demos for dynamic pricing, maintenance downtime, staff roles, POS/rentals, coaching, cancellation/deposit policies, revenue ledger with CSV export, simulated check-in, operational metrics, and external booking import staging. All ten workflows save to browser localStorage under `padel-operator-v05` and are separate from the existing v0.4 club sandbox.

**Not production connected:** Staff roles are not enforced; pricing is not applied to live bookings; downtime and lessons do not reserve inventory; POS and ledger do not charge or reconcile money; check-in does not validate QR codes; sync staging does not communicate with external systems. Server-side permissions, audit logs, booking conflict exclusion constraints, gateway webhooks, and provider adapters are necessary before real club deployment.
