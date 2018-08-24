import React from "react";
import ReactDOM from "react-dom";
import { Provider as ReduxProvider } from "react-redux";
import createHistory from "history/createBrowserHistory";

import { ConnectedRouter } from "connected-react-router/immutable";
import { defaultTheme } from "smooth-ui";
import { ThemeProvider } from "styled-components";

// Redux Store
import createStore from "./store";

import "./index.css";
import App from "./App";

// Create a history
const history = createHistory();
const store = createStore(history);

const theme = {
  ...defaultTheme,
  primary: "#e3241e"
};

ReactDOM.render(
  <ReduxProvider store={store}>
    <ConnectedRouter history={history}>
      <ThemeProvider theme={theme}>
        <App />
      </ThemeProvider>
    </ConnectedRouter>
  </ReduxProvider>,
  document.getElementById("root")
);
