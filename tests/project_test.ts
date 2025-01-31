import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Can create new project",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get("deployer")!;
    const block = chain.mineBlock([
      Tx.contractCall(
        "project",
        "create-project",
        [
          types.utf8("Test Project"),
          types.utf8("A test sustainability project"),
          types.uint(1000)
        ],
        deployer.address
      )
    ]);
    assertEquals(block.receipts[0].result.expectOk(), "u0");
    assertEquals(block.height, 2);
  }
});
