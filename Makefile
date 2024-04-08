-include .env

build:; forge build

deploy-sepolia:
	forge script script/DeployFundMe.s.sol --rpc-url $(SEPOLIA_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERTSCAN_API_KEY)