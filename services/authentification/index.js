import * as firebase from "firebase";
const Auth = firebase.auth();

export const signInUser = (email, password) => {
  Auth.signInWithEmailAndPassword(email, password).catch(function (error) {
    // Handle Errors here.
    var errorCode = error.code;
    var errorMessage = error.message;

    console.log(errorCode, errorMessage);
    // ...
  });
};

export const signUpUser = () => {
  Auth.createUserWithEmailAndPassword(email, password).catch(function (error) {
    // Handle Errors here.
    var errorCode = error.code;
    var errorMessage = error.message;
    // ...
  });
};
