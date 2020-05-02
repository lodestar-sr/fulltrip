import React from "react";
import { Button, View, Text } from "native-base";

export default class ConnectionBaseScreen extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View>
        <Button
          large
          onPress={() => {
            this.props.navigation.navigate("ConnectionProfileScreen");
          }}
        >
          <Text>Démarrer</Text>
        </Button>
      </View>
    );
  }
}
