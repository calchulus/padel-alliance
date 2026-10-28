# Padel Alliance — production backend blueprint

This release is a client-side demo. Do not connect real payments or expose production user data without implementing the safeguards below.

## Architecture
Next.js or existing Vite React frontend -> authenticated server API -> PostgreSQL (Supabase) -> realtime subscription channel -> payment provider adapters -> webhooks -> notifications/jobs.

## Implementation sequence
1. Set up migrations, tenant isolation, Supabase Auth email OTP, Google and Apple, account linking, GDPR/privacy consent, admin/staff roles and RLS. WeChat requires its own approved OAuth flow; WhatsApp should be treated primarily as an invitation transport, not a universal login provider.
2. Implement transactional booking holds with expiration and database-level exclusion constraints. Check maintenance blocks and external inventory, then commit booking after verified payment webhook. Never trust client availability.
3. Persist games and invitation tokens server-side; generate expiring/revocable links, allow guest preview, require auth only to RSVP. Add rate limits, abuse reporting and invite privacy.
4. Implement RSVP state machine, waitlists, atomic promotion, notification preferences, cancellation windows, recurrence expansion with timezones/DST, and a durable queue.
5. Build payment adapter interfaces per jurisdiction; Stripe Connect where supported, local processors elsewhere. Implement webhook signature validation, idempotency, ledger entries, partial refunds, chargebacks, split collection, payout reconciliation and taxes. No money movement in demo.
6. Add social graph, opt-in location discovery with coarse granularity, moderation, blocking, messaging authorization, retention/deletion controls, and youth safeguards if relevant.
7. Implement club operations: staff RBAC, maintenance, price rules, coaches, POS, cancellation policies, accounting, access control, analytics, external booking connectors. Keep immutable audit logs.
8. Add observability, backups, disaster recovery, load tests, security review, data residency and legal review for each launch market.

## Ten extra operator features (21–30)
21. Dynamic pricing and yield management.
22. Court maintenance, inspections and downtime.
23. Staff shifts, roles, permissions and approval flows.
24. POS, merchandise and equipment rental inventory.
25. Coaches, lessons and clinic scheduling.
26. Deposits, cancellation fees, no-show handling and refunds.
27. Settlement ledger, taxes, payout reconciliation and accounting exports.
28. QR check-in and optional smart-lock access integrations.
29. Court-hour utilization, revenue, retention and demand forecasts.
30. Two-way sync with incumbent club booking/PMS software, including conflict resolution.

## Integration status
- Email/Google/Apple/WeChat: planned; not live.
- WhatsApp: share URL opens the WhatsApp sharing endpoint; no message is sent automatically.
- Payment splitting: simulated local transaction states; no charges.
- Realtime availability: prototype only; local court blocks do not propagate to other devices.
- Invites: browser-local game records; link recipient needs shared backend.
- Messaging: browser-local; no cross-user delivery.
- Leagues and rewards: illustrative data, no verified ranking or monetary benefits.

## Production acceptance criteria
Two simultaneous users cannot confirm the same court/time; all booking state transitions are idempotent; invite links work on a fresh device; a guest can preview without login; payment webhooks reconcile to ledger; users cannot read another club's private data; messaging and discovery respect privacy; recurring games survive DST; cancellations and waitlist promotions are transactional; clubs can reconcile daily payouts.
