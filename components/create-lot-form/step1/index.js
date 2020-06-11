import React from "react";
import {View} from "react-native";
import {Form, H1, Icon, Input, Item, Label, Picker, Text} from "native-base";
import GooglePlacesAutocomplete from "react-native-google-places-autocomplete";

export const Step1 = (props) => {
  if (props.currentStep !== 1) {
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
        <H1 style={{color: "#FFF", textAlign: "center"}}>Au départ</H1>
        <Text style={{color: "#FFF", textAlign: "center"}}>
          Renseignez l'ensemble des informations utiles à l'enlèvement de votre
          lot
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
          <Item>
            <GooglePlacesAutocomplete
              placeholder="Adresse de départ"
              minLength={2}
              autoFocus={false}
              fetchDetails={true}
              listViewDisplayed={false}
              onPress={(data, details = null) => {
                props.handleChange("starting_address", data);
              }}
              query={{
                key: 'AIzaSyAviivTDt0XzleVXCCrY3TDqeHZkaEjB4U',
                language: 'en'
              }}
              styles={{
                textInputContainer: {
                  backgroundColor: 'rgba(0,0,0,0)',
                  borderTopWidth: 0,
                }
              }}
              textInputProps={props.starting_address}
            />
          </Item>
          <View
            style={{
              flexDirection: "row",
              alignItems: "center",
              marginVertical: 30,
            }}
          >
            <Text style={{marginLeft: 10}}>Type d'accès</Text>
            <Item picker style={{marginLeft: 10, flex: 1}}>
              <Picker
                mode="dialog"
                name="starting_access_type"
                iosIcon={<Icon name="arrow-down"/>}
                style={{width: undefined}}
                placeholder="Sélectionnez"
                placeholderStyle={{color: "#bfc6ea"}}
                placeholderIconColor="#007aff"
                selectedValue={props.starting_access_type}
                onValueChange={(value) => {
                  props.handleChange("starting_access_type", value);
                }}
              >
                <Picker.Item label="Sélectionnez" value="Sélectionnez"/>
                <Picker.Item label="Plein pieds" value="Plein pieds"/>
                <Picker.Item label="Ascenseur" value="Ascenseur"/>
                <Picker.Item label="Escaliers" value="Escaliers"/>
              </Picker>
            </Item>
          </View>
          <Item floatingLabel style={{marginBottom: 10, marginTop: 0}}>
            <Label style={{lineHeight: 14}}>Quantité en m3</Label>
            <Input
              keyboardType="number-pad"
              name="quantity"
              value={props.quantity}
              onChange={(v) => {
                props.handleChange("quantity", v.nativeEvent.text);
              }}
            />
          </Item>
        </Form>
      </View>
    </View>
  );
};
