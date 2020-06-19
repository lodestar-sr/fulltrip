import "react-native-gesture-handler";
import React from "react";
import "./firebase.js";
import { StyleProvider, View, Button, Icon } from "native-base";
import getTheme from "./native-base-theme/components";
import material from "./native-base-theme/variables/material";
import store from "./store";
import { Provider } from "react-redux";
import { AppLoading } from "expo";
import * as Font from "expo-font";
import { Ionicons } from "@expo/vector-icons";
import { createDrawerNavigator } from "@react-navigation/drawer";
import { NavigationContainer } from "@react-navigation/native";

import CreateLot from "./screens/create-lot";
import LotDetails from "./screens/lot-details";
import SearchLot from "./screens/search-lot";
import SignIn from "./screens/signin";
import SignUp from "./screens/signup";
import LotFilters from "./screens/lot-filters";

import {decode, encode} from 'base-64'

if (!global.btoa) {  global.btoa = encode }

if (!global.atob) { global.atob = decode }

import { COLORS } from "./styles/colors";

const Drawer = createDrawerNavigator();

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isReady: false,
    };
  }

  async componentDidMount() {
    await Font.loadAsync({
      Roboto: require("native-base/Fonts/Roboto.ttf"),
      Roboto_medium: require("native-base/Fonts/Roboto_medium.ttf"),
      ...Ionicons.font,
    });
    this.setState({ isReady: true });
  }

  addEvent = () => {
    console.log("Add an event");
  };

  render() {
    if (!this.state.isReady) {
      return <AppLoading />;
    }

    return (
      <Provider store={store}>
        <StyleProvider style={getTheme(material)}>
          <View style={{ flex: 1 }}>
            <NavigationContainer>
              <Drawer.Navigator initialRouteName="SignUp">
                <Drawer.Screen name="SearchLot" component={SearchLot} />
                <Drawer.Screen name="Proposer un lot" component={CreateLot} />
                <Drawer.Screen name="LotDetails" component={LotDetails} />
                <Drawer.Screen
                  name="SignIn"
                  component={SignIn}
                  options={{
                    headerShown: false,
                  }}
                />
                <Drawer.Screen
                  name="SignUp"
                  component={SignUp}
                  options={{
                    headerShown: false,
                  }}
                />
                <Drawer.Screen name="LotFilters" component={LotFilters} />
              </Drawer.Navigator>
            </NavigationContainer>
          </View>
        </StyleProvider>
      </Provider>
    );
  }
}

const drawerStyles = {
  drawer: {
    shadowColor: "#000000",
    shadowOpacity: 0.8,
    shadowRadius: 3,
    backgroundColor: "#000000",
  },
  main: { paddingLeft: 3, backgroundColor: "#000000" },
};
