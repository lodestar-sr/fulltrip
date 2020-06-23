import React from "react";
import {bindActionCreators} from "redux";
import {connect} from "react-redux"
import {ScrollView, StyleSheet, View} from "react-native";

import { COLORS } from "../../styles/colors.js";
import { Button, Icon, Label } from "native-base";
import * as TripAction from "../../actions/trip";

const LotFilterBar = ({
  filter, setFilter,
}) => {
  const onClearFilter = (name) => {
    if (name) {
      setFilter({
        ...filter,
        [name]: null,
      });
    } else {
      setFilter(null);
    }
  };

  return (
    <>
      <View>
        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ flexDirection: 'row' }}>
          {
            filter.departureAddress
              ? (
                <Button block transparent style={style.filterBtn}>
                  <Icon type="Foundation" name="marker" style={{ color: '#D2D2D2', fontSize: 22, marginLeft: 5, marginRight: 10 }} />
                  <Label style={style.filterText}>{filter.departureAddress}</Label>
                </Button>
              )
              : null
          }
          {
            filter.price
              ? (
                <Button block transparent style={style.filterBtn}>
                  <Label style={{ ...style.filterText, fontWeight: 'bold' }}>{`${filter.minPrice}€-${filter.maxPrice}€`}</Label>
                  <Button block transparent onPress={() => onClearFilter('price')}>
                    <Icon type="Ionicons" name="close" style={{ color: COLORS.lightGray, fontSize: 24, marginBottom: 25, marginLeft: 15, marginRight: 0 }} />
                  </Button>
                </Button>
              )
              : null
          }
          {
            filter.service
              ? (
                <Button block transparent style={style.filterBtn}>
                  <Label style={style.filterText}>{filter.service}</Label>
                </Button>
              )
              : null
          }
          {
            filter.size
              ? (
                <Button block transparent style={style.filterBtn}>
                  <Label style={style.filterText}>{filter.size}m³</Label>
                </Button>
              )
              : null
          }
        </ScrollView>
      </View>

      <View style={{ flexDirection: 'row-reverse', marginBottom: 10 }}>
        <Button block transparent onPress={() => onClearFilter()}>
          <Label style={{ color: COLORS.sky, fontSize: 20, fontWeight: 'bold' }}>Réinitialiser</Label>
        </Button>
      </View>
    </>
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

export default connect(mapStateToProps, mapDispatchToProps)(LotFilterBar);
