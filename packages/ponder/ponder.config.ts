import { createConfig } from "@ponder/core";
import { http } from "viem";
import deployedContracts from "../nextjs/contracts/deployedContracts";
import externalContracts from "../nextjs/contracts/externalContracts";
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

const deployedContractNames = Object.keys(deployedContracts[targetNetwork.id]);
const externalContractNames = Object.keys(externalContracts[targetNetwork.id]);
const contractNames = [...deployedContractNames, ...externalContractNames];

const contracts = Object.fromEntries(contractNames.map((contractName) => {
  const contractSource = deployedContracts[targetNetwork.id][contractName]
    ? deployedContracts[targetNetwork.id]
    : externalContracts[targetNetwork.id];

  return [contractName, {
    network: targetNetwork.name as string,
    abi: contractSource[contractName].abi,
    address: contractSource[contractName].address,
    startBlock: contractSource[contractName].startBlock || 0,
  }];
}));

console.log("contracts", contracts);

export default createConfig({
  networks: networks,
  contracts: contracts,
});

