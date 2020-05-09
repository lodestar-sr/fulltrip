import React from "react";
import { View } from "react-native";
import SearchCard from "../../components/search-card";
import HeaderComponent from "../../components/header";

export default class SearchLot extends React.Component {
  constructor(props) {
    super(props);
  }

  closeControlPanel = () => {
    this._drawer.close();
  };
  openControlPanel = () => {
    this._drawer.open();
  };

  render() {
    return (
      <View>
        <HeaderComponent nav={this.props.navigation} />
        <SearchCard></SearchCard>
      </View>
    );
  }
}
