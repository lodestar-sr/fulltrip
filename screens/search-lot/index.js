import React from "react";
import { View } from "react-native";
import SearchCard from "../../components/search-card";
import HeaderComponent from "../../components/header";
import { COLORS } from "../../styles/colors.js";

export default class SearchLot extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View>
        <HeaderComponent
          shadow={true}
          title="Recherche"
          iconLeft="menu"
          headerBackgroundColor={COLORS.primary_dark}
          iconLeftOnPress={this.props.navigation.openDrawer}
        />
        <SearchCard></SearchCard>
      </View>
    );
  }
}
