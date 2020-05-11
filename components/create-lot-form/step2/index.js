import React from "react";
import { View } from "react-native";
import { Form, Item, Label, Picker, Input, Text, Icon, H1 } from "native-base";

import { COLORS } from "../../../styles/colors.js";

export const Step2 = (props) => {
  if (props.currentStep !== 2) {
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
        <H1 style={{ color: "#FFF", textAlign: "center" }}>À l'arrivée</H1>
        <Text style={{ color: "#FFF", textAlign: "center" }}>
          Renseignez l'ensemble des informations utiles à la dépose de votre lot
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
            <Label style={{ lineHeight: 14 }}>Adresse d'arrivée</Label>
            <Input
              name="arrival_address"
              style={{ padding: 5 }}
              value={props.arrival_address}
              onChange={(v) => {
                props.handleChange("arrival_address", v.nativeEvent.text);
              }}
            />
          </Item>
          <View
            style={{
              flexDirection: "row",
              alignItems: "center",
              marginVertical: 30,
            }}
          >
            <Text style={{ marginLeft: 10 }}>Type d'accès</Text>
            <Item picker style={{ marginLeft: 10, flex: 1 }}>
              <Picker
                mode="dialog"
                name="arrival_access_type"
                iosIcon={<Icon name="arrow-down" />}
                style={{ width: undefined }}
                placeholder="Sélectionnez"
                placeholderStyle={{ color: "#bfc6ea" }}
                placeholderIconColor="#007aff"
                selectedValue={props.arrival_access_type}
                onValueChange={(value) => {
                  props.handleChange("arrival_access_type", value);
                }}
              >
                <Picker.Item label="Sélectionnez" value="Sélectionnez" />
                <Picker.Item label="Plein pieds" value="Plein pieds" />
                <Picker.Item label="Ascenseur" value="Ascenseur" />
                <Picker.Item label="Escaliers" value="Escaliers" />
              </Picker>
            </Item>
          </View>
          <View
            style={{
              flexDirection: "row",
              alignItems: "center",
            }}
          >
            <Text style={{ marginLeft: 10 }}>Prestation</Text>
            <Item picker style={{ marginLeft: 10, flex: 1 }}>
              <Picker
                mode="dialog"
                name="service"
                iosIcon={<Icon name="arrow-down" />}
                style={{ width: undefined }}
                placeholder="Sélectionnez"
                placeholderStyle={{ color: "#bfc6ea" }}
                placeholderIconColor="#007aff"
                selectedValue={props.service}
                onValueChange={(value) => {
                  props.handleChange("service", value);
                }}
              >
                <Picker.Item label="Sélectionnez" value="Sélectionnez" />
                <Picker.Item label="Economique" value="Economique" />
                <Picker.Item label="Standard" value="Standard" />
                <Picker.Item label="Luxe" value="Luxe" />
              </Picker>
            </Item>
          </View>
        </Form>
      </View>
    </View>
  );
};
