import React from "react";

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
