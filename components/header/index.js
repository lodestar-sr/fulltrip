import React from "react";
import { StyleSheet } from "react-native";
import {
  Container,
  Header,
  Left,
  Body,
  Right,
  Button,
  Icon,
  Title,
  Text,
} from "native-base";
import { COLORS } from "../../styles/colors.js";

export default class HeaderComponent extends React.Component {
  render() {
    console.log(this.props.nav);
    return (
      <Header
        androidStatusBarColor={COLORS.primary_dark}
        style={{ backgroundColor: COLORS.primary_dark }}
      >
        <Left>
          <Button
            transparent
            onPress={() => {
              this.props.nav.openDrawer();
            }}
          >
            <Icon name="menu" />
          </Button>
        </Left>
        <Body>
          <Title>Rechercher un lot</Title>
        </Body>
      </Header>
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
});
