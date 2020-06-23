import React from "react";
import {Image, ScrollView, View} from "react-native";
import {Button, Icon, Label, Text} from "native-base";
import {COLORS} from "../../styles/colors";
import {FontAwesome, Ionicons} from "@expo/vector-icons";
import moment from "moment";

const image = require("../../assets/detail-image.png");

const LotDetails = ({
  route, navigation
}) => {
  const travel = route.params.travel;

  const onBack = () => {
    navigation.pop();
  };

  const startTime = moment(travel.lot.delivry_start_date, 'DD/MM/YYYY hh:mm');
  const endTime = moment(travel.lot.delivry_end_date, 'DD/MM/YYYY hh:mm');
  const travelDuration = moment.duration(endTime.diff(startTime, 'm'), 'm');
  const travelTime = `${travelDuration.days() ? `${travelDuration.days()} day, ` : ''}${travelDuration.hours()} h. ${travelDuration.minutes()} min.`;

  return (
    <View style={{ backgroundColor: COLORS.primary_white, padding: 20, height: '100%' }}>
      <View style={{ marginBottom: 10 }}>
        <Button transparent onPress={onBack}>
          <FontAwesome name="angle-left" size={40} color="#393939" />
        </Button>
      </View>

      <ScrollView showsVerticalScrollIndicator={false} style={{ flex: 1 }}>
        <View style={{ width: '100%', aspectRatio: 900 / 375, marginBottom: 10 }}>
          <Image source={image} style={{width: '100%', height: '100%', borderRadius: 7}}/>
        </View>

        <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 10 }}>
          <Icon name="calendar" style={{ color: COLORS.lightGray, marginRight: 10, marginLeft: 3 }} />
          <Text style={{ fontSize: 18 }}>{startTime.format("DD.MM.YYYY")}</Text>
        </View>

        <View style={{ marginTop: 10, paddingBottom: 15, borderBottomWidth: 1, borderBottomColor: '#E9E9E9', marginBottom: 10 }}>
          <View style={{ flexDirection: 'row' }}>
            <View style={{ width: 12, height: 12, borderWidth: 1, borderColor: '#666', borderRadius: 10, marginTop: 6 }} />
            <Text style={{ marginLeft: 10, fontSize: 18, color: 'black', fontWeight: 'bold' }}>{travel.lot.starting_city}</Text>
          </View>
          <View style={{ flexDirection: 'row' }}>
            <View style={{ width: 17, height: 50, marginLeft: 5, borderLeftWidth: 2, borderLeftColor: '#666', borderStyle: 'dashed' }} />
            <Text style={{ fontSize: 16, color: COLORS.lightGray, marginTop: 3 }}>{travel.lot.starting_address}</Text>
          </View>
          <View style={{ margin: 10, flexDirection: 'row' }}>
            <Text style={{ fontSize: 16, color: 'black' }}>{travelTime}</Text>
            <Text style={{ fontSize: 16, color: 'black', marginLeft: 20 }}>({travel.lot.distance} km)</Text>
          </View>
          <View style={{ flexDirection: 'row', alignItems: 'flex-end' }}>
            <View style={{ width: 17, height: 50, marginLeft: 5, borderLeftWidth: 2, borderLeftColor: '#666', borderStyle: 'dashed' }} />
            <Text style={{ fontSize: 18, color: 'black', marginBottom: 3, fontWeight: 'bold' }}>{travel.lot.arrival_city}</Text>
          </View>
          <View style={{ flexDirection: 'row', alignItems: 'flex-end' }}>
            <View style={{ width: 12, height: 12, borderWidth: 1, borderColor: '#666', borderRadius: 10, marginBottom: 3 }} />
            <Text style={{ fontSize: 16, color: COLORS.lightGray, marginLeft: 10 }}>{travel.lot.arrival_address}</Text>
          </View>
        </View>

        <View style={{ paddingLeft: 5, paddingBottom: 10, borderBottomWidth: 1, borderBottomColor: '#E9E9E9', marginBottom: 10 }}>
          <Text style={{ color: COLORS.black_text, fontWeight: 'bold', fontSize: 17, marginBottom: 10 }}>Un service</Text>
          <Text style={{ color: COLORS.lightGray, fontWeight: 'bold', fontSize: 22 }}>{travel.service}</Text>
        </View>

        <View style={{ paddingLeft: 5, paddingBottom: 13, borderBottomWidth: 1, borderBottomColor: '#E9E9E9', marginBottom: 10 }}>
          <Text style={{ color: COLORS.black_text, fontWeight: 'bold', fontSize: 18, marginBottom: 10 }}>La description</Text>
          {
            travel.description.length <= 200
              ? (
                <Text style={{ color: COLORS.lightGray, fontSize: 14 }}>{travel.description}</Text>
              )
              : (
                <>
                  <Text style={{ color: COLORS.lightGray, fontSize: 14 }}>
                    {`${travel.description.substr(0, 200)} ...`}
                  </Text>
                  <Button transparent style={{ marginTop: -10, marginBottom: -10 }}>
                    <Label style={{ color: COLORS.sky, fontWeight: 'bold', fontSize: 15 }}>Plus</Label>
                  </Button>
                </>
              )
          }
        </View>

        <View style={{ flexDirection: 'row', alignItems: 'center', paddingLeft: 5, paddingBottom: 10, borderBottomWidth: 1, borderBottomColor: '#E9E9E9', marginBottom: 10 }}>
          <Text style={{ color: 'black', fontSize: 22, marginRight: 30 }}>Prix de l'expédition</Text>
          <Text style={{ color: '#666', fontWeight: 'bold', fontSize: 26 }}>{travel.price}€</Text>
        </View>

        <View style={{ paddingLeft: 5, marginBottom: 10, alignItems: 'flex-start' }}>
          <Text style={{ fontSize: 18, textTransform: 'uppercase', fontWeight: 'bold', color: 'black' }}>{travel.company}</Text>
          <Button transparent style={{ justifyContent: 'center' }}>
            <Ionicons name="ios-chatboxes" size={26} color={COLORS.sky} />
            <Label style={{ color: COLORS.sky, fontSize: 18, marginLeft: 15 }}>Contacter l'entreprise</Label>
          </Button>
        </View>

        <View style={{ marginTop: 10, marginBottom: 10 }}>
          <Button
            block
            rounded
            style={{backgroundColor: COLORS.sky}}
          >
            <Label style={{color: 'white', fontWeight: 'bold'}}>Réservez cet article</Label>
          </Button>
        </View>
      </ScrollView>
    </View>
  );
};

export default LotDetails;
