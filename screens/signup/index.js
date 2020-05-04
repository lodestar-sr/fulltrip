import React from "react";
import {
  Container,
  Header,
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
} from "native-base";
import { signUpUser } from "../../services/authentification";
import validation from "../../validation";
import validate from "../../validation_wrapper";
import { COLORS } from "../../styles/colors";

export default class SignUp extends React.Component {
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

  handlePasswordInput() {
    this.setState((prevState) => ({
      iconPassword: prevState.iconPassword === "eye" ? "eye-off" : "eye",
      displayPassword: !prevState.displayPassword,
    }));
  }

  onChangeFormVal(key, val) {
    this.setState({ [key]: val });
    console.log(this.state);
  }

  handleSignUpForm() {
    const emailError = validate("email", this.state.email);
    const passwordError = validate("password", this.state.password);

    this.setState({
      emailError: emailError,
      passwordError: passwordError,
    });

    if (!emailError && !passwordError) {
      alert("Details are valid!");
      /*signUpUser(this.state.email, this.state.password);*/
    }
  }

  render() {
    return (
      <Container style={{ flex: 1 }}>
        <View
          style={{
            flex: 1,
            alignItems: "center",
            justifyContent: "center",
            backgroundColor: COLORS.primary,
          }}
        >
          <H1 style={{ color: "#FFF" }}>S'enregistrer</H1>
        </View>
        <View style={{ flex: 3 }}>
          <Content
            contentContainerStyle={{
              flex: 1,
              flexDirection: "row",
              justifyContent: "center",
            }}
          >
            <View style={{ flex: 0.8 }}>
              <View>
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
                      onBlur={() => {
                        this.setState({
                          emailError: validate("email", this.state.email),
                        });
                      }}
                    />
                    {this.state.emailError ? (
                      <Icon name="close-circle" />
                    ) : null}
                  </Item>

                  {this.state.emailError ? (
                    <Text style={{ color: "red" }}>
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
                      onBlur={() => {
                        this.setState({
                          passwordError: validate(
                            "password",
                            this.state.password
                          ),
                        });
                      }}
                    />
                    {this.state.passwordError ? (
                      <Icon name="close-circle" />
                    ) : (
                      <Icon
                        name={this.state.iconPassword}
                        onPress={() => this.handlePasswordInput()}
                      />
                    )}
                  </Item>
                  {this.state.passwordError ? (
                    <Text style={{ color: "red" }}>
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
                  <Text>Déjà un compte ? </Text>
                  <Text
                    style={{ color: COLORS.primary }}
                    onPress={() => this.props.navigation.navigate("SignIn")}
                  >
                    Se connecter
                  </Text>
                </View>
                <Button
                  block
                  rounded
                  style={{ backgroundColor: COLORS.primary }}
                  onPress={() => {
                    this.handleSignUpForm();
                  }}
                >
                  <Text>Inscription</Text>
                </Button>
                <View
                  style={{
                    paddingTop: 20,
                    marginTop: 20,
                    borderStyle: "solid",
                    borderTopWidth: 1,
                    borderTopColor: "#EDEDED",
                  }}
                >
                  <View
                    style={{
                      alignItems: "space-between",
                      justifyContent: "space-between",
                    }}
                  >
                    <Button
                      block
                      rounded
                      iconLeft
                      style={{ backgroundColor: COLORS.facebookColor }}
                      onPress={() => {
                        this.signInWithFacebook();
                      }}
                    >
                      <Icon name="logo-facebook" />
                      <Text>S'enregistrer avec Facebook</Text>
                    </Button>
                  </View>
                  <View
                    style={{
                      alignItems: "space-between",
                      justifyContent: "space-between",
                    }}
                  >
                    <Button
                      block
                      rounded
                      iconLeft
                      style={{
                        backgroundColor: COLORS.googleColor,
                        marginTop: 20,
                      }}
                      onPress={() => {
                        this.signInWithGoogle();
                      }}
                    >
                      <Icon name="logo-google" />
                      <Text>S'enregistrer avec Google</Text>
                    </Button>
                  </View>
                </View>
              </View>
            </View>
          </Content>
        </View>
      </Container>
    );
  }
}
