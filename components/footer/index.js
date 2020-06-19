import React from "react";
import {StyleSheet, View} from "react-native";
import {
  Container,
  Footer,
  Label,
  Left,
  Body,
  Right,
  Button,
  Icon,
  Title,
  Text,
} from "native-base";
import { COLORS } from "../../styles/colors.js";

export default class FooterComponent extends React.Component {
  render() {
    return (
      <Footer
        style={{
          backgroundColor: this.props.backgroundColor,
          height: 80,
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          paddingLeft: '10%',
          paddingRight: '10%'
        }}
      >
        <Button transparent vertical onPress={() => this.props.onHomePress()}>
          <Icon
            type='Feather'
            name='home'
            style={{ color: COLORS.sky, fontSize: 24 }}
          />
          {
            this.props.hasLabel
              ? <Label style={{ color: COLORS.lightGray, fontSize: 12, marginTop: 5 }}>Home</Label>
              : null
          }
        </Button>
        {
          this.props.hasFilterButton
            ? (
              <Button transparent vertical onPress={() => this.props.onFilterPress()}>
                <Icon
                  type='Feather'
                  name='filter'
                  style={{ color: '#DEDEDE', fontSize: 24 }}
                />
                {
                  this.props.hasLabel
                    ? <Label style={{ color: COLORS.lightGray, fontSize: 12, marginTop: 5 }}>Filter</Label>
                    : null
                }
              </Button>
            )
            : (
              <Button transparent vertical onPress={() => this.props.onSearchPress()}>
                <Icon
                  type='FontAwesome'
                  name='search'
                  style={{ color: '#DEDEDE', fontSize: 24 }}
                />
                {
                  this.props.hasLabel
                    ? <Label style={{ color: COLORS.lightGray, fontSize: 12, marginTop: 5 }}>Search</Label>
                    : null
                }
              </Button>
            )
        }
        <View>
          <Button
            rounded
            style={{ backgroundColor: COLORS.sky, borderWidth: 4, borderColor: 'white', width: 60, height: 60, borderRadius: 30 }}
            onPress={() => this.props.onMessagePress()}
          >
            <Icon name="add" style={{ fontSize: 30, color: 'white' }} />
          </Button>
        </View>
        <Button transparent vertical onPress={() => this.props.onMessagePress()}>
          <Icon
            type='AntDesign'
            name='message1'
            style={{ color: '#DEDEDE', fontSize: 24 }}
          />
          {
            this.props.hasLabel
              ? <Label style={{ color: COLORS.lightGray, fontSize: 12, marginTop: 5 }}>Message</Label>
              : null
          }
        </Button>
        <Button transparent vertical onPress={() => this.props.onProfilePress()}>
          <Icon
            type='FontAwesome'
            name='user'
            style={{ color: '#DEDEDE', fontSize: 24 }}
          />
          {
            this.props.hasLabel
              ? <Label style={{ color: COLORS.lightGray, fontSize: 12, marginTop: 5 }}>Profile</Label>
              : null
          }
        </Button>
      </Footer>
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
