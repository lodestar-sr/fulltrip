import React from "react";
import { View, Text } from "react-native";

const LotDetails = ({ route, navigation }) => {
  const data = route.params.data;
  return (
    <View>
      <Text>{data.lot.arrival_city}</Text>
    </View>
  );
};

export default LotDetails;
