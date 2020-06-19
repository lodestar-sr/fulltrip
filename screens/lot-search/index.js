import React from "react";
import { View } from "react-native";
import SearchCard from "../../components/search-card";
import HeaderComponent from "../../components/header";

import { COLORS } from "../../styles/colors.js";
import firebase from "../../firebase";

export default class LotSearch extends React.Component {

  state = {
    user: {},
  };

  constructor(props) {
    super(props);
  }

  componentDidMount() {
    // firebase.auth().onAuthStateChanged((user) => {
    //   if (user) {
    //     this.setState({user: user});
    //   } else {
    //     this.props.navigation.navigate('SignIn');
    //   }
    // });
  }

  viewLotDetails = (data) => {
    this.props.navigation.navigate("LotDetails", { data });
  };

  openMenu = (menu) => {
    this.props.navigation.navigate(menu);
  };

  render() {
    return (
      <View>
        <HeaderComponent
          shadow={false}
          title="Recherche"
          iconLeft="menu"
          headerBackgroundColor={COLORS.primary}
          headerTextColor={"#FFF"}
          iconLeftOnPress={this.props.navigation.openDrawer}
        />
        <SearchCard viewLotDetails={this.viewLotDetails} openMenu={this.openMenu} />
      </View>
    );
  }
}
