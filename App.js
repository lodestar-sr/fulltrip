import "react-native-gesture-handler";
import React from "react";
import "./firebase.js";
import {Button, Icon, StyleProvider, View, Text} from "native-base";
import getTheme from "./native-base-theme/components";
import material from "./native-base-theme/variables/material";
import store from "./store";
import {Provider} from "react-redux";
import {AppLoading} from "expo";
import * as Font from "expo-font";
import {Feather, FontAwesome, Ionicons} from "@expo/vector-icons";
import {createBottomTabNavigator} from "@react-navigation/bottom-tabs";
import {NavigationContainer} from "@react-navigation/native";
import SearchLot from "./screens/search-lot";

import {decode, encode} from 'base-64'
import {COLORS} from "./styles/colors";
import {createStackNavigator} from "@react-navigation/stack";
import Home from "./screens/home";
import LotFilters from "./screens/lot-filters";

if (!global.btoa) {
  global.btoa = encode
}

if (!global.atob) {
  global.atob = decode
}

const MainTab = createBottomTabNavigator();
const HomeStack = createStackNavigator();

function HomeStackScreen() {
  return <HomeStack.Navigator>
    <HomeStack.Screen name="Home" component={Home}/>
    <HomeStack.Screen name="LotFilters" component={LotFilters}/>
  </HomeStack.Navigator>;
}

const SearchStack = createStackNavigator();

function SearchStackScreen() {
  return <SearchStack.Navigator>
    <SearchStack.Screen name="Search" component={SearchLot}/>
  </SearchStack.Navigator>;
}

const MessageStack = createStackNavigator();

function MessageStackScreen() {
  return <MessageStack.Navigator>
    <MessageStack.Screen name="Message" component={SearchLot}/>
  </MessageStack.Navigator>;
}

const ProfileStack = createStackNavigator();

function ProfileStackScreen() {
  return <ProfileStack.Navigator>
    <ProfileStack.Screen name="Profile" component={SearchLot}/>
  </ProfileStack.Navigator>;
}

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
    this.setState({isReady: true});
  }

  addEvent = () => {
    console.log("Add an event");
  };

  render() {
    if (!this.state.isReady) {
      return <AppLoading/>;
    }

    return (
      <Provider store={store}>
        <StyleProvider style={getTheme(material)}>
          <View style={{flex: 1}}>
            <NavigationContainer>
              {/*<Drawer.Navigator initialRouteName="LotFilters">*/}
              {/*  <Drawer.Screen name="SearchLot" component={SearchLot} />*/}
              {/*  <Drawer.Screen name="Proposer un lot" component={CreateLot} />*/}
              {/*  <Drawer.Screen name="LotDetails" component={LotDetails} />*/}
              {/*  <Drawer.Screen*/}
              {/*    name="SignIn"*/}
              {/*    component={SignIn}*/}
              {/*    options={{*/}
              {/*      headerShown: false,*/}
              {/*    }}*/}
              {/*  />*/}
              {/*  <Drawer.Screen*/}
              {/*    name="SignUp"*/}
              {/*    component={SignUp}*/}
              {/*    options={{*/}
              {/*      headerShown: false,*/}
              {/*    }}*/}
              {/*  />*/}
              {/*  <Drawer.Screen name="LotFilters" component={LotFilters} />*/}
              {/*</Drawer.Navigator>*/}

              <MainTab.Navigator
                screenOptions={({route}) => ({
                  tabBarIcon: ({focused, color, size}) => {
                    let iconName;
                    color = focused ? color : COLORS.dfdede;
                    if (route.name === 'Home') {
                      iconName = 'home';
                      color = focused ? color : COLORS.dfdede;
                      return <Feather name={iconName} size={size} color={color}/>;
                    } else if (route.name === 'Search') {
                      iconName = 'search';
                      return <FontAwesome name={iconName} size={size} color={color}/>;
                    } else if (route.name === 'Add') {
                      return <View>
                        <Button rounded
                                style={{
                                  backgroundColor: COLORS.sky,
                                  borderWidth: 4,
                                  borderColor: 'white',
                                  width: 60, height: 60,
                                  borderRadius: 30
                                }}
                        >
                          <Icon name="add" style={{fontSize: 30, color: 'white'}}/>
                        </Button>
                      </View>;
                    } else if (route.name === 'Message') {
                      iconName = 'ios-chatboxes';
                      return <Ionicons name={iconName} size={size} color={color}/>;
                    } else if (route.name === 'Profile') {
                      iconName = 'user';
                      return <FontAwesome name={iconName} size={size} color={color}/>;
                    }
                  },
                  tabBarLabel: ({focused, color}) => {
                    if (route.name === 'Add') {
                      return null;
                    } else {
                      return <Text style={{
                        color: color,
                        fontSize: 10,
                      }}>{route.name}</Text>
                    }
                  }
                })}
                tabBarOptions={{
                  activeTintColor: COLORS.sky,
                  inactiveTintColor: COLORS.lightGray,
                  style: {
                    height: 100,
                    paddingTop: 12,
                  }
                }}
              >
                <MainTab.Screen name="Home" component={HomeStackScreen}/>
                <MainTab.Screen name="Search" component={SearchStackScreen}/>
                <MainTab.Screen name="Add" component={SearchLot}/>
                <MainTab.Screen name="Message" component={MessageStackScreen}/>
                <MainTab.Screen name="Profile" component={ProfileStackScreen}/>
              </MainTab.Navigator>
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
  main: {paddingLeft: 3, backgroundColor: "#000000"},
};
