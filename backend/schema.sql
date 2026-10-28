-- Starter relational model for a future Supabase/Postgres backend.
-- DESIGN REFERENCE ONLY: review RLS, access controls, and migrations before deploying.
create extension if not exists pgcrypto;
create table cities(id uuid primary key default gen_random_uuid(), name text not null, country_code char(2) not null, timezone text not null, currency char(3) not null);
create table clubs(id uuid primary key default gen_random_uuid(), city_id uuid references cities(id), name text not null, owner_id uuid not null, status text not null default 'pending');
create table courts(id uuid primary key default gen_random_uuid(), club_id uuid not null references clubs(id), name text not null, active boolean not null default true);
create table profiles(user_id uuid primary key, display_name text, city_id uuid references cities(id), skill_level text, discovery_opt_in boolean not null default false);
create table games(id uuid primary key default gen_random_uuid(), host_id uuid not null, court_id uuid references courts(id), starts_at timestamptz not null, ends_at timestamptz not null, max_players int not null default 4, visibility text not null default 'public', recurrence_rule text);
create table game_players(game_id uuid references games(id), user_id uuid not null, status text not null check(status in ('invited','accepted','declined','waitlisted')), primary key(game_id,user_id));
create table invitations(id uuid primary key default gen_random_uuid(), game_id uuid not null references games(id), token_hash text not null unique, expires_at timestamptz, revoked_at timestamptz);
create table bookings(id uuid primary key default gen_random_uuid(), court_id uuid not null references courts(id), user_id uuid not null, starts_at timestamptz not null, ends_at timestamptz not null, status text not null check(status in ('held','confirmed','cancelled','expired')), hold_expires_at timestamptz);
create table payment_orders(id uuid primary key default gen_random_uuid(), booking_id uuid references bookings(id), provider text, provider_reference text, amount_minor bigint not null, currency char(3) not null, status text not null, idempotency_key text unique);
create table payment_shares(id uuid primary key default gen_random_uuid(), payment_order_id uuid references payment_orders(id), payer_id uuid not null, amount_minor bigint not null, status text not null);
create table circles(id uuid primary key default gen_random_uuid(), owner_id uuid not null, name text not null, private boolean not null default true);
create table circle_members(circle_id uuid references circles(id), user_id uuid not null, role text not null default 'member', primary key(circle_id,user_id));
create table chat_messages(id uuid primary key default gen_random_uuid(), circle_id uuid references circles(id), sender_id uuid not null, body text not null, created_at timestamptz not null default now());
create table inventory_blocks(id uuid primary key default gen_random_uuid(), court_id uuid references courts(id), starts_at timestamptz not null, ends_at timestamptz not null, reason text not null);
create table audit_events(id uuid primary key default gen_random_uuid(), actor_id uuid, club_id uuid references clubs(id), action text not null, entity_type text not null, entity_id uuid, created_at timestamptz default now(), metadata jsonb default '{}');
-- Critical implementation: enforce overlapping booking exclusion using tstzrange/GiST
-- for active bookings, with transactions, expiry of holds and inventory blocks.
-- All tables require row-level security policies before API exposure.
