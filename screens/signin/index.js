import React from "react";
import {
  Container,
  Content,
  Form,
  Item,
  Input,
  Label,
  Button,
  View,
  Text,
  Icon,
  H1,
  Toast,
  Root,
} from "native-base";
import { StyleSheet, ScrollView, StatusBar } from "react-native";
import { signInUser } from "../../services/authentification";
import validate from "../../validation_wrapper";
import { connect } from "react-redux";
import { getCurrentUser } from "../../actions/index";
import { COLORS } from "../../styles/colors";

class SignIn extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      email: "",
      emailError: "",
      password: "",
      passwordError: "",
      iconPassword: "eye-off",
      displayPassword: true,
    };
  }

  componentDidMount() {
    this.props.getCurrentUser().then(() => {
      if (this.props.currentUser.lenght > 1) {
        this.props.navigation.navigate("SearchLot");
      }
    });
  }

  showPasswordInput() {
    this.setState((prevState) => ({
      iconPassword: prevState.iconPassword === "eye" ? "eye-off" : "eye",
      displayPassword: !prevState.displayPassword,
    }));
  }

  onChangeFormVal(key, val) {
    this.setState({ [key]: val });
    console.log(this.state);
  }

  handleSignInForm() {
    const emailError = validate("email", this.state.email);
    const passwordError = validate("password", this.state.password);

    this.setState({
      emailError: emailError,
      passwordError: passwordError,
    });

    if (!emailError && !passwordError) {
      signInUser(this.state.email, this.state.password);
    }
  }

  toastShow(error) {
    console.log(error);
    Toast.show({
      text: error,
      buttonText: "Okay",
      buttonTextStyle: { color: "#008000" },
      buttonStyle: { backgroundColor: "#5cb85c" },
    });
  }

  render() {
    return (
      <Root>
        <ScrollView
          contentContainerStyle={{
            flex: 1,
          }}
          scrollEnabled
        >
          <StatusBar backgroundColor={COLORS.primary} />
          <Container
            style={{
              flex: 1,
              backgroundColor: COLORS.primary,
            }}
          >
            <View
              style={{
                flex: 1,
                alignItems: "center",
                justifyContent: "center",
              }}
            >
              <H1 style={{ color: "#FFF" }}>Se connecter</H1>
            </View>
            <View
              style={{
                flex: 2,
                backgroundColor: "#FFF",
                borderTopLeftRadius: 50,
                borderTopRightRadius: 50,
              }}
            >
              <Content
                contentContainerStyle={{
                  flex: 1,
                  flexDirection: "row",
                  justifyContent: "center",
                }}
              >
                <View style={{ flex: 0.8 }}>
                  <Form>
                    <Item
                      floatingLabel
                      error={this.state.emailError ? true : false}
                    >
                      <Label>Email</Label>
                      <Input
                        onChangeText={(val) =>
                          this.onChangeFormVal("email", val.trim())
                        }
                        placeholder={this.state.emailError}
                      />
                      {this.state.emailError ? (
                        <Icon name="close-circle" />
                      ) : null}
                    </Item>

                    {this.state.emailError ? (
                      <Text style={{ color: "red", fontSize: 12 }}>
                        {this.state.emailError}
                      </Text>
                    ) : null}

                    <Item
                      floatingLabel
                      error={this.state.passwordError ? true : false}
                    >
                      <Label>Mot de passe</Label>
                      <Input
                        secureTextEntry={this.state.displayPassword}
                        error={this.state.passwordError}
                        onChangeText={(val) =>
                          this.onChangeFormVal("password", val.trim())
                        }
                      />
                      {this.state.passwordError ? (
                        <Icon name="close-circle" />
                      ) : (
                        <Icon
                          name={this.state.iconPassword}
                          onPress={() => this.showPasswordInput()}
                        />
                      )}
                    </Item>
                    {this.state.passwordError ? (
                      <Text
                        style={{
                          color: "red",
                          fontSize: 12,
                        }}
                      >
                        {this.state.passwordError}
                      </Text>
                    ) : null}
                  </Form>
                  <View
                    style={{
                      flexDirection: "row",
                      justifyContent: "center",
                      paddingTop: 10,
                      paddingBottom: 10,
                    }}
                  >
                    <Text>Pas encore de compte ? </Text>
                    <Text
                      style={{ color: COLORS.primary }}
                      onPress={() => this.props.navigation.goBack()}
                    >
                      Créer un compte
                    </Text>
                  </View>
                  <Button
                    block
                    rounded
                    style={{
                      backgroundColor: COLORS.primary,
                    }}
                    onPress={() => {
                      this.handleSignInForm();
                    }}
                  >
                    <Text>Se connecter</Text>
                  </Button>
                  <View style={style.socialContainer}>
                    <View>
                      <Button
                        block
                        rounded
                        iconLeft
                        style={style.facebookButton}
                        onPress={() => {
                          this.signInWithFacebook();
                        }}
                      >
                        <Icon name="logo-facebook" />
                        <Text>Se connecter avec Facebook</Text>
                      </Button>
                    </View>
                    <View>
                      <Button
                        block
                        rounded
                        iconLeft
                        style={style.googleButton}
                        onPress={() => {
                          this.signInWithGoogle();
                        }}
                      >
                        <Icon name="logo-google" />
                        <Text>Se connecter avec Google</Text>
                      </Button>
                    </View>
                  </View>
                </View>
              </Content>
            </View>
          </Container>
        </ScrollView>
      </Root>
    );
  }
}

const style = StyleSheet.create({
  googleButton: {
    backgroundColor: COLORS.googleColor,
    marginTop: 10,
    marginBottom: 10,
  },
  facebookButton: {
    backgroundColor: COLORS.facebookColor,
    marginTop: 10,
    marginBottom: 10,
  },
  socialContainer: {
    paddingTop: 20,
    marginTop: 20,
    borderStyle: "solid",
    borderTopWidth: 1,
    borderTopColor: "#EDEDED",
  },
});

const mapStateToProps = (store) => {
  return {
    currentUser: store.user,
  };
};

const mapDispatchToProps = {
  getCurrentUser,
};

export default connect(mapStateToProps, mapDispatchToProps)(SignIn);
