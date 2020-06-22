import { combineReducers } from "redux";
import UserReducer from "./user";
import TripReducer from "./trip";

const rootReducer = combineReducers({
  user: UserReducer,
  trip: TripReducer,
});

export default rootReducer;
