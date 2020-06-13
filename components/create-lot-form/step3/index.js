import React from "react";
import {Image, View} from "react-native";
import {Button, Form, H1, Icon, Input, Item, Label, Text, Textarea,} from "native-base";
import * as ImagePicker from 'expo-image-picker';

export const Step3 = (props) => {
  if (props.currentStep !== 3) {
    // Prop: The current step
    return null;
  }

  let openImagePickerAsync = async () => {
    let permissionResult = await ImagePicker.requestCameraRollPermissionsAsync();

    if (permissionResult.granted === false) {
      alert("Permission to access camera roll is required!");
      return;
    }

    let pickerResult = await ImagePicker.launchCameraAsync();
    // let pickerResult = await ImagePicker.launchImageLibraryAsync();
    console.log(pickerResult);

    if (pickerResult && pickerResult.uri) {
      props.handleChange("photo_url", pickerResult.uri);
    }
  }

  return (
    <View>
      <View
        style={{
          alignItems: "center",
          marginHorizontal: 20,
          marginVertical: 40,
        }}
      >
        <H1 style={{color: "#FFF", textAlign: "center"}}>Derniers détails</H1>
        <Text style={{color: "#FFF", textAlign: "center"}}>
          Les lots avec photo et description détaillée sont 4 fois plus visités.
          Pensez-y !
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
          {
            props.photo_url ?
              <View style={{
                flexDirection: 'row',
                justifyContent: 'center'
              }}
              >
                <Image source={{uri: props.photo_url}} style={{width: 150, aspectRatio: 1080 / 1920}}/>
              </View> : null
          }
          <Button
            bordered
            style={{justifyContent: "center", marginVertical: 10}}
            onPress={openImagePickerAsync}
          >
            <Icon name="camera"></Icon>
            <Text>
              {
                !props.photo_url ? 'Ajouter une photo' : 'Modifier votre photo'
              }
            </Text>
          </Button>
          <Textarea
            bordered
            style={{paddingVertical: 10, borderRadius: 10}}
            placeholderTextColor="#CDCDCD"
            rowSpan={5}
            placeholder="Détaillez votre lot"
            name="comments"
            value={props.comments}
            onChange={(v) => {
              props.handleChange("comments", v.nativeEvent.text);
            }}
          />
          <Item floatingLabel style={{marginVertical: 10}}>
            <Label style={{lineHeight: 14}}>Prix</Label>
            <Input
              keyboardType="number-pad"
              name="price"
              value={props.price}
              onChange={(v) => {
                props.handleChange("price", v.nativeEvent.text);
              }}
            />
          </Item>
        </Form>
      </View>
    </View>
  );
};
