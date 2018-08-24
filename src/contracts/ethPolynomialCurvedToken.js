import ReduxSagaWeb3EthContract from "redux-saga-web3-eth-contract";
import { TimedCurvedNifty } from "@nifty-supply/contracts";

ReduxSagaWeb3EthContract.setProvider(window.web3.currentProvider);

const instance = new ReduxSagaWeb3EthContract(
  "TimedCurvedNifty",
  TimedCurvedNifty.abi,
  { at: TimedCurvedNifty.networks["15"].address }
);

const { contract, types, actions, reducer, selectors, saga } = instance;
export { contract, types, actions, reducer, selectors, saga };
