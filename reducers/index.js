import { combineReducers } from "redux";
import ProfileReducer from "./profile";

const rootReducer = combineReducers({
  profile: ProfileReducer,
});

export default rootReducer;
