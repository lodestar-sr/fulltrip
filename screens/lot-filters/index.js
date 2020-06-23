import React, {useEffect, useState} from "react";
import {connect} from "react-redux";
import { bindActionCreators } from 'redux';

import {ScrollView, View} from "react-native";
import {COLORS} from "../../styles/colors.js";
import {Button, Form, Header, Icon, Item, Label, Picker, Text, Title} from "native-base";
import GooglePlacesAutocomplete from "react-native-google-places-autocomplete";
import Select from "../../components/common/Select";
import RangePicker from "../../components/common/range-picker";

import * as TripAction from "../../actions/trip";

const LotFilters = ({
  navigation, filter, setFilter,
}) => {
  const [currentFilter, setCurrentFilter] = useState({});

  useEffect(() => {
    const newFilter = {
      minPrice: 100,
      maxPrice: 10000,
      departureAddress: '',
      arrivalAddress: '',
      service: '',
      size: 100,
      ...filter,
    };
    if (filter && filter.price) {
      newFilter.minPrice = filter.price.min;
      newFilter.maxPrice = filter.price.max;
    }
    setCurrentFilter(newFilter);
  }, [filter]);

  const onInputChange = (name, value) => {
    setCurrentFilter({
      ...currentFilter,
      [name]: value,
    });
  };

  const onPriceChange = (value) => {
    setCurrentFilter({
      ...currentFilter,
      minPrice: value.start,
      maxPrice: value.end,
    });
  };

  const onApplyFilter = () => {
    setFilter({
      ...currentFilter,
      price: {
        min: currentFilter.minPrice,
        max: currentFilter.maxPrice,
      },
    });
    navigation.pop();
  };

  return (
    <View style={{backgroundColor: "#FFF", height: '100%'}}>
      <Header
        androidStatusBarColor={COLORS.primary_white}
        style={{
          backgroundColor: COLORS.primary_white,
          borderBottomColor: '#eee',
          borderBottomWidth: 1,
          display: 'flex',
          alignItems: 'center',
        }}
        noShadow
      >
        <Title style={{ color: COLORS.black_text, fontSize: 20 }}>
          Filtres
        </Title>
        <Button
          transparent
          style={{
            position: 'absolute',
            left: 10
          }}
          onPress={() => navigation.navigate("Home")}
        >
          <Text uppercase={false} style={{ fontSize: 16, color: COLORS.lightGray }}>
            Annuler
          </Text>
        </Button>
      </Header>
      <ScrollView
        showsVerticalScrollIndicator={false}
        style={{backgroundColor: "#FFF", flex: 1}}
      >
        <Form style={{paddingTop: 40, paddingLeft: 30, paddingRight: 30}}>
          <View style={{ marginBottom: 20 }}>
            <Label style={{ color: COLORS.black_text, marginBottom: 20 }}>Échelle des prix</Label>
            <RangePicker
              min={100}
              max={10000}
              value={{start: currentFilter.minPrice, end: currentFilter.maxPrice}}
              unit="€"
              onChange={onPriceChange}
            />
          </View>
          <View style={{ marginBottom: 20 }}>
            <Label style={{ color: COLORS.black_text, marginBottom: 20 }}>Quantité</Label>
            <RangePicker
              min={5}
              max={100}
              value={{end: currentFilter.size}}
              unit="m³"
              labelSuffix="m³"
              onChange={(value) => onInputChange('size', value.end)}
            />
          </View>
          <View style={{marginTop: 20}}>
            <Label style={{ color: COLORS.black_text }}>Adresse de départ</Label>
            <View style={{position: 'relative', marginTop: 20}}>
              <GooglePlacesAutocomplete
                placeholder="Entrez s'il vous plait"
                placeholderTextColor="#999"
                text={currentFilter.departureAddress}
                minLength={2}
                autoFocus={false}
                fetchDetails={true}
                listViewDisplayed={false}
                onPress={(data, details = null) => {
                  onInputChange("departureAddress", data);
                }}
                query={{
                  key: 'AIzaSyAviivTDt0XzleVXCCrY3TDqeHZkaEjB4U',
                  language: 'en'
                }}
                styles={{
                  textInputContainer: {
                    backgroundColor: 'white',
                    borderColor: '#EEE',
                    borderTopColor: '#EEE',
                    borderBottomColor: '#EEE',
                    borderTopWidth: 1,
                    borderBottomWidth: 1,
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
                    style={{color: '#BBFFBA', position: 'absolute', left: 17, top: 13, fontSize: 24}}
              />
            </View>
          </View>
          <View style={{marginTop: 20}}>
            <Label style={{ color: COLORS.black_text }}>Adresse d'arrivée</Label>
            <View style={{position: 'relative', marginTop: 20}}>
              <GooglePlacesAutocomplete
                placeholder="Entrez s'il vous plait"
                placeholderTextColor="#999"
                minLength={2}
                autoFocus={false}
                fetchDetails={true}
                listViewDisplayed={false}
                onPress={(data, details = null) => {
                  onInputChange("arrivalAddress", data);
                }}
                query={{
                  key: 'AIzaSyAviivTDt0XzleVXCCrY3TDqeHZkaEjB4U',
                  language: 'en'
                }}
                styles={{
                  textInputContainer: {
                    backgroundColor: 'rgba(0,0,0,0)',
                    borderColor: '#EEE',
                    borderTopColor: '#EEE',
                    borderBottomColor: '#EEE',
                    borderTopWidth: 1,
                    borderBottomWidth: 1,
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
                    style={{color: '#ABBEFF', position: 'absolute', left: 17, top: 13, fontSize: 24}}
              />
            </View>
          </View>
          <View style={{marginTop: 20}}>
            <Label style={{ color: COLORS.black_text }}>Un service</Label>
            <View style={{borderColor: '#EEE', borderWidth: 1, borderRadius: 7, paddingLeft: 20, paddingRight: 20, marginTop: 20}}>
              <Item picker style={{borderBottomWidth: 0}}>
                <Picker
                  mode="dropdown"
                  name="service"
                  iosIcon={<Icon name="arrow-down" style={{color: COLORS.black_text}}/>}
                  placeholder="Choisissez votre service"
                  placeholderStyle={{color: COLORS.lightGray}}
                  placeholderIconColor={COLORS.black_text}
                  selectedValue={currentFilter.service}
                  onValueChange={(value) => onInputChange('service', value)}
                  modalStyle={{ top: 100 }}
                >
                  {
                    ['', 'Luxe', 'Standard', 'Économique'].map((itm, idx) => (
                      <Picker.Item key={idx} label={itm || 'All'} value={itm}/>
                    ))
                  }
                </Picker>
              </Item>
            </View>
            {/* <Select
              label="Un service"
              options={['Luxe', 'Standard', 'Économique']}
              placeholder="Choisissez votre service"
              value={currentFilter.service}
              onChange={(value) => onInputChange('service', value)}
            /> */}
          </View>
        </Form>
      </ScrollView>
      <View style={{paddingLeft: 16, paddingRight: 16, marginTop: 20, marginBottom: 20}}>
        <Button
          block
          rounded
          style={{backgroundColor: COLORS.sky}}
          onPress={onApplyFilter}
        >
          <Label style={{color: 'white', fontWeight: 'bold'}}>Appliquer des filtres</Label>
        </Button>
      </View>
    </View>
  );
};

const mapStateToProps = (store) => {
  return {
    filter: store.trip.filter,
  };
};

const mapDispatchToProps = (dispatch) => (
  bindActionCreators(
    {
      setFilter: TripAction.setFilter,
    },
    dispatch,
  )
);

export default connect(mapStateToProps, mapDispatchToProps)(LotFilters);
