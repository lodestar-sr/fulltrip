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
} from "native-base";

export default class ConnectionProfileScreen extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <Container>
        <Content>
          <Form>
            <Item floatingLabel>
              <Label>Username</Label>
              <Input />
            </Item>
            <Item floatingLabel last>
              <Label>Password</Label>
              <Input />
            </Item>
          </Form>
          <View>
            <Button
              large
              onPress={() => {
                this.props.navigation.navigate("ConnectionTeamScreen");
              }}
            >
              <Text>Suivant</Text>
            </Button>
          </View>
        </Content>
      </Container>
    );
  }
}
