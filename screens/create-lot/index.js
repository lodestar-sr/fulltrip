import React from "react";
import { View, ScrollView, ImageBackground, StyleSheet } from "react-native";
import HeaderComponent from "../../components/header";
import { Step1 } from "../../components/create-lot-form/step1";

import { COLORS } from "../../styles/colors.js";

const image = require("../../assets/bg.jpg");

export default class CreateLot extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      currentStep: 1,
      starting_address: "",
      quantity: "",
      access_type: "",
    };
    this.handleChange = this.handleChange.bind(this);
    console.log(this.state);
  }

  handleChange = (n, v) => {
    this.setState({ [n]: v });

    console.log(this.state);
  };

  _next() {
    let currentStep = this.state.currentStep;
    // If the current step is 1 or 2, then add one on "next" button click
    currentStep = currentStep >= 2 ? 3 : currentStep + 1;
    this.setState({
      currentStep: currentStep,
    });
  }

  _prev() {
    let currentStep = this.state.currentStep;
    // If the current step is 2 or 3, then subtract one on "previous" button click
    currentStep = currentStep <= 1 ? 1 : currentStep - 1;
    this.setState({
      currentStep: currentStep,
    });
  }

  render() {
    return (
      <View style={{ flex: 1, backgroundColor: "#FFF" }}>
        <HeaderComponent
          title="Proposer un lot"
          iconLeft="arrow-back"
          iconRight="close"
          iconRightOnPress={() => this.props.navigation.navigate("SearchLot")}
          shadow={true}
          headerBackgroundColor={COLORS.primary_dark}
          iconLeftOnPress={this.props.navigation.goBack}
        />
        <ScrollView>
          <ImageBackground source={image} style={styles.image}>
            <Step1
              access_type={this.state.access_type}
              currentStep={this.state.currentStep}
              handleChange={this.handleChange}
            />
          </ImageBackground>
        </ScrollView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  image: {
    flex: 1,
    resizeMode: "cover",
    justifyContent: "center",
  },
});
