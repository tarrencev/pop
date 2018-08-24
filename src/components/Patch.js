import React from "react";
import styled from "styled-components";

import img from "./img.jpg";

const StyledImage = styled.img`
  width: 400px;
  margin: 10px;
`;

export default () => <StyledImage src={img} />;
