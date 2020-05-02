import React from "react";
import { StyleSheet, View, Text, ScrollView, Image } from "react-native";
import { Button, Icon, Card, CardItem, Body } from "native-base";
import { connect } from "react-redux";
import { TEAM_DETAILS } from "../../mock.js";
import { COLORS } from "../../styles/colors.js";

class SearchCard extends React.Component {
  render() {
    console.log(this.props.currentProfile.data);
    return (
      <View style={{ paddingBottom: 40 }}>
        <View style={{ alignItems: "center", justifyContent: "center" }}>
          <Button
            full
            style={{
              backgroundColor: COLORS.primary_light,
            }}
          >
            <Icon name="options" />
            <Text style={{ fontSize: 16, color: "#FFF" }}>Filtres</Text>
          </Button>
        </View>
        <ScrollView>
          <View
            style={{
              paddingTop: 10,
              paddingBottom: 80,
            }}
          >
            {TEAM_DETAILS.data.map((u, i) => {
              return (
                <Card key={i} transparent>
                  <CardItem
                    style={{
                      backgroundColor: "transparent",
                      paddingTop: 0,
                      paddingBottom: 0,
                    }}
                  >
                    <Body>
                      <View
                        style={{
                          flex: 1,
                          flexDirection: "row",
                          alignItems: "center",
                          backgroundColor: COLORS.primary,
                          borderRadius: 5,
                          elevation: 4,
                        }}
                      >
                        <View
                          style={{
                            flex: 1,
                            flexDirection: "column",
                            alignItems: "center",
                            justifyContent: "center",
                            color: "#FFF",
                            padding: 10,
                            borderBottomLeftRadius: 5,
                            borderBottomRightRadius: 0,
                            borderTopLeftRadius: 5,
                            borderTopRightRadius: 0,
                          }}
                        >
                          <Text
                            style={{
                              color: "#FFF",
                              fontWeight: "bold",
                              fontSize: 16,
                            }}
                          >
                            {u.date_match}
                          </Text>
                          <Text
                            style={{
                              color: "#FFF",
                              fontWeight: "bold",
                              fontSize: 16,
                            }}
                          >
                            {u.time_match}
                          </Text>
                        </View>
                        <View
                          style={{
                            flex: 4,
                            backgroundColor: "#FFF",
                            flexDirection: "column",
                            alignItems: "flex-start",
                            padding: 10,
                            borderBottomLeftRadius: 0,
                            borderBottomRightRadius: 5,
                            borderTopLeftRadius: 0,
                            borderTopRightRadius: 5,
                          }}
                        >
                          <Text
                            style={{
                              fontWeight: "bold",
                              fontSize: 16,
                              color: "#666",
                              paddingRight: 20,
                            }}
                          >
                            {u.club_name.toUpperCase()}
                          </Text>
                          <View
                            style={{
                              position: "absolute",
                              top: 5,
                              right: 5,
                            }}
                          >
                            {u.need_arbitre ? (
                              <View style={style.arbitrator_badge}>
                                <Image
                                  style={style.arbitrator_badge_image}
                                  source={require("../../assets/tool.png")}
                                />
                              </View>
                            ) : (
                              <View />
                            )}
                          </View>
                          <Text style={style.coach_name}>
                            {u.coach_firstname + " " + u.coach_name}
                          </Text>
                          <View
                            style={{
                              flex: 1,
                              flexDirection: "row",
                              paddingTop: 5,
                            }}
                          >
                            <View
                              style={{
                                flex: 1,
                                flexDirection: "row",
                                flexWrap: "wrap",
                                alignItems: "center",
                                justifyContent: "flex-start",
                                paddingTop: 5,
                              }}
                            >
                              <Text style={style.category_badge}>
                                {u.category}
                              </Text>
                              <Text style={style.level_badge}>
                                {u.competition_level}
                              </Text>
                              <Text style={style.club_status}>
                                {u.club_status}
                              </Text>
                            </View>
                          </View>
                        </View>
                      </View>
                    </Body>
                  </CardItem>
                </Card>
              );
            })}
          </View>
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
  },
  level_badge: {
    backgroundColor: COLORS.primary_light,
    color: "#FFF",
    paddingTop: 5,
    paddingBottom: 5,
    paddingLeft: 10,
    paddingRight: 10,
    borderRadius: 5,
    marginRight: 5,
    marginLeft: 5,
    fontWeight: "bold",
  },
  category_badge: {
    backgroundColor: COLORS.primary,
    color: "#FFF",
    paddingTop: 5,
    paddingBottom: 5,
    paddingLeft: 10,
    paddingRight: 10,
    borderRadius: 5,
    fontWeight: "bold",
  },
  arbitrator_badge: {
    backgroundColor: COLORS.secondary,
    width: 30,
    height: 30,
    padding: 10,
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    borderRadius: 20,
    fontWeight: "bold",
  },
  arbitrator_badge_image: {
    width: 20,
    height: 20,
  },
  club_status: {
    backgroundColor: COLORS.secondary,
    color: "#666",
    paddingTop: 5,
    paddingBottom: 5,
    paddingLeft: 10,
    paddingRight: 10,
    borderRadius: 5,
    fontWeight: "bold",
  },
});

const mapStateToProps = (store) => {
  return {
    currentProfile: store.profile,
  };
};

export default connect(mapStateToProps, undefined)(SearchCard);
