import React from "react";
import { View } from "react-native";
import SearchCard from "../../components/search-card";
import HeaderComponent from "../../components/header";

import { COLORS } from "../../styles/colors.js";

export default class SearchLot extends React.Component {
  constructor(props) {
    super(props);
  }

  viewLotDetails = (data) => {
    this.props.navigation.navigate("LotDetails", { data });
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
        <SearchCard viewLotDetails={this.viewLotDetails}></SearchCard>
      </View>
    );
  }
}
