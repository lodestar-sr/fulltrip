import * as firebase from "firebase";
import { SET_CURRENT_USER } from "../actions/action-types";

export const getCurrentUser = () => async (dispatch) => {
  await firebase.auth().onAuthStateChanged(function (user) {
    if (user) {
      dispatch({ type: SET_CURRENT_USER, payload: user });
    } else {
      // No user is signed in.
    }
  });
};
