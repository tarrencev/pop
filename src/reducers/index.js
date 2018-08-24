import { combineReducers } from "redux-immutable";
import { reducers as web3Reducers } from "redux-saga-web3";

import { reducer as ethPolynomialCurvedTokenReducer } from "../contracts/ethPolynomialCurvedToken";

const reducers = combineReducers({
  ...web3Reducers,
  ...ethPolynomialCurvedTokenReducer
});

export default reducers;
