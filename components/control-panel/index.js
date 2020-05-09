import React from "react";
import { View, StyleSheet } from "react-native";
import { List, ListItem, Text, Icon, Left, Right } from "native-base";
import { signOut } from "../../services/authentification";

import { COLORS } from "../../styles/colors";

const ControlPanel = () => {
  return (
    <View style={{ flex: 1, backgroundColor: "#FFF" }}>
      <List>
        <ListItem
          button
          onPress={() => {
            this.props.navigation.navigate("signIn");
          }}
          selected
        >
          <Left>
            <Text>Simon Mignolet</Text>
          </Left>
          <Right>
            <Icon name="arrow-forward" />
          </Right>
        </ListItem>
        <ListItem button>
          <Left>
            <Text>Simon Mignolet</Text>
          </Left>
          <Right>
            <Icon name="arrow-forward" />
          </Right>
        </ListItem>
        <ListItem
          button
          onPress={() => {
            signOut();
          }}
        >
          <Left>
            <Text>signOut</Text>
          </Left>
          <Right>
            <Icon name="arrow-forward" />
          </Right>
        </ListItem>
      </List>
    </View>
  );
};

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
});

export default ControlPanel;
