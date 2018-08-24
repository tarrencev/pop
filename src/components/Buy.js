import React from "react";
import styled from "styled-components";
import { Button } from "smooth-ui";

const StyledBuy = styled.div`
  display: flex;
  justify-content: center;
  font-size: 16px;
  width: 400px;
  margin: 15px 0;
`;

export default ({ buyToken, priceToMint }) => (
  <StyledBuy>
    <Button onClick={() => buyToken(priceToMint)}>claim patch</Button>
  </StyledBuy>
);
