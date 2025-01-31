import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Can join community",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const user = accounts.get("wallet_1")!;
    const block = chain.mineBlock([
      Tx.contractCall(
        "community",
        "join-community",
        [],
        user.address
      )
    ]);
    assertEquals(block.receipts[0].result.expectOk(), true);
  }
});
