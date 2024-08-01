import { ponder } from "@/generated";

ponder.on("SpaceLoogie:Transfer", async ({ event, context }) => {
  const { client } = context;
  const { Account, Token, TransferEvent } = context.db;
  const { SpaceLoogie } = context.contracts;

  const tokenId = `SpaceLoogie:${event.args.tokenId.toString()}`;

  const tokenUri = await client.readContract({
    abi: SpaceLoogie.abi,
    address: SpaceLoogie.address,
    functionName: "tokenURI",
    args: [event.args.tokenId],
  });

  const spaceship = await client.readContract({
    abi: SpaceLoogie.abi,
    address: SpaceLoogie.address,
    functionName: "spaceships",
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
      idNumber: event.args.tokenId,
      tokenURI: tokenUri,
      kind: "SpaceLoogie",
      speed: (spaceship[4] === 0n && spaceship[5] === 0n) ? 0n : 1n,
      kms: 0n,
      lastSpeedUpdate: event.block.number,
      loogieId: spaceship[4],
      fancyLoogieId: spaceship[5],
      free: spaceship[11],
    },
    update: {
      ownerId: event.args.to,
    },
  });

  if (spaceship[4] != 0) {
    await Token.update({
      id: `OptimisticLoogie:${spaceship[4].toString()}`,
      data: {
        spaceshipMinted: true,
      },
    });
  }

  if (spaceship[5] != 0) {
    await Token.update({
      id: `FancyLoogie:${spaceship[5].toString()}`,
      data: {
        spaceshipMinted: true,
      },
    });
  }

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

ponder.on("SpaceLoogie:RenderUpdate", async ({ event, context }) => {
  const { client } = context;
  const { Account, Token, TransferEvent } = context.db;
  const { SpaceLoogie } = context.contracts;

  const tokenId = `SpaceLoogie:${event.args.id.toString()}`;

  const tokenUri = await client.readContract({
    abi: SpaceLoogie.abi,
    address: SpaceLoogie.address,
    functionName: "tokenURI",
    args: [event.args.id],
  });

  // Update a Token.
  await Token.update({
    id: tokenId,
    data: {
      tokenURI: tokenUri,
    },
  });
});

ponder.on("SpaceLoogie:SpeedUpdate", async ({ event, context }) => {
  const { client } = context;
  const { Account, Token, TransferEvent } = context.db;
  const { SpaceLoogie } = context.contracts;

  const tokenId = `SpaceLoogie:${event.args.id.toString()}`;

  // Update a Token.
  await Token.update({
    id: tokenId,
    data: {
      speed: event.args.speed,
      kms: event.args.kms,
      lastSpeedUpdate: event.block.number,
    },
  });
});

