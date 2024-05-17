import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

/**
 * Deploys a contract named "YourContract" using the deployer account and
 * constructor arguments set to the deployer address
 *
 * @param hre HardhatRuntimeEnvironment object.
 */
const deployYourContract: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  /*
    On localhost, the deployer account is the one that comes with Hardhat, which is already funded.

    When deploying to live networks (e.g `yarn deploy --network sepolia`), the deployer account
    should have sufficient balance to pay for the gas fees for contract creation.

    You can generate a random account with `yarn generate` which will fill DEPLOYER_PRIVATE_KEY
    with a random private key in the .env file (then used on hardhat.config.ts)
    You can run the `yarn account` command to check your balance in every network.
  */
  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

  const loogies = await deploy("YourCollectible", {
    from: deployer,
    args: [],
    log: true,
    // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
    // automatically mining the contract deployment transaction. There is no effect on live networks.
    autoMine: true,
  });

  // Get the deployed contract to interact with it after deploying.
  // const loogiesContract = await hre.ethers.getContract<Contract>("YourCollectible", deployer);

  const fancyLoogies = await deploy("FancyLoogie", {
    from: deployer,
    args: [loogies.address],
    log: true,
    // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
    // automatically mining the contract deployment transaction. There is no effect on live networks.
    autoMine: true,
  });

  // const fancyLoogiesContract = await hre.ethers.getContract<Contract>("FancyLoogie", deployer);

  const spaceship1Render = await deploy("Spaceship1Render", {
    from: deployer,
    log: true,
    autoMine: true,
  });

  const spaceship2AuxRender = await deploy("Spaceship2AuxRender", {
    from: deployer,
    log: true,
    autoMine: true,
  });

  const spaceship2Render = await deploy("Spaceship2Render", {
    from: deployer,
    log: true,
    autoMine: true,
    libraries: { Spaceship2AuxRender: spaceship2AuxRender.address },
  });

  const spaceship3Render = await deploy("Spaceship3Render", {
    from: deployer,
    log: true,
    autoMine: true,
  });

  const spaceship4Render = await deploy("Spaceship4Render", {
    from: deployer,
    log: true,
    autoMine: true,
  });

  const spaceship5Render = await deploy("Spaceship5Render", {
    from: deployer,
    log: true,
    autoMine: true,
  });

  const propulsion1Render = await deploy("Propulsion1Render", {
    from: deployer,
    log: true,
    autoMine: true,
  });

  const propulsion2Render = await deploy("Propulsion2Render", {
    from: deployer,
    log: true,
    autoMine: true,
  });

  const propulsion3Render = await deploy("Propulsion3Render", {
    from: deployer,
    log: true,
    autoMine: true,
  });

  await deploy("SpaceLoogie", {
    from: deployer,
    args: [loogies.address, fancyLoogies.address, fancyLoogies.address],
    log: true,
    // autoMine: can be passed to the deploy function to make the deployment process faster on local networks by
    // automatically mining the contract deployment transaction. There is no effect on live networks.
    autoMine: true,
    libraries: {
      Spaceship1Render: spaceship1Render.address,
      Spaceship2Render: spaceship2Render.address,
      Spaceship3Render: spaceship3Render.address,
      Spaceship4Render: spaceship4Render.address,
      Spaceship5Render: spaceship5Render.address,
      Propulsion1Render: propulsion1Render.address,
      Propulsion2Render: propulsion2Render.address,
      Propulsion3Render: propulsion3Render.address,
    },
  });

};

export default deployYourContract;

// Tags are useful if you have multiple deploy files and only want to run one of them.
// e.g. yarn deploy --tags YourContract
deployYourContract.tags = ["YourContract"];
