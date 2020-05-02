import React from "react";
import {
  Container,
  Header,
  Content,
  Form,
  Item,
  Input,
  Label,
} from "native-base";
import { connect } from "react-redux";

class ProfileForm extends React.Component {
  render() {
    return (
      <Container>
        <Header />
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
        </Content>
      </Container>
    );
  }
}

const mapDispatchToProps = () => {
  return {};
};

export default connect(null, mapDispatchToProps)(ProfileForm);
