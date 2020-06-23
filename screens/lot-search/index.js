import React from "react";
import {bindActionCreators} from "redux";
import {connect} from "react-redux"
import {ScrollView, StyleSheet, View} from "react-native";
import { LOT_DETAILS } from "../../mock.js";

import { COLORS } from "../../styles/colors.js";
import { Button, Icon, Label, Text } from "native-base";
import * as TripAction from "../../actions/trip";
import LotFilterBar from "../../components/lot-filter-bar";
import LotSearchCard from "../../components/lot-search-card";

const LotSearch = ({
  navigation, filter, setFilter,
}) => {
  const onGoFilterPage = () => {
    navigation.navigate("LotFilters");
  };

  const onCardClick = (travel) => {
    navigation.navigate("LotDetails", { travel });
  };

  const travels = filter
    ? (
      LOT_DETAILS.data.filter((travel) => {
        if (filter.departureAddress && filter.departureAddress.toLowerCase() !== travel.lot.starting_city.toLowerCase())
          return false;
        if (filter.price && (filter.price.min > travel.price || filter.price.max < travel.price))
          return false;
        if (filter.service && filter.service !== travel.service)
          return false;
        return !(filter.size && filter.size < travel.lot.size);
      })
    )
    : LOT_DETAILS.data;

  return (
    <View style={{ backgroundColor: COLORS.primary_white, padding: 20, height: '100%' }}>
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
          onPress={onGoFilterPage}
        >
          <Icon type="Ionicons" name="options" style={{ color: COLORS.sky, fontSize: 22 }} />
          <Label style={{ color: COLORS.lightGray, marginRight: 15, fontSize: 18 }}>Filtres</Label>
        </Button>
        {
          filter && !filter.departureAddress
            ? (
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
            )
            : null
        }
      </View>

      {
        filter
          ? <LotFilterBar />
          : null
      }

      <View style={{ flex: 1, backgroundColor: COLORS.primary_white, marginTop: 10 }}>
        {
          travels.length
            ? (
              <ScrollView showsVerticalScrollIndicator={false}>
                {
                  travels.map((travel) => <LotSearchCard key={travel.travel_id} travel={travel} onClick={onCardClick} />)
                }
              </ScrollView>
            )
            : (
              <Text
                style={{
                  color: COLORS.lightGray,
                  fontSize: 20,
                  lineHeight: 40,
                  textAlign: 'center',
                  padding: 20,
                  paddingLeft: 30,
                  paddingRight: 30,
                }}
              >
                Désolé, la recherche n'a donné aucun résultat. Essayez de sélectionner d'autres fitres.
              </Text>
            )
        }
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
