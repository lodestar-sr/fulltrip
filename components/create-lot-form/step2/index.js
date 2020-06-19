import React, {useEffect, useRef} from "react";
import {Switch, View} from "react-native";
import { Form, Item, Label, Picker, Input, Text, Icon, H1 } from "native-base";

import { COLORS } from "../../../styles/colors.js";
import GooglePlacesAutocomplete from "react-native-google-places-autocomplete";

export const Step2 = (props) => {
  if (props.currentStep !== 2) {
    // Prop: The current step
    return null;
  }

  const addressRef = useRef();
  useEffect(() => {
    addressRef.current.setAddressText(props.arrival_address.description);
  });
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
          <Item>
            <GooglePlacesAutocomplete
              placeholder="Adresse de départ"
              minLength={2}
              autoFocus={false}
              fetchDetails={true}
              listViewDisplayed={false}
              onPress={(data, details = null) => {
                console.log(data, details);
                props.handleChange("arrival_address", data);
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
              ref={addressRef}
            />
          </Item>
          <View
            style={{
              flexDirection: "row",
              alignItems: "center",
              marginVertical: 16,
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
                {
                  ['', 'Plein pieds', 'Ascenseur', 'Escaliers'].map((itm, idx) => (<Picker.Item key={idx} label={itm == '' ? 'Sélectionnez' : itm} value={itm}/>))
                }
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
                {
                  ['', 'Economique', 'Standard', 'Luxe'].map((itm, idx) => (<Picker.Item key={idx} label={itm == '' ? 'Sélectionnez' : itm} value={itm}/>))
                }
              </Picker>
            </Item>
          </View>
          <View style={{flexDirection: "row", alignItems: "center", marginVertical: 16}}>
            <Text style={{marginLeft: 10}}>Type de lieu</Text>
            <Item picker style={{marginLeft: 10, flex: 1}}>
              <Picker
                mode="dialog"
                name="arrival_location_type"
                iosIcon={<Icon name="arrow-down"/>}
                style={{width: undefined}}
                placeholder="Type de lieu"
                placeholderStyle={{color: "#bfc6ea"}}
                placeholderIconColor="#007aff"
                selectedValue={props.arrival_location_type}
                onValueChange={(value) => {
                  props.handleChange("arrival_location_type", value);
                }}
              >
                {
                  ['', 'Immeuble', 'Maison', 'Garde-meubles', 'Entrepôt', 'Magasin'].map((itm, idx) => (<Picker.Item key={idx} label={itm == '' ? 'Sélectionnez' : itm} value={itm}/>))
                }
              </Picker>
            </Item>
          </View>
          <View style={{flexDirection: "row", alignItems: "center", marginVertical: 0,}}>
            <Text style={{marginLeft: 10}}>Etages</Text>
            <Item picker style={{marginLeft: 10, flex: 1}}>
              <Picker
                mode="dialog"
                name="arrival_floors"
                iosIcon={<Icon name="arrow-down"/>}
                style={{width: undefined}}
                placeholder="Etages"
                placeholderStyle={{color: "#bfc6ea"}}
                placeholderIconColor="#007aff"
                selectedValue={props.arrival_floors}
                onValueChange={(value) => {
                  props.handleChange("arrival_floors", value);
                }}
              >
                {
                  ['', 'RDC', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'].map((itm, idx) => (<Picker.Item key={idx} label={itm == '' ? 'Sélectionnez' : itm} value={itm}/>))
                }
              </Picker>
            </Item>
          </View>
          <View style={{ flex: 1, flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginVertical: 16}}>
            <Label style={{marginLeft: 10}}>Ascenseur</Label>
            <Switch
              value={props.arrival_elevator == 'Oui'}
              onValueChange={v => {
                props.handleChange("arrival_elevator", v ? 'Oui' : 'Non');
              }}
            />
          </View>
          <View style={{ flex: 1, flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginVertical: 16}}>
            <Label style={{marginLeft: 10}}>Monte meuble nécessaire</Label>
            <Switch
              value={props.arrival_furniture_lift == 'Oui'}
              onValueChange={v => {
                props.handleChange("arrival_furniture_lift", v ? 'Oui' : 'Non');
              }}
            />
          </View>
          <View style={{ flex: 1, flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginVertical: 16}}>
            <Label style={{marginLeft: 10}}>Remontage des meubles ?</Label>
            <Switch
              value={props.arrival_reassembly_furniture == 'Oui'}
              onValueChange={v => {
                props.handleChange("arrival_reassembly_furniture", v ? 'Oui' : 'Non');
              }}
            />
          </View>
        </Form>
      </View>
    </View>
  );
};
