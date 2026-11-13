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
- [x] New profile photo does not save in Workspace Studio: Studio uploads as workspace-logo, /api/public/avatar reads via rout_public_avatar (db/0251 live on Neon, public read verified)
- [ ] Workspace logos: prune keeps every photo still in use (db/0252 rout_prune_avatar_uploads, code + tests done); apply db/0252 on Neon, until then nothing is pruned
- [x] Workspace conversion: workspaces.avatar_url set from the live design's photo (conversionWorkspaceLogo)
- [ ] Converted workspace logo stored in the Neon fallback still belongs to the retired login (cascade on a hard user delete); copy it into the workspace owner's uploads if hard deletes are ever enabled
- [x] "ROUT OS v2.5 Alle systemen operationeel" overlaps bottom preview buttons on phone; check similar overlaps

- [x] 0247 hardening (live on Neon, verified): constant-time activation-hash compare, SERIALIZABLE + retry for consume/activate, deny-all RLS on vault_enclave (review before apply)
- [x] Station file v2: correct NDEF offsets, encrypted UID+counter, ChangeFileSettings payload
- [x] Key delivery to the personalisation station: HPKE P-256 sealed bundle (0248 live)
- [x] Station registry (0248) + HPKE-wrapped batch key export on /admin/cards, logged via mark_sdm_batch_exported
- [x] db/0249 (drop station-less export marker) moved into db/ after production reported 0248
- [ ] db/0250 card tap as step-up factor (EXPAND): in db/, not yet applied on Neon (last applied: 0249)
