import React from "react";
import styled from "styled-components";
import Web3Utils from "web3-utils";

const StyledPriceContainer = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  font-size: 16px;
  width: 400px;
  margin: 10px 0;
`;

const StyledNextPatch = styled.div`
  color: #b7b7b7;
  margin-top: 5px;
`;

export default ({ priceToMint, priceToMintNext }) => (
  <StyledPriceContainer>
    <div>this patch: {priceToMint && Web3Utils.fromWei(priceToMint)} eth</div>
    <StyledNextPatch>
      next patch: {priceToMintNext && Web3Utils.fromWei(priceToMintNext)} eth
    </StyledNextPatch>
  </StyledPriceContainer>
);
