import * as firebase from "firebase";
import { TRIP_ACTION } from "../actions/action-types";

export const setFilter = (filter) => ({
  type: TRIP_ACTION.SET_FILTER,
  filter,
});
