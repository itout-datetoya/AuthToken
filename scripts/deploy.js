const hre = require("hardhat");

async function main() {
  const Factory = await hre.ethers.getContractFactory("Registry");
  const contract = await Factory.deploy();
  await contract.deployed();

  console.log("Contract deployed to:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });