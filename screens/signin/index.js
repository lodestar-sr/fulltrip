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
} from "native-base";
import { signInUser } from "../../services/authentification";
import { COLORS } from "../../styles/colors";

export default class SignIn extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      email: "",
      password: "",
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

  handleSignInForm() {
    signInUser(this.state.email, this.state.password);
  }

  render() {
    return (
      <Container style={{ flex: 1 }}>
        <Content
          contentContainerStyle={{
            flex: 1,
            flexDirection: "row",
            alignItems: "center",
            justifyContent: "center",
          }}
        >
          <View style={{ flex: 0.8 }}>
            <Form>
              <Item floatingLabel>
                <Label>Email</Label>
                <Input
                  onChangeText={(val) => this.onChangeFormVal("email", val)}
                />
              </Item>
              <Item floatingLabel>
                <Label>Mot de passe</Label>
                <Input
                  secureTextEntry={this.state.displayPassword}
                  onChangeText={(val) => this.onChangeFormVal("password", val)}
                />
                <Icon
                  name={this.state.iconPassword}
                  onPress={() => this.handlePasswordInput()}
                />
              </Item>
            </Form>
            <View
              style={{
                flexDirection: "row",
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
              style={{ backgroundColor: COLORS.primary }}
              onPress={() => {
                this.handleSignInForm();
              }}
            >
              <Text>Connexion</Text>
            </Button>
          </View>
        </Content>
      </Container>
    );
  }
}
