import * as firebase from "firebase";
import { USER_ACTION } from "../actions/action-types";

export const getCurrentUser = () => async (dispatch) => {
  await firebase.auth().onAuthStateChanged(function (user) {
    if (user) {
      dispatch({ type: USER_ACTION.SET_CURRENT_USER, payload: user });
    } else {
      // No user is signed in.
    }
  });
};
