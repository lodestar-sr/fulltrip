import React from "react";
import {View} from "react-native";
import SearchCard from "../../components/search-card";
import HeaderComponent from "../../components/header";

import {COLORS} from "../../styles/colors.js";

export default class Home extends React.Component {

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
    this.props.navigation.navigate("LotDetails", {data});
  };

  openMenu = (menu) => {
    this.props.navigation.navigate(menu);
  };

  render() {
    return (
      <View>
        <SearchCard viewLotDetails={this.viewLotDetails} openMenu={this.openMenu}/>
      </View>
    );
  }
}
