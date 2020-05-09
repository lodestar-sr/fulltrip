import * as firebase from "firebase";
const Auth = firebase.auth();
import { Toast } from "native-base";

export const errorMessageFR = {
  "auth/email-already-in-use": "Cet email existe déjà",
};

export const signInUser = (email, password) => {
  Auth.signInWithEmailAndPassword(email, password).catch(function (error) {
    // Handle Errors here.
    var errorCode = error.code;
    var errorMessage = error.message;
    console.log(errorCode);
    // ...
  });
};

export const signUpUser = (email, password) => {
  Auth.createUserWithEmailAndPassword(email, password).catch(function (error) {
    // Handle Errors here.
    var errorCode = error.code;
    let errorMessage = errorMessageFR[errorCode];

    if (errorMessage) {
      toastShow({ errorMessage });
    }

    // ...
  });
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
    buttonTextStyle: { color: "#FFF" },
    buttonStyle: { backgroundColor: "#5cb85c", borderRadius: 100 },
    duration: 3000,
  });
}
