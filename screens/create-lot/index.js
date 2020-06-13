import React from "react";
import {ActivityIndicator, Alert, ImageBackground, ScrollView, StyleSheet, View} from "react-native";
import {Button, Right, Text} from "native-base";
import HeaderComponent from "../../components/header";
import {connect} from "react-redux";
import {Step1} from "../../components/create-lot-form/step1";
import {Step2} from "../../components/create-lot-form/step2";
import {Step3} from "../../components/create-lot-form/step3";
import {insertLot} from "../../services/database";

import {COLORS} from "../../styles/colors.js";

const image = require("../../assets/bg.jpg");

class CreateLot extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      owner_uid: this.props.currentUser.uid ? this.props.currentUser.uid : '',
      client_uid: "",
      currentStep: 1,
      starting_address: "",
      arrival_address: "",
      starting_access_type: "",
      arrival_access_type: "",
      quantity: "",
      service: "",
      photo_url: "",
      price: "",
      comments: "",
      active: false,
      finished: false,
      owner_validation: false,
      client_validation: false,
      disponibility_date: new Date(),
      creation_date: new Date(),
      loading: false,
    };
    console.log(this.state);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange = (n, v) => {
    this.setState({[n]: v});
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

  addLot() {
    Alert.alert(
      '',
      'Votre lot a bien été envoyé, vous recevrez une notification lorsque qu\'il sera disponible',
      [
        {
          text: 'Cancel',
          style: "cancel",
          onPress: () => console.log('Cancel pressed'),
        },
        {
          text: 'Ok',
          onPress: () => {
            this.setState({loading: true});
            insertLot(this.state).then(() => {
              console.log('Insert Data Successfully');
              this.setState({loading: false});
              this.props.navigation.navigate("SearchLot");
            }).catch(err => {
              this.setState({loading: false});
            });
          }
        },
      ]
    );
  }

  setDate(newDate) {
    this.setState({disponibility_date: newDate});
    console.log(this.state);
  }

  get nextButton() {
    let {
      currentStep,
      starting_address,
      starting_access_type,
      arrival_address,
      arrival_access_type,
      quantity,
      service,
      price,
      photo_url,
      comments,
    } = this.state;
    // If the current step is not 3, then render the "next" button

    if (currentStep === 1) {
      if (starting_address && starting_access_type && quantity) {
        return (
          <Right>
            <Button
              rounded
              block
              large
              onPress={() => {
                this._next();
              }}
            >
              <Text>Suivant</Text>
            </Button>
          </Right>
        );
      } else {
        return (
          <Right>
            <Button rounded large block disabled>
              <Text>Suivant</Text>
            </Button>
          </Right>
        );
      }
    } else if (currentStep === 2) {
      if (arrival_address && arrival_access_type && service) {
        return (
          <Right>
            <Button
              rounded
              block
              large
              onPress={() => {
                this._next();
              }}
            >
              <Text>Suivant</Text>
            </Button>
          </Right>
        );
      } else {
        return (
          <Right>
            <Button rounded large block disabled>
              <Text>Suivant</Text>
            </Button>
          </Right>
        );
      }
    } else if (currentStep === 3) {
      if (price) {
        return (
          <Right>
            <Button
              rounded
              large
              block
              onPress={() => {
                this.addLot();
              }}
            >
              <Text>Proposer mon lot</Text>
            </Button>
          </Right>
        );
      } else {
        return (
          <Right>
            <Button rounded large block disabled>
              <Text>Proposer mon lot</Text>
            </Button>
          </Right>
        );
      }
    }
    // ...else render nothing
    return null;
  }

  render() {

    return (
      <>
        <ScrollView
          keyboardShouldPersistTaps="always"
        >
          <ImageBackground source={image} style={styles.image}>
            <View style={{flex: 1}}>
              <HeaderComponent
                title="Proposer un lot"
                iconLeft={this.state.currentStep != 1 ? "arrow-back" : null}
                iconRight="close"
                iconRightOnPress={() =>
                  this.props.navigation.navigate("SearchLot")
                }
                shadow={true}
                headerBackgroundColor={COLORS.primary}
                headerTextColor={"#FFF"}
                iconLeftOnPress={
                  this.state.currentStep != 1 ? () => this._prev() : ""
                }
              />
              <ScrollView
                keyboardShouldPersistTaps="always"
              >
                <Step1
                  starting_address={this.state.starting_address}
                  starting_access_type={this.state.starting_access_type}
                  quantity={this.state.quantity}
                  currentStep={this.state.currentStep}
                  handleChange={this.handleChange}
                />
                <Step2
                  arrival_address={this.state.arrival_address}
                  arrival_access_type={this.state.arrival_access_type}
                  service={this.state.service}
                  currentStep={this.state.currentStep}
                  handleChange={this.handleChange}
                />
                <Step3
                  comments={this.state.comments}
                  price={this.state.price}
                  photo_url={this.state.photo_url}
                  currentStep={this.state.currentStep}
                  handleChange={this.handleChange}
                  setDate={this.setDate}
                />
                <View
                  style={{
                    flexDirection: "row",
                    margin: 20,
                  }}
                >
                  {this.nextButton}
                </View>
              </ScrollView>
            </View>
          </ImageBackground>
        </ScrollView>
        {
          this.state.loading ? <View style={{
            position: 'absolute',
            backgroundColor: '#ff000030',
            width: '100%',
            height: '100%',
            flexDirection: 'row',
            justifyContent: 'center',
            zIndex: 10000,
          }}
          >
            <ActivityIndicator size="large" color="#ff0000"/>
          </View> : null
        }
      </>
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

const mapStateToProps = (store) => {
  return {
    currentUser: store.user,
  };
};

export default connect(mapStateToProps, null)(CreateLot);
