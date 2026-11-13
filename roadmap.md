# Roadmap

## ROUT Card tap (NTAG 424 DNA) — Batch 1
- [x] db/0245_sdm_tap.sql (EXPAND): fleet MetaRead key, batches, cards by uid_hash, tap attempts, tap grants, RPCs for rout_app only
- [x] sdm-verifier.ts: AN10922 diversification, PICCData decrypt, uid index, constant-time compares + NXP vectors
- [x] sdm-tap.server.ts + vault port methods; PGlite tests as rout_app
- [x] /t public tap page (PICCData only, no card id), "Authentic ROUT Card" badge, replaceState clears query
- [x] schema level 0245, snapshot + db types
## ROUT Card tap — later batches
- [ ] step_up purpose (card_tap method for card_reveal / card_lifecycle)
- [x] Admin batch screen (/admin/cards): create, station config export, manifest import; member activation (db/0246, live on Neon)

## Auth
- [x] Passkey-only registration enforced server-side (user.create hook + bridge refuses members without a passkey)

## Workspace Studio
- [ ] New profile photo does not save in Workspace Studio (e.g. maximilien-6yak): code fixed (Studio uploads as workspace-logo, /api/public/avatar reads via rout_public_avatar); apply db/0251 on Neon to finish
- [ ] Workspace logos: prune only unreferenced workspace-logo uploads (now 3 per member, not per workspace)
- [ ] Workspace conversion: set workspaces.avatar_url from the transferred live Studio photo
- [x] "ROUT OS v2.5 Alle systemen operationeel" overlaps bottom preview buttons on phone; check similar overlaps

- [x] 0247 hardening (live on Neon, verified): constant-time activation-hash compare, SERIALIZABLE + retry for consume/activate, deny-all RLS on vault_enclave (review before apply)
- [x] Station file v2: correct NDEF offsets, encrypted UID+counter, ChangeFileSettings payload
- [x] Key delivery to the personalisation station: HPKE P-256 sealed bundle (0248 live)
- [x] Station registry (0248) + HPKE-wrapped batch key export on /admin/cards, logged via mark_sdm_batch_exported
- [x] db/0249 (drop station-less export marker) moved into db/ after production reported 0248
- [ ] db/0250 card tap as step-up factor (EXPAND): in db/, not yet applied on Neon (last applied: 0249)
