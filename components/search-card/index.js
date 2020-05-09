import React from "react";
import { StyleSheet, View, Text, ScrollView, Image } from "react-native";
import {
  Button,
  Icon,
  List,
  ListItem,
  Body,
  Left,
  Right,
  Thumbnail,
} from "native-base";
import { connect } from "react-redux";
import { TEAM_DETAILS } from "../../mock.js";
import { COLORS } from "../../styles/colors.js";

class SearchCard extends React.Component {
  render() {
    return (
      <View style={{ paddingBottom: 200 }}>
        <View style={{ alignItems: "center", justifyContent: "center" }}>
          <Button
            full
            style={{
              backgroundColor: COLORS.primary,
            }}
          >
            <Icon name="options" />
            <Text style={{ fontSize: 16, color: "#FFF" }}>Filtres</Text>
          </Button>
        </View>
        <ScrollView>
          <List
            style={{
              backgroundColor: "#FFF",
            }}
          >
            {TEAM_DETAILS.data.map((u, i) => {
              return (
                <ListItem
                  key={i}
                  thumbnail
                  button
                  onPress={() => {
                    console.log("ok");
                  }}
                  style={{
                    backgroundColor: "#FFF",
                  }}
                >
                  <Left>
                    <Thumbnail square source={{ uri: u.lot.photo_url }} />
                  </Left>
                  <Body>
                    <Text
                      style={{
                        fontWeight: "bold",
                        fontSize: 14,
                        color: "#666",
                        paddingRight: 20,
                      }}
                    >
                      {u.lot.starting_city.toUpperCase()}{" "}
                      <Icon name="arrow-forward" style={{ fontSize: 14 }} />{" "}
                      {u.lot.arrival_city.toUpperCase()}
                    </Text>
                    <Text style={style.coach_name}>
                      {u.lot.delivry_start_date}{" "}
                      <Icon
                        name="arrow-back"
                        style={{ fontSize: 14, color: "#ABABAB" }}
                      />
                      <Icon
                        name="arrow-forward"
                        style={{ fontSize: 14, color: "#ABABAB" }}
                      />{" "}
                      {u.lot.delivry_end_date}
                    </Text>

                    <View
                      style={{
                        flexDirection: "row",
                        marginVertical: 5,
                        alignItems: "center",
                      }}
                    >
                      <Text style={style.price}>{u.price + "€"}</Text>
                      <Text style={style.badge}>{u.lot.size + " m3"}</Text>
                      <Text style={style.badge}>{u.service}</Text>
                    </View>
                  </Body>
                </ListItem>
              );
            })}
          </List>
        </ScrollView>
      </View>
    );
  }
}

const style = StyleSheet.create({
  addButton: {
    bottom: 30,
    borderRadius: 100,
    width: 60,
    height: 60,
    backgroundColor: COLORS.special,
    flex: 0,
    alignItems: "center",
    justifyContent: "center",
  },
  addButtonIcon: {
    color: "#FFF",
    fontSize: 40,
  },
  coach_name: {
    color: "#ABABAB",
    fontSize: 14,
  },
  badge: {
    backgroundColor: COLORS.primary,
    color: "#FFF",
    padding: 5,
    marginRight: 5,
    borderRadius: 5,
    fontSize: 10,
    fontWeight: "bold",
  },
  price: {
    color: COLORS.primary,
    fontSize: 18,
    marginRight: 10,
    fontWeight: "bold",
  },
});

const mapStateToProps = (store) => {
  return {
    currentProfile: store.profile,
  };
};

export default connect(mapStateToProps, undefined)(SearchCard);
