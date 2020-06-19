import React from "react";
import { ScrollView, View } from "react-native";
import { COLORS } from "../../styles/colors.js";
import {
  Button,
  Form,
  Footer,
  Header,
  Icon,
  Input,
  Item,
  Label,
  Picker,
  Text,
  Title
} from "native-base";
import FooterComponent from "../../components/footer";

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
      <View style={{ backgroundColor: "#FFF", height: '100%', display: 'flex', flexDirection: 'column' }}>
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
            Filters
          </Title>
          <Button
            transparent
            style={{
              position: 'absolute',
              left: 10
            }}
            onPress={() => this.props.navigation.navigate("SearchLot")}
          >
            <Text uppercase={false} style={{ fontSize: 16, color: COLORS.lightGray }}>
              Cancel
            </Text>
          </Button>
        </Header>
        <ScrollView
          showsVerticalScrollIndicator={false}
          style={{ backgroundColor: "#FFF", flex: 1 }}
        >
          <Form style={{ paddingTop: 40, paddingLeft: 30, paddingRight: 30 }}>
            <View>
              <Label>Price Range</Label>
              <Input />
            </View>
            <View style={{ marginTop: 20 }}>
              <Label>Departure Address</Label>
              <View style={{ position: 'relative', marginTop: 20 }}>
                <Input placeholder="Please enter" placeholderTextColor="#E4E4E4"
                       style={{ borderColor: '#EEE', borderWidth: 1, borderRadius: 7, paddingLeft: 40 }}
                       onChangeText={(val) => this.onInputChange("departureAddress", val)}
                />
                <Icon type="Foundation" name="marker"
                      style={{ color: '#D2D2D2', position: 'absolute', left: 17, top: 13, fontSize: 24 }}
                />
              </View>
            </View>
            <View style={{ marginTop: 20 }}>
              <Label>Arrival Address</Label>
              <View style={{ position: 'relative', marginTop: 20 }}>
                <Input placeholder="Please enter" placeholderTextColor="#E4E4E4"
                       style={{ borderColor: '#EEE', borderWidth: 1, borderRadius: 7, paddingLeft: 40 }}
                       onChangeText={(val) => this.onInputChange("arrivalAddress", val)}
                />
                <Icon type="Foundation" name="marker"
                      style={{ color: '#D2D2D2', position: 'absolute', left: 17, top: 13, fontSize: 24 }}
                />
              </View>
            </View>
            <View style={{ marginTop: 20 }}>
              <Label>Service</Label>
              <View style={{ borderColor: '#EEE', borderWidth: 1, borderRadius: 7, paddingLeft: 20, paddingRight: 20, marginTop: 20 }}>
                <Item picker style={{ borderBottomWidth: 0 }}>
                  <Picker
                      mode="dialog"
                      name="starting_location_type"
                      iosIcon={<Icon name="arrow-down" style={{ color: COLORS.black_text }} />}
                      placeholder="Choose your service"
                      placeholderStyle={{ color: COLORS.lightGray }}
                      placeholderIconColor={COLORS.black_text}
                      selectedValue={this.state.service}
                      onValueChange={(value) => this.onInputChange('service', value)}
                  >
                    {
                      ['', 'Train', 'Bus', 'Taxi', 'Plane'].map((itm, idx) => <Picker.Item key={idx} label={itm || 'All'} value={itm} />)
                    }
                  </Picker>
                </Item>
              </View>
            </View>
          </Form>
        </ScrollView>
        <View style={{ paddingLeft: '10%', paddingRight: '10%', marginTop: 20, marginBottom: 20 }}>
          <Button
            block
            rounded
            style={{ backgroundColor: COLORS.sky }}
            onPress={() => {
              this.applyFilters();
            }}
          >
            <Label style={{ color: 'white', fontWeight: 'bold' }}>Apply filters</Label>
          </Button>
        </View>
        <FooterComponent
            backgroundColor={COLORS.primary_white}
            hasLabel
        />
      </View>
    );
  }
}
