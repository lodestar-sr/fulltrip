import React from "react";
import {ScrollView, View} from "react-native";
import {COLORS} from "../../styles/colors.js";
import {Button, Form, Icon, Item, Label, Picker} from "native-base";
import GooglePlacesAutocomplete from "react-native-google-places-autocomplete";

export default class LotFilters extends React.Component {

  state = {
    minPrice: 0,
    maxPrice: 100,
    departureAddress: '',
    arrivalAddress: '',
    service: '',
  };

  onInputChange = (name, value) => {
    this.setState({[name]: value});
  };

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View style={{backgroundColor: "#FFF", height: '100%', display: 'flex', flexDirection: 'column'}}>
        <ScrollView
          showsVerticalScrollIndicator={false}
          style={{backgroundColor: "#FFF", flex: 1}}
        >
          <Form style={{paddingTop: 40, paddingLeft: 30, paddingRight: 30}}>
            <View>
              <Label>Price Range</Label>
            </View>
            <View style={{marginTop: 20}}>
              <Label>Departure Address</Label>
              <View style={{position: 'relative', marginTop: 20}}>
                <GooglePlacesAutocomplete
                  placeholder="Adresse de départ"
                  placeholderTextColor="#E4E4E4"
                  minLength={2}
                  autoFocus={false}
                  fetchDetails={true}
                  listViewDisplayed={false}
                  onPress={(data, details = null) => {
                    this.onInputChange("starting_address", data);
                  }}
                  query={{
                    key: 'AIzaSyAviivTDt0XzleVXCCrY3TDqeHZkaEjB4U',
                    language: 'en'
                  }}
                  styles={{
                    textInputContainer: {
                      backgroundColor: 'rgba(0,0,0,0)',
                      borderColor: '#EEE',
                      borderWidth: 1,
                      borderRadius: 7,
                      paddingLeft: 20,
                      paddingTop: 2,
                      fontSize: 20,
                      height: 48,
                    }
                  }}
                />
                <Icon type="Foundation" name="marker"
                      style={{color: '#D2D2D2', position: 'absolute', left: 17, top: 13, fontSize: 24}}
                />
              </View>
            </View>
            <View style={{marginTop: 20}}>
              <Label>Arrival Address</Label>
              <View style={{position: 'relative', marginTop: 20}}>
                <GooglePlacesAutocomplete
                  placeholder="Adresse de départ"
                  placeholderTextColor="#E4E4E4"
                  minLength={2}
                  autoFocus={false}
                  fetchDetails={true}
                  listViewDisplayed={false}
                  onPress={(data, details = null) => {
                    this.onInputChange("starting_address", data);
                  }}
                  query={{
                    key: 'AIzaSyAviivTDt0XzleVXCCrY3TDqeHZkaEjB4U',
                    language: 'en'
                  }}
                  styles={{
                    textInputContainer: {
                      backgroundColor: 'rgba(0,0,0,0)',
                      borderColor: '#EEE',
                      borderWidth: 1,
                      borderRadius: 7,
                      paddingLeft: 20,
                      paddingTop: 2,
                      fontSize: 20,
                      height: 48,
                    }
                  }}
                />
                <Icon type="Foundation" name="marker"
                      style={{color: '#D2D2D2', position: 'absolute', left: 17, top: 13, fontSize: 24}}
                />
              </View>
            </View>
            <View style={{marginTop: 20}}>
              <Label>Un service</Label>
              <View style={{borderColor: '#EEE', borderWidth: 1, borderRadius: 7, paddingLeft: 20, paddingRight: 20, marginTop: 20}}>
                <Item picker style={{borderBottomWidth: 0}}>
                  <Picker
                    mode="dialog"
                    name="service"
                    iosIcon={<Icon name="arrow-down" style={{color: COLORS.black_text}}/>}
                    placeholder="Choisissez votre service"
                    placeholderStyle={{color: COLORS.lightGray}}
                    placeholderIconColor={COLORS.black_text}
                    selectedValue={this.state.service}
                    onValueChange={(value) => this.onInputChange('service', value)}
                  >
                    {
                      ['', 'Luxe', 'Standard', 'Économique'].map((itm, idx) => <Picker.Item key={idx} label={itm || 'All'} value={itm}/>)
                    }
                  </Picker>
                </Item>
              </View>
            </View>
          </Form>
        </ScrollView>
        <View style={{paddingLeft: 16, paddingRight: 16, marginTop: 20, marginBottom: 20}}>
          <Button
            block
            rounded
            style={{backgroundColor: COLORS.sky}}
            onPress={() => {
              this.applyFilters();
            }}
          >
            <Label style={{color: 'white', fontWeight: 'bold'}}>Apply filters</Label>
          </Button>
        </View>
      </View>
    );
  }
}
