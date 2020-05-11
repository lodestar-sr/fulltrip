import React from "react";
import { View } from "react-native";
import { Form, Item, Label, Input, Text, H1, Textarea } from "native-base";

import { COLORS } from "../../../styles/colors.js";

export const Step3 = (props) => {
  if (props.currentStep !== 3) {
    // Prop: The current step
    return null;
  }
  return (
    <View>
      <View
        style={{
          alignItems: "center",
          marginHorizontal: 20,
          marginVertical: 50,
        }}
      >
        <H1 style={{ color: "#FFF", textAlign: "center" }}>Derniers détails</H1>
        <Text style={{ color: "#FFF", textAlign: "center" }}>
          Les lots avec photo et description détaillée sont 4 fois plus visités.
          Pensez-y !
        </Text>
      </View>
      <View
        style={{
          backgroundColor: "#FFF",
          borderRadius: 10,
          elevation: 2,
          paddingHorizontal: 20,
          paddingVertical: 10,
          margin: 20,
        }}
      >
        <Form>
          <Item floatingLabel>
            <Label style={{ marginVertical: 10, lineHeight: 14 }}>
              Photo du lot
            </Label>
            <Input
              name="photo_url"
              style={{ padding: 5 }}
              onChange={(v) => {
                props.handleChange("photo_url", v.nativeEvent.text);
              }}
            />
          </Item>
          <Item floatingLabel style={{ marginVertical: 10 }}>
            <Label style={{ lineHeight: 14 }}>Commentaires</Label>
            <Input
              name="comments"
              value={props.comments}
              onChange={(v) => {
                props.handleChange("comments", v.nativeEvent.text);
              }}
            />
          </Item>
          <Item floatingLabel style={{ marginVertical: 10 }}>
            <Label style={{ lineHeight: 14 }}>Prix</Label>
            <Input
              name="price"
              value={props.price}
              onChange={(v) => {
                props.handleChange("price", v.nativeEvent.text);
              }}
            />
          </Item>
        </Form>
      </View>
    </View>
  );
};
