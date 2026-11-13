-- 0253 (EXPAND): a member revokes their own physical ROUT Cards.
--  * Called when the member blocks their ROUT card as lost or replaces it, so a
--    lost chip stops being a sign-in or step-up factor at once (consume_sdm_tap
--    refuses revoked cards, member_card_factor no longer counts them).
--  * Open card step-up intents of the caller expire in the same transaction.
--  * The caller always comes from the transaction context; nothing is trusted
--    from arguments. Every call lands on the hash-chained audit log.
-- Additive only: one new function, executable by rout_app alone.

create function vault_enclave.revoke_member_cards()
returns integer language plpgsql security definer set search_path = pg_catalog as $$
declare
  v_now timestamptz := pg_catalog.clock_timestamp();
  v_caller uuid := vault_enclave.caller_user_id();
  v_n integer;
begin
  if v_caller is null then
    perform vault_enclave.append_audit(null, 'sdm_card_revoke', 'denied', 'no_caller', null); return 0;
  end if;
  update vault_enclave.sdm_batch_cards set revoked_at = v_now
   where owner_user_id = v_caller and revoked_at is null;
  get diagnostics v_n = row_count;
  update vault_enclave.card_step_up_intents set expires_at = v_now
   where user_id = v_caller and claimed_at is null and expires_at > v_now;
  perform vault_enclave.append_audit(v_caller, 'sdm_card_revoke', 'granted', 'cards:' || v_n::text, null);
  return v_n;
end $$;

revoke all on function vault_enclave.revoke_member_cards() from public, rout_app;
grant execute on function vault_enclave.revoke_member_cards() to rout_app;
