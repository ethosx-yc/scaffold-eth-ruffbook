// deploy/00_deploy_your_contract.js
const { ethers } = require("hardhat");

const localChainId = "31337";

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();


  await deploy('DSProxyFactory', {
    from: deployer,
    // args: [1661277363],
    log: true,
  });

  const DSProxyFactory = await ethers.getContract('DSProxyFactory', deployer);

  /* await deploy('Lock', {
    from: deployer,
    args: [1661277363],
    log: true,
  }); */

  // const Upgradable = await ethers.getContractFactory('Upgradable');
  // console.log('Deploying Upgradable...');
  // const box = await upgrades.deployProxy(Upgradable, [42], { initializer: 'store' });
  // await box.deployed();
  // console.log('Upgradable deployed to:', box.address);

  // console.log((await box.retrieve()).toString());

  // const UpgradableV2 = await ethers.getContractFactory('UpgradableV2');
  // console.log('Upgrading Upgradable...');
  // await upgrades.upgradeProxy(box.address, UpgradableV2);
  // console.log('Upgradable upgraded');

  // const boxv2 = await UpgradableV2.attach(box.address);

  // console.log((await boxv2.retrieve()).toString());

  // (await boxv2.increment()).wait();
  // console.log((await boxv2.retrieve()).toString());

  // console.log((await boxv2.amap()).toString());
};
module.exports.tags = ['Lock', 'Upgradable'];