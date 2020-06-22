import React from "react";
import {bindActionCreators} from "redux";
import {connect} from "react-redux"
import {ScrollView, StyleSheet, View} from "react-native";

import { COLORS } from "../../styles/colors.js";
import {Button, Form, Header, Icon, Item, Label, Picker, Text, Title} from "native-base";
import {Feather, FontAwesome, Ionicons} from "@expo/vector-icons";
import * as TripAction from "../../actions/trip";
import GooglePlacesAutocomplete from "react-native-google-places-autocomplete";

const LotSearch = ({
  navigation, filter, setFilter,
}) => {
  return (
    <View style={{ backgroundColor: COLORS.primary_white, padding: 20 }}>
      <View style={{ flexDirection: 'row', marginBottom: 20 }}>
        <Button
          block
          transparent
          style={{
            borderWidth: 2,
            borderColor: COLORS.lightSky,
            borderRadius: 7,
            height: 40,
          }}
        >
          <Icon type="Ionicons" name="options" style={{ color: COLORS.sky, fontSize: 22 }} />
          <Label style={{ color: COLORS.lightGray, marginRight: 15, fontSize: 18 }}>Filtres</Label>
        </Button>
        <Button
          block
          transparent
          style={{
            borderRadius: 7,
            backgroundColor: COLORS.sky,
            height: 40,
            marginLeft: 10,
          }}
        >
          <Icon type="FontAwesome" name="location-arrow" style={{ color: 'white', fontSize: 22 }} />
          <Label style={{ color: 'white', marginRight: 15, fontSize: 16, fontWeight: 'bold' }}>Voyage proches de moi</Label>
        </Button>
      </View>

      <ScrollView horizontal style={{ flexDirection: 'row' }}>
        <Button block transparent style={style.filterBtn}>
          <Icon type="Foundation" name="marker" style={{ color: '#D2D2D2', fontSize: 22, marginLeft: 5, marginRight: 10 }} />
          <Label style={style.filterText}>Paris</Label>
        </Button>
        <Button block transparent style={style.filterBtn}>
          <Label style={{ ...style.filterText, fontWeight: 'bold' }}>600€-700€</Label>
          <Button block transparent>
            <Icon type="Ionicons" name="close" style={{ color: COLORS.lightGray, fontSize: 24, marginBottom: 25, marginLeft: 15, marginRight: 0 }} />
          </Button>
        </Button>
        <Button block transparent style={style.filterBtn}>
          <Label style={style.filterText}>Luxe</Label>
        </Button>
        <Button block transparent style={style.filterBtn}>
          <Label style={style.filterText}>53m³</Label>
        </Button>
      </ScrollView>

      <View style={{ flexDirection: 'row-reverse' }}>
        <Button block transparent>
          <Label style={{ color: COLORS.sky, fontSize: 20, fontStyle: 'bold' }}>Réinitialiser</Label>
        </Button>
      </View>
    </View>
  )
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

const style = StyleSheet.create({
  filterBtn: {
    borderWidth: 2,
    borderColor: '#D2D2D2',
    borderRadius: 7,
    marginRight: 10,
    height: 35,
    paddingLeft: 15,
    paddingRight: 15,
  },
  filterText: {
    color: COLORS.lightGray,
    fontSize: 14,
  },
});

export default connect(mapStateToProps, mapDispatchToProps)(LotSearch);
