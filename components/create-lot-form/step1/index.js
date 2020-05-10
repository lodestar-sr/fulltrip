import React from "react";
import { View } from "react-native";
import {
  Form,
  Item,
  Label,
  Picker,
  Input,
  Text,
  Button,
  Icon,
  H2,
} from "native-base";

import { COLORS } from "../../../styles/colors.js";

export const Step1 = (props) => {
  return (
    <View>
      <View
        style={{
          alignItems: "center",
        }}
      >
        <View
          style={{
            margin: 20,
          }}
        >
          <H2 style={{ color: "#FFF", textAlign: "center" }}>Au départ</H2>
          <Text style={{ color: "#FFF", textAlign: "center" }}>
            Renseignez l'ensemble des informations utiles à l'enlèvement de
            votre lot
          </Text>
        </View>
      </View>
      <View
        style={{
          backgroundColor: "#FFF",
          borderRadius: 5,
          elevation: 2,
          padding: 10,
          margin: 20,
        }}
      >
        <Form>
          <Item floatingLabel>
            <Label style={{ lineHeight: 14 }}>Adresse de départ</Label>
            <Input
              name="starting_address"
              style={{ padding: 5 }}
              onChange={(v) => {
                props.handleChange("starting_address", v.nativeEvent.text);
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
                name="access_type"
                iosIcon={<Icon name="arrow-down" />}
                style={{ width: undefined }}
                placeholder="Sélectionnez"
                placeholderStyle={{ color: "#bfc6ea" }}
                placeholderIconColor="#007aff"
                selectedValue={props.access_type}
                onValueChange={(value) => {
                  props.handleChange("access_type", value);
                }}
              >
                <Picker.Item label="Sélectionnez" value="Sélectionnez" />
                <Picker.Item label="Plein pieds" value="Plein pieds" />
                <Picker.Item label="Ascenseur" value="Ascenseur" />
                <Picker.Item label="Escaliers" value="Escaliers" />
              </Picker>
            </Item>
          </View>
          <Item floatingLabel style={{ marginBottom: 10, marginTop: 0 }}>
            <Label style={{ lineHeight: 14 }}>Nombre de m3</Label>
            <Input
              name="quantity"
              onChange={(v) => {
                props.handleChange("quantity", v.nativeEvent.text);
              }}
            />
          </Item>
        </Form>
      </View>
      <View
        style={{
          margin: 20,
          alignItems: "center",
        }}
      >
        <Button rounded block style={{ backgroundColor: COLORS.primary_dark }}>
          <Text>Suivant</Text>
        </Button>
      </View>
    </View>
  );
};
