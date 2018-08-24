import React from "react";
import styled from "styled-components";

import Countdown from "./Countdown";
import Price from "./Price";
import Buy from "./Buy";

export default ({ buyToken, priceToMint, priceToMintNext, endTime }) => (
  <div>
    <Price priceToMint={priceToMint} priceToMintNext={priceToMintNext} />
    <Countdown endTime={endTime} />
    <Buy buyToken={buyToken} priceToMint={priceToMint} />
  </div>
);
