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

import { NavigationContainer } from "@react-navigation/native";
import {
  createStackNavigator,
  CardStyleInterpolators,
} from "@react-navigation/stack";

import FooterTabComponent from "./components/footer-tab";

import Dashboard from "./screens/dashboard";
import CreateMatch from "./screens/create-match";
import MatchDetails from "./screens/match-details";
import SearchMatch from "./screens/search-match";
import Menu from "./screens/menu";
import SignIn from "./screens/signin";
import SignUp from "./screens/signup";

import { COLORS } from "./styles/colors";

const Stack = createStackNavigator();

const animationConfig = {
  animation: "spring",
  config: {
    stiffness: 1000,
    damping: 500,
    mass: 3,
    overshootClamping: false,
    restDisplacementThreshold: 0.01,
    restSpeedThreshold: 0.01,
  },
};

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
              <Stack.Navigator
                initialRouteName="SignUp"
                screenOptions={{
                  headerTintColor: "#FFF",
                  gestureEnabled: true,
                  gestureDirection: "horizontal",
                  headerStyle: {
                    backgroundColor: COLORS.primary_dark,
                    shadowColor: "#000",
                    elevation: 10,
                  },
                }}
              >
                <Stack.Screen
                  name="SearchMatch"
                  component={SearchMatch}
                  options={({ navigation: { navigate } }) => ({
                    headerTitle: "Rechercher un match",
                    headerLeft: () => (
                      <Button
                        onPress={() => {
                          navigate("Menu");
                        }}
                        style={{
                          backgroundColor: "transparent",
                          elevation: 0,
                        }}
                      >
                        <Icon
                          name="menu"
                          underlayColor="transparent"
                          style={{ paddingTop: 5, color: "#FFF" }}
                        />
                      </Button>
                    ),
                    headerRight: () => (
                      <Button
                        onPress={() => {
                          navigate("Menu");
                        }}
                        style={{
                          backgroundColor: "transparent",
                          elevation: 0,
                        }}
                      >
                        <Icon
                          name="more"
                          underlayColor="transparent"
                          style={{ paddingTop: 5, color: "#FFF" }}
                        />
                      </Button>
                    ),
                  })}
                />
                <Stack.Screen name="Dashboard" component={Dashboard} />
                <Stack.Screen name="CreateMatch" component={CreateMatch} />
                <Stack.Screen name="MatchDetails" component={MatchDetails} />
                <Stack.Screen
                  name="SignIn"
                  component={SignIn}
                  options={{
                    headerShown: false,
                  }}
                />
                <Stack.Screen
                  name="SignUp"
                  component={SignUp}
                  options={{
                    headerShown: false,
                  }}
                />
                <Stack.Screen
                  name="Menu"
                  component={Menu}
                  options={{
                    transitionSpec: {
                      open: animationConfig,
                      close: animationConfig,
                    },
                    cardStyleInterpolator:
                      CardStyleInterpolators.forHorizontalIOS,
                  }}
                />
              </Stack.Navigator>
            </NavigationContainer>
          </View>
        </StyleProvider>
      </Provider>
    );
  }
}
