import { ponder } from "@/generated";

ponder.on("YourCollectible:Transfer", async ({ event, context }) => {
  const { client } = context;
  const { Account, Token, TransferEvent } = context.db;
  const { YourCollectible } = context.contracts;

  const tokenId = `OptimisticLoogie:${event.args.tokenId.toString()}`;

  const tokenUri = await client.readContract({
    abi: YourCollectible.abi,
    address: YourCollectible.address,
    functionName: "tokenURI",
    args: [event.args.tokenId],
  });

  // Create an Account for the sender, or update the balance if it already exists.
  await Account.upsert({
    id: event.args.from,
  });

  // Create an Account for the recipient, or update the balance if it already exists.
  await Account.upsert({
    id: event.args.to,
  });

  // Create or update a Token.
  await Token.upsert({
    id: tokenId,
    create: {
      ownerId: event.args.to,
      tokenURI: tokenUri,
      kind: "OptimisticLoogie",
    },
    update: {
      ownerId: event.args.to,
    },
  });

  // Create a TransferEvent.
  await TransferEvent.create({
    id: event.log.id,
    data: {
      fromId: event.args.from,
      toId: event.args.to,
      tokenId: tokenId,
      timestamp: Number(event.block.timestamp),
    },
  });
});
