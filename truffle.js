require("babel-register");
require("babel-polyfill");

const PrivateKeyProvider = require("truffle-privatekey-provider");

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    rinkeby: {
      provider: () =>
        new PrivateKeyProvider(
          "5913708418dbd0b0896f8be75a14afdca29dfcc279099d85232d8d3332431f6c",
          "https://rinkeby.infura.io/"
        ),
      network_id: 4
    }
  }
};
