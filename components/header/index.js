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
    return (
      <Header
        androidStatusBarColor={COLORS.primary_dark}
        style={{ backgroundColor: this.props.headerBackgroundColor }}
        noShadow={this.props.shadow}
      >
        <Left>
          <Button transparent onPress={() => this.props.iconLeftOnPress()}>
            <Icon name={this.props.iconLeft} />
          </Button>
        </Left>
        <Body>
          <Title>{this.props.title}</Title>
        </Body>
        <Right>
          <Button transparent onPress={() => this.props.iconRightOnPress()}>
            <Icon name={this.props.iconRight} />
          </Button>
        </Right>
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
