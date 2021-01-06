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
])(new providers.JsonRpcProvider(process.env.RPC_URL));

export { ContractInterface, ContractConfig }