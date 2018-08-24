import React from "react";
import styled from "styled-components";
import Countdown from "react-countdown-now";

const StyledContainer = styled.div`
  display: flex;
  justify-content: center;
  font-size: 16px;
  width: 400px;
  margin: 0 0 15px 0;
`;

const StyledText = styled.span`
  margin-right: 5px;
`;

export default ({ endTime }) => (
  <StyledContainer>
    <StyledText>/ends:</StyledText>
    <Countdown date={parseInt(endTime, 10) * 1000} />
  </StyledContainer>
);
