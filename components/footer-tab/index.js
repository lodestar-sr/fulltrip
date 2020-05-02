import React from "react";
import { View, StyleSheet } from "react-native";
import { Footer, FooterTab, Button, Icon, Text, Badge } from "native-base";

import { COLORS } from "../../styles/colors";

const FooterTabComponent = () => {
  return (
    <Footer>
      <FooterTab style={{ elevation: 1 }}>
        <Button vertical>
          <Icon name="search" />
          <Text>Recherche</Text>
        </Button>
        <Button vertical>
          <Icon name="calendar" />
          <Text>Matchs</Text>
        </Button>
        <Button rounded style={style.addButton}>
          <View>
            <Icon style={style.addButtonIcon} name="add" />
          </View>
        </Button>
        <Button active vertical>
          <Icon active name="ios-today" />
          <Text>historique</Text>
        </Button>

        <Button badge vertical>
          <Badge>
            <Text>5</Text>
          </Badge>
          <Icon name="chatbubbles" />
          <Text>Messages</Text>
        </Button>
      </FooterTab>
    </Footer>
  );
};

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
  addButtonIcon: {
    color: "#FFF",
    fontSize: 40,
  },
});

export default FooterTabComponent;
