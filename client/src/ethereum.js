import detectEthereumProvider from "@metamask/detect-provider";
import { ethers, Contract } from "ethers";
import Todo from "./artifacts/contracts/Todo.sol/Todo.json";

const getBlockchain = () =>
    new Promise(async (resolve, reject) => {
        let provider = await detectEthereumProvider();
        if (provider) {
            await provider.request({ method: "eth_requestAccounts" });
            //const networkId = await provider.request({ method: "net_version" });
            provider = new ethers.providers.Web3Provider(provider);
            const signer = provider.getSigner();
            const todo = new Contract("0x5FbDB2315678afecb367f032d93F642f64180aa3", Todo.abi, signer);
            resolve({ todo });
            return;
        }
        reject("Install Metamask");
    });

export default getBlockchain;
