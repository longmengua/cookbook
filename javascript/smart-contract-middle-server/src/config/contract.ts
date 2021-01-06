import {Provider} from "@ethersproject/abstract-provider";
import * as providers from "@ethersproject/providers";

type ContractInterface = {
    id: string,
    decimals: number
    contractAddress: string,
    contractAbi: string,
    provider: Provider,
    address?: string,
    method?: string,
}

const _RPC_URLS = {
    dev: "https://rinkeby.infura.io/v3/e117f524e71d42ec85df7fbdfe2e46e3",
    prod: "https://eth-mainnet.alchemyapi.io/v2/Fzjec9nubY8kwQ7KyCdW--u3B8swwNSg",
};

const ContractConfig: ContractInterface[] = ((_provider: Provider) => [
    {
        id: "",
        provider: _provider,
        decimals: 8,
        contractAddress: "",
        contractAbi: "",
    },
    {
        id: "",
        provider: _provider,
        decimals: 8,
        contractAddress: "",
        contractAbi: "",
    },
    {
        id: "",
        provider: _provider,
        decimals: 8,
        contractAddress: "",
        contractAbi: "",
    },
    {
        id: "",
        provider: _provider,
        decimals: 8,
        contractAddress: "",
        contractAbi: "",
    }
])(new providers.JsonRpcProvider(_RPC_URLS.prod))

export { ContractInterface, ContractConfig }