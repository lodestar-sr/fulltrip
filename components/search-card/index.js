import React from "react";
import { StyleSheet, View, ScrollView, Image } from "react-native";
import {
  Button,
  Icon,
  List,
  ListItem,
  Body,
  Left,
  Right,
  Text,
  Thumbnail,
} from "native-base";
import { connect } from "react-redux";
import { LOT_DETAILS } from "../../mock.js";
import { COLORS } from "../../styles/colors.js";

class SearchCard extends React.Component {
  render() {
    return (
      <ScrollView
        showsVerticalScrollIndicator={false}
        style={{ backgroundColor: "#FFF" }}
      >
        <View style={{ paddingBottom: 50 }}>
          <ScrollView
            horizontal
            showsHorizontalScrollIndicator={false}
            style={{
              flexDirection: "row",
            }}
          >
            <Button
              small
              bordered
              iconLeft
              style={{
                borderColor: "#999",
                margin: 10,
                borderRadius: 5,
              }}
              onPress={() => this.props.openMenu('LotFilters')}
            >
              <Icon
                type="MaterialIcons"
                name="filter-list"
                style={{ color: "#999", fontSize: 16 }}
              />
              <Text uppercase={false} style={{ fontSize: 12, color: "#666" }}>
                Filtres
              </Text>
            </Button>
            <Button
              small
              bordered
              iconLeft
              style={{
                borderColor: "#999",
                margin: 10,
                borderRadius: 5,
              }}
            >
              <Icon
                type="Foundation"
                name="marker"
                style={{ color: "#999", fontSize: 16 }}
              />
              <Text uppercase={false} style={{ fontSize: 12, color: "#666" }}>
                Localisation
              </Text>
            </Button>
            <Button
              small
              bordered
              iconLeft
              style={{
                borderColor: "#999",
                margin: 10,
                borderRadius: 5,
              }}
            >
              <Icon name="locate" style={{ color: "#999", fontSize: 16 }} />
              <Text uppercase={false} style={{ fontSize: 12, color: "#666" }}>
                Autour de moi
              </Text>
            </Button>
            <Button
              small
              bordered
              iconLeft
              style={{
                borderColor: "#999",
                margin: 10,
                borderRadius: 5,
              }}
            >
              <Icon
                type="MaterialIcons"
                name="sort"
                style={{ color: "#999", fontSize: 16 }}
              />
              <Text uppercase={false} style={{ fontSize: 12, color: "#666" }}>
                Trier par
              </Text>
            </Button>
          </ScrollView>
          <List
            style={{
              backgroundColor: "#FFF",
            }}
          >
            {LOT_DETAILS.data.map((u, i) => {
              return (
                <ListItem
                  key={i}
                  thumbnail
                  button
                  onPress={() => {
                    this.props.viewLotDetails(u);
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
                        paddingVertical: 5,
                      }}
                    >
                      {u.lot.starting_city.toUpperCase()}{" "}
                      <Icon name="arrow-forward" style={{ fontSize: 14 }} />{" "}
                      {u.lot.arrival_city.toUpperCase()}
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
        </View>
      </ScrollView>
    );
  }
}

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

const mapStateToProps = (store) => {
  return {
    currentProfile: store.profile,
  };
};

export default connect(mapStateToProps, undefined)(SearchCard);
