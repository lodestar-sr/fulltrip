import firebase from "../../firebase";
import {Toast} from "native-base";

const Auth = firebase.auth();

export const errorMessageFR = {
  "auth/email-already-in-use": "Cet email existe déjà",
};

export const signInUser = (email, password) => {
  return Auth.signInWithEmailAndPassword(email, password);
};

export const signUpUser = (email, password) => {
  return Auth.createUserWithEmailAndPassword(email, password);
};

export const signOut = () => {
  Auth.signOut()
    .then(function () {
      // Sign-out successful.
    })
    .catch(function (error) {
      // An error happened.
    });
};

export function toastShow(err) {
  Toast.show({
    text: err.errorMessage,
    buttonText: "Se connecter",
    buttonTextStyle: {color: "#FFF"},
    buttonStyle: {backgroundColor: "#5cb85c", borderRadius: 100},
    duration: 3000,
  });
}
