import React, {useState} from "react";
import {ScrollView, StyleSheet, View, TouchableHighlight, TouchableOpacity} from "react-native";
import {COLORS} from "../../../styles/colors.js";
import {Button, Form, Header, Icon, Input, Item, Label, Picker, Text, Title} from "native-base";
import {Feather, FontAwesome, Ionicons} from "@expo/vector-icons";

const Select = ({
  label, options, value, placeholder, onChange,
  style, labelStyle, selectBoxStyle, textStyle, placeholderStyle, dropdownStyle, optionStyle,
}) => {
  const [collapsed, setCollapsed] = useState(true);

  const toggleCollapse = () => {
    setCollapsed(!collapsed);
  };

  const onOptionSelect = (option) => {
    onChange(option);
    toggleCollapse();
  };

  const mStyle = {
    select: {
      marginTop: 20,
      ...style,
    },
    label: {
      color: COLORS.black_text,
      fontWeight: 'bold',
      marginBottom: 15,
      ...labelStyle,
    },
    selectBox: {
      borderWidth: 1,
      borderColor: '#EEE',
      borderRadius: 7,
      borderBottomLeftRadius: collapsed ? 7 : 0,
      borderBottomRightRadius: collapsed ? 7 : 0,
      padding: 20,
      ...selectBoxStyle,
    },
    text: {
      color: COLORS.black_text,
      ...textStyle,
    },
    placeholder: {
      color: COLORS.lightGray,
    },
    dropdownIcon: {
      fontSize: 20,
      color: COLORS.black_text,
      position: 'absolute',
      fontWeight: 'normal',
      top: 20,
      right: 20,
    },
    dropdownMenu: {
      maxHeight: 200,
      width: '100%',
      borderWidth: 2,
      borderColor: '#EEE',
      ...dropdownStyle,
    },
    option: {
      paddingTop: 10,
      paddingLeft: 20,
      height: 40,
      color: COLORS.black_text,
      ...optionStyle,
    }

  };

  return (
    <View style={mStyle.select}>
      {
        label && <Label style={mStyle.label}>{label}</Label>
      }
      <TouchableOpacity onPress={toggleCollapse}>
        <View className="select-box" style={mStyle.selectBox}>
          {
            value
              ? <Text style={mStyle.text}>{value}</Text>
              : <Label style={mStyle.placeholder}>{placeholder}</Label>
          }
          <FontAwesome name={`angle-${collapsed ? 'down' : 'up'}`} style={mStyle.dropdownIcon} />
        </View>
      </TouchableOpacity>
      {
        !collapsed && (
          <ScrollView className="dropdown-menu" style={mStyle.dropdownMenu}>
            {
              options.map((option, index) => (
                <TouchableHighlight
                  key={index}
                  underlayColor="#B3E6FF"
                  onPress={() => onOptionSelect(option)}
                >
                  <Text
                    className="option"
                    style={{
                      backgroundColor: option === value ? "#B3E6FF" : "transparent",
                      ...mStyle.option
                    }}
                  >
                    {option}
                  </Text>
                </TouchableHighlight>
              ))
            }
          </ScrollView>
        )
      }
    </View>
  );
};

export default Select;
