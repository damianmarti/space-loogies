import { createSchema } from "@ponder/core";

export default createSchema((p) => ({
  Account: p.createTable({
    id: p.hex(),
    tokens: p.many("Token.ownerId"),

    transferFromEvents: p.many("TransferEvent.fromId"),
    transferToEvents: p.many("TransferEvent.toId"),
  }),
  Token: p.createTable({
    id: p.string(),
    idNumber: p.bigint(),
    tokenURI: p.string(),
    ownerId: p.hex().references("Account.id"),
    kind: p.string(),
    speed: p.bigint().optional(),
    kms: p.bigint().optional(),
    lastSpeedUpdate: p.bigint().optional(),
    loogieId: p.bigint().optional(),
    fancyLoogieId: p.bigint().optional(),
    spaceshipMinted: p.boolean().optional(),
    free: p.boolean().optional(),

    owner: p.one("ownerId"),
    transferEvents: p.many("TransferEvent.tokenId"),
  }),
  TransferEvent: p.createTable({
    id: p.string(),
    timestamp: p.int(),
    fromId: p.hex().references("Account.id"),
    toId: p.hex().references("Account.id"),
    tokenId: p.string().references("Token.id"),

    from: p.one("fromId"),
    to: p.one("toId"),
    token: p.one("tokenId"),
  }),
}));
