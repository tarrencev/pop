import React, { Component } from "react";
import styled from "styled-components";
import { actions } from "redux-saga-web3";
import { connect } from "react-redux";
import { compose, lifecycle } from "recompose";

import Patch from "./components/Patch";
import PurchaseContainer from "./containers/PurchaseContainer";

const StyledApp = styled.div`
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
`;

class App extends Component {
  render() {
    return (
      <StyledApp>
        <Patch />
        <PurchaseContainer />
      </StyledApp>
    );
  }
}

const mapDispatchToProps = dispatch => ({
  getAccounts: () => dispatch(actions.accounts.getRequest()),
  getLatestBlock: () => dispatch(actions.blocks.getBlockHeader("latest"))
});

export default compose(
  connect(
    () => ({}),
    mapDispatchToProps
  ),
  lifecycle({
    componentDidMount() {
      this.props.getAccounts();
      this.props.getLatestBlock();
    }
  })
)(App);
