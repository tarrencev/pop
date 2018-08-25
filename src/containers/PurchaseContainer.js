import { connect } from "react-redux";
import { compose, lifecycle } from "recompose";
import Web3Utils from "web3-utils";

import { actions, selectors } from "../contracts/ethPolynomialCurvedToken";

import Purchase from "../components/Purchase";

const mapStateToProps = (state, props) => {
  const priceToMintOne = selectors.methods.priceToMint()(state, 1);
  const priceToMintTwo = selectors.methods.priceToMint()(state, 2);
  const endTime = selectors.methods.getEndTime()(state);

  return {
    priceToMint:
      priceToMintOne && priceToMintOne.get("phase") === "SUCCESS"
        ? new Web3Utils.BN(priceToMintOne.get("value"))
        : null,
    priceToMintNext:
      priceToMintOne &&
      priceToMintOne.get("phase") === "SUCCESS" &&
      priceToMintTwo &&
      priceToMintTwo.get("phase") === "SUCCESS"
        ? new Web3Utils.BN(priceToMintTwo.get("value")).sub(
            new Web3Utils.BN(priceToMintOne.get("value"))
          )
        : null,
    endTime:
      endTime && endTime.get("phase") === "SUCCESS"
        ? endTime.get("value")
        : null
  };
};

const mapDispatchToProps = (dispatch, props) => ({
  buyToken: priceToMint =>
    dispatch(actions.methods.mint({ value: priceToMint }).send(1)),
  fetchPriceToMintOne: () => dispatch(actions.methods.priceToMint().call(1)),
  fetchPriceToMintTwo: () => dispatch(actions.methods.priceToMint().call(2)),
  fetchEndTime: () => dispatch(actions.methods.getEndTime().call())
});

export default compose(
  connect(
    mapStateToProps,
    mapDispatchToProps
  ),
  lifecycle({
    componentDidMount() {
      this.props.fetchPriceToMintOne();
      this.props.fetchPriceToMintTwo();
      this.props.fetchEndTime();
    }
  })
)(Purchase);
