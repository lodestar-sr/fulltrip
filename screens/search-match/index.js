import React from "react";
import { View } from "react-native";
import SearchCard from "../../components/search-card";

export default class SearchMatch extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View>
        <SearchCard></SearchCard>
      </View>
    );
  }
}
