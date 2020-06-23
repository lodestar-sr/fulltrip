import React from "react";
import {StyleSheet, TouchableOpacity, View} from "react-native";
import { Card, CardItem, Text, Thumbnail } from "native-base";
import { COLORS } from "../../styles/colors.js";

const image = require("../../assets/card-image.png");

const LotSearchCard = ({
  travel, onClick
}) => (
  <TouchableOpacity onPress={() => onClick(travel)}>
    <Card style={{ borderRadius: 10 }}>
      <CardItem style={{ height: 150, borderRadius: 10 }}>
        <View style={{ marginRight: 20 }}>
          {/*<Thumbnail square source={{ uri: travel.lot.photo_url }} style={{ width: 120, height: 120, borderRadius: 5 }} />*/}
          <Thumbnail square source={image} style={{ width: 120, height: 120, borderRadius: 5 }} />
        </View>
        <View style={{ flex: 1, height: 120 }}>
          <View style={{ flexDirection: 'row', justifyContent: 'space-between' }}>
            <View>
              <View style={{ flexDirection: 'row', alignItems: 'center' }}>
                <View style={{ width: 12, height: 12, borderWidth: 2, borderColor: '#666', borderRadius: 10 }} />
                <Text style={{ marginLeft: 6, fontSize: 14, fontWeight: 'bold', color: 'black' }}>{travel.lot.starting_city}</Text>
              </View>
              <View style={{ height: 35, marginLeft: 5, borderLeftWidth: 2, borderLeftColor: '#666', borderStyle: 'dashed' }} />
              <View style={{ flexDirection: 'row', alignItems: 'center' }}>
                <View style={{ width: 12, height: 12, borderWidth: 2, borderColor: '#666', borderRadius: 10 }} />
                <Text style={{ marginLeft: 6, fontSize: 14, fontWeight: 'bold', color: 'black' }}>{travel.lot.arrival_city}</Text>
              </View>
            </View>
            <View style={{ alignItems: 'flex-end' }}>
              <Text style={{ color: '#666', fontSize: 24, fontWeight: 'bold' }}>{travel.price}€</Text>
              <Text style={{ color: COLORS.lightGray, fontSize: 16 }}>{travel.service}</Text>
              <Text style={{ color: COLORS.lightGray, fontSize: 16 }}>{travel.lot.size}m³</Text>
            </View>
          </View>
          <Text style={{ marginTop: 15, fontSize: 20, fontWeight: 'bold', color: 'black' }}>{travel.company}</Text>
        </View>
      </CardItem>
    </Card>
  </TouchableOpacity>
);

const style = StyleSheet.create({
  badge: {
    borderWidth: 1,
    borderStyle: "solid",
    borderColor: "#666",
    color: "#666",
    padding: 5,
    marginRight: 5,
    borderRadius: 5,
    fontSize: 10,
    fontWeight: "bold",
  },
  price: {
    color: "#666",
    fontSize: 18,
    marginRight: 10,
    fontWeight: "bold",
  },
});

export default LotSearchCard;
