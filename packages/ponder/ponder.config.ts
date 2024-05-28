import { createConfig } from "@ponder/core";
import { http } from "viem";
import deployedContracts from "../nextjs/contracts/deployedContracts";
import scaffoldConfig from "../nextjs/scaffold.config";
import * as chains from "viem/chains";

const targetNetwork = scaffoldConfig.targetNetworks[0];

const networks = {
  [targetNetwork.name]: {
    chainId: targetNetwork.id,
    transport: http(process.env[`PONDER_RPC_URL_${targetNetwork.id}`]),
  },
};

console.log("networks", networks);

const contractNames = Object.keys(deployedContracts[targetNetwork.id]);

const contracts = Object.fromEntries(contractNames.map((contractName) => {
  return [contractName, {
    network: targetNetwork.name as string,
    abi: deployedContracts[targetNetwork.id][contractName].abi,
    address: deployedContracts[targetNetwork.id][contractName].address,
    startBlock: deployedContracts[targetNetwork.id][contractName].startBlock || 0,
  }];
}));

console.log("contracts", contracts);

export default createConfig({
  networks: networks,
  contracts: contracts,
});

