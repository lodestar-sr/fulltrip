import React, { useState, useEffect, useRef } from "react";
import { View, TouchableHighlight, TouchableOpacity, PanResponder, Dimensions } from "react-native";
import { Button, Icon, Label } from "native-base";
import { LinearGradient } from "expo-linear-gradient";
import { COLORS } from "../../../styles/colors";
let {width, height} = Dimensions.get("window");

const BAR_WIDTH = width-60;

const RangePicker = ({min, max, value, unit, labelSuffix, barStyle}) => {
  const [start, setStart] = useState(value.start);
  const [end, setEnd] = useState(value.end);
  const range = max - min;

  const _updatePosition = (dx) => {
  };

  const _handleMoveShouldSetPanResponder = (e, gestureState) => {
    return true;
  };
  const _handlePanResponderMove = (e, gestureState) => {
    setEnd(Math.round(end + gestureState.dx * range / BAR_WIDTH));
  };
  const _panResponder = PanResponder.create( {
      onMoveShouldSetPanResponder: _handleMoveShouldSetPanResponder,
      onPanResponderMove: _handlePanResponderMove,
    });
  const style = {
    container: {
      flexDirection: "row",
      width: BAR_WIDTH,
      ...barStyle,
    },
    bar: {
      height: 8,
      backgroundColor: "#E4E4E4",
      flex: 1,
      marginHorizontal: 5,
      alignSelf: "center",
      position: "relative",
    },
    suffix: {
      color: COLORS.lightGray,
    },
    activeBar: {
      backgroundColor: "#40BFFF",
      marginLeft: !!value.end ? `${start/range*100}%` : 0,
      width: !!value.end ?
        `${(end-start) / range * 100}%` :
        `${start / range * 100}%`,
      height: "100%",
    },
    control: {
      width: 30,
      height: 30,
      borderRadius: 15,
      borderColor: "#FFF",
      borderWidth: 5,
      alignItems: "center",
      justifyContent: "center",
    }
  };

  const Control = ({value, currency, point}) => (
    <View
      style={{
        top: -10,
        position: "absolute",
        left: `${value/range*100}%`,
        marginLeft: -15,
        alignItems: "center",
      }}
      point={point}
      {..._panResponder.panHandlers}
    >
      <TouchableOpacity style={{ borderWidth: 1, borderColor: '#eee', borderRadius: 15 }}>
        <LinearGradient
          style={{ ...style.control }}
          colors={["#5CC9FF", "#C8EEFF"]}
          start={[0, 1]}
          end={[1, 0]}
        >
          <Icon
            type='FontAwesome5'
            name='check'
            style={{ color: 'white', fontSize: 12 }}
          />
        </LinearGradient >
      </TouchableOpacity>
      <Label
        style={{
          fontSize: 12,
          ...style.suffix
        }}
      >
        {`${value}${unit || ''}`}
      </Label>
    </View>
  );


  return(
    <View style={style.container}>
      <Label style={style.suffix}>{min}</Label>
      <View style={style.bar}>
        <View style={style.activeBar}>
        </View>
        <Control value={start} currency={value.suffix} point="first" />
        {end !== undefined && <Control value={end} currency={value.suffix} point="end" />}
      </View>
      <Label style={style.suffix}>{max}</Label>
    </View>
  );
};

export default RangePicker;

