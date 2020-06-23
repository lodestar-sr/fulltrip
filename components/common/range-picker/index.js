import React, { useState, useEffect } from "react";
import { View, TouchableWithoutFeedback, PanResponder, Dimensions } from "react-native";
import {Icon, Label} from "native-base";
import { LinearGradient } from "expo-linear-gradient";
import { COLORS } from "../../../styles/colors";
let {width} = Dimensions.get("window");

const BAR_WIDTH = width-160;

export const Control = ({value, min, floor, ceil, unit, point, range, onMove}) => {
  const leftOffset = (value-min) * BAR_WIDTH /range;
  const minLeftOffset = (floor-min) * BAR_WIDTH / range;
  const maxLeftOffset = (ceil-min) * BAR_WIDTH / range;
  const style = {
    suffix: {
      color: COLORS.lightGray,
      fontSize: 15,
      position: "absolute",
      top: 30,
      textAlign: "center",
      width: 150,
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
  const _handleMoveShouldSetPanResponder = (e, gestureState) => {
    return true;
  };
  const _handlePanResponderMove = (e, gestureState) => {
    const movedLeft = leftOffset + gestureState.dx;
    if(movedLeft < minLeftOffset) onMove(floor);
    else {
      if(movedLeft > maxLeftOffset) onMove(ceil);
      else {
        onMove(Math.round(movedLeft*range/BAR_WIDTH)+min);
      }
    }
  };
  const _panResponder = PanResponder.create({
    onMoveShouldSetPanResponder: _handleMoveShouldSetPanResponder,
    onPanResponderMove: _handlePanResponderMove,
  });
  return(
    <View
      style={{
        top: -5,
        position: "absolute",
        left: leftOffset,
        alignItems: "center",
        marginLeft: -15,
      }}
      point={point}
    >
      <View
        style={{
          borderColor: "#F5F5F5",
          borderWidth: 1,
          borderRadius: 20,
        }}
        {..._panResponder.panHandlers}
      >
        <LinearGradient
          style={{...style.control}}
          colors={["#5CC9FF", "#C8EEFF"]}
          start={[0,1]}
          end={[1,0]}
        >
          <Icon
            type='FontAwesome5'
            name='check'
            style={{ color: 'white', fontSize: 12 }}
          />
        </LinearGradient >
      </View>
      <Label
        style={{...style.suffix}}
      >
        {value}{!!unit && unit}
      </Label>
    </View>
  );
};

export default ({min, max, value, unit, labelSuffix, onChange, ...props}) => {
  const [start, setStart] = useState(value.start || min);
  const [end, setEnd] = useState(value.end || max);
  const range = max-min;
  const updatePosition = (locationX) => {
    const updateValue = Math.round(locationX * range / BAR_WIDTH) + min;
    if(Math.abs(updateValue - start) <= Math.abs(updateValue - end)) {
      !!value.start ? setStart(updateValue) : setEnd(updateValue);
    } else {
      !!value.end ? setEnd(updateValue) : setStart(updateValue);
    }
  };

  useEffect(() => {
    onChange({start, end});
  }, [start, end]);

  useEffect(() => {
    setStart(value.start || min);
    setEnd(value.end || max);
  }, [value]);

  const style = {
    container: {
      flexDirection: "row",
      justifyContent: "space-between",
      paddingVertical: 10,
    },
    bar: {
      width: BAR_WIDTH,
      height: 8,
      backgroundColor: "#E4E4E4",
      position: "relative",
    },
    suffix: {
      color: COLORS.lightGray,
      fontSize: 15,
    },
    activeBar: {
      position: !!value.start && !!value.end ? "absolute" : "relative",
      backgroundColor: "#40BFFF",
      marginLeft: !!value.start ? (start-min)*BAR_WIDTH/range : 0,
      width: (end-start)*BAR_WIDTH/range,
      height: 8,
    }
  };

  return(
    <View style={{...style.container, ...props.style}}>
      <Label style={{...style.suffix, flex:2}}>{min}{!!labelSuffix && labelSuffix}</Label>
      <View style={{justifyContent: "center"}}>
        <TouchableWithoutFeedback
          onPressIn={e => {updatePosition(e.nativeEvent.locationX)}}
        >
          <View style={style.bar}>
          {(!value.start || !value.end) && <View style={style.activeBar} />}
          </View>
        </TouchableWithoutFeedback>
        {!!value.start && !!value.end && <View style={style.activeBar} />}
        {!!value.start &&
          <Control
            value={start}
            min={min}
            floor={min}
            ceil={end}
            unit={unit}
            range={range}
            onMove={setStart}
          />
        }
        {!!value.end &&
          <Control
            value={end}
            min={min}
            floor={start}
            ceil={max}
            unit={unit}
            range={range}
            onMove={setEnd}
            disable={!value.end}
          />
        }
      </View>
      <Label style={{...style.suffix, flex: 3, textAlign: "right"}}>{max}{!!labelSuffix && labelSuffix}</Label>
    </View>
  );
};

