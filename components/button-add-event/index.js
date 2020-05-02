import React from "react";
import { StyleSheet, View } from "react-native";
import { Button, Icon } from "react-native-elements";

const ButtonAddEvent = ({ onPressCallBack }) => {
  return (
    <View
      style={{
        position: "absolute",
        bottom: 10,
      }}
    >
      <View>
        <Button
          disabledStyle
          icon={<Icon name="add" size={40} color="white" />}
          rounded
          containerStyle={{ borderRadius: 100 }}
          buttonStyle={{
            height: 60,
            width: 60,
            borderRadius: 100,
          }}
          onPress={() => {
            onPressCallBack();
          }}
        />
      </View>
    </View>
  );
};

export default ButtonAddEvent;
