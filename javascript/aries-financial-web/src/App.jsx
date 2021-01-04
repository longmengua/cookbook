import {Web3Provider} from "react-web3";
import React, { Component } from 'react';
import { createMuiTheme, MuiThemeProvider } from '@material-ui/core/styles';
import {
  Switch,
  Route,
  BrowserRouter
} from "react-router-dom";

import './i18n';
import interestTheme from './theme';
import { injected } from "./stores/connectors";

import {
  CONNECTION_CONNECTED, CONNECTION_DISCONNECTED,
} from './constants'

import Store from "./stores";


import Footer from './components/footer';
import Header from './components/header';
import Farming from './components/farming/farming';
import Stake from "./components/stake";
import Splash from "./components/splash/splash";
import Video from "./components/video/video";
import EditTokenPanel from "./components/addToken/EditTokenPanel";
import AddTokenPanel from "./components/addToken/AddTokenPanel";
import {
  CONFIGURE,
} from "./constants/constants-extension";
import Account from "./components/account";

const emitter = Store.emitter;
const store = Store.store;
const dispatcher = Store.dispatcher

// todo: @note this is for the router enum, centralized management.
export const pathEnum = {
  splash: '/',
  introduction: '/introduction',
  farming: '/farming',
  stake: '/stake',
  addToken: '/addToken',
  editToken: '/editToken',
  buyToken: '/buyToken',
};

class App extends Component {
  // todo: @note for globally update page using, like day or night mode switching
  updateUI = () => this.setState({});

  state = {
    account: null,
  };

  componentWillMount() {
    emitter.on(CONNECTION_CONNECTED, this.connectionConnected);
    emitter.on(CONNECTION_DISCONNECTED, this.connectionDisconnected);

    injected.isAuthorized().then(isAuthorized => {
      if (isAuthorized) {
        injected.activate()
            .then((a) => {
              store.setStore({ account: { address: a.account }, web3context: { library: { provider: a.provider } } })
              emitter.emit(CONNECTION_CONNECTED)

            })
            .catch((e) => {
              console.error(e)
            })
      } else {

      }
    });
  }

  componentWillUnmount() {
    emitter.removeListener(CONNECTION_CONNECTED, this.connectionConnected);
    emitter.removeListener(CONNECTION_DISCONNECTED, this.connectionDisconnected);
  };

  connectionConnected = () => {
    this.setState({ account: store.getStore('account') })
    dispatcher.dispatch({ type: CONFIGURE, content: {} })
  };

  connectionDisconnected = () => {
    this.setState({ account: store.getStore('account') })
  };



  detectWallet = (account) => {
    return <>
      { !account &&
      <div style={{
        display: 'flex',
        flexDirection: 'column',
        minHeight: '100vh',
        minWidth: '100vw',
        justifyContent: 'center',
        alignItems: 'center',
        background: "#f9fafb"
      }}>
        <Account />
      </div>
      }
    </>
  };

  render() {
    return !this.state.account ? this.detectWallet(this.state.account) : (
      <div style={{display: "flex", flexDirection: "column"}}>
        <MuiThemeProvider theme={ createMuiTheme(interestTheme) }>
          <BrowserRouter>
            <Switch>
                <Route path={pathEnum.introduction} exact={true}>
                  <Header updateUIFunc={this.updateUI}/>
                  <Video />
                  <Footer />
                </Route>
                <Route path={pathEnum.splash} exact={true}>
                  <Splash />
                </Route>
                <Route path={pathEnum.farming} exact={true}>
                  <Header updateUIFunc={this.updateUI}/>
                  <Farming />
                  <Footer />
                </Route>
                <Route path={pathEnum.stake} exact={true}>
                  <Header updateUIFunc={this.updateUI}/>
                  <Stake />
                  <Footer />
                </Route>
                <Route path={pathEnum.addToken} exact={true}>
                  <Header updateUIFunc={this.updateUI}/>
                    <AddTokenPanel />
                  <Footer />
                </Route>
                <Route path={pathEnum.editToken} exact={true}>
                    <EditTokenPanel />
                </Route>
            </Switch>
          </BrowserRouter>
        </MuiThemeProvider>
      </div>
    );
  }
}

export default App;
