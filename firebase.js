window.addEventListener = (x) => x;
import * as firebase from "firebase";
const firebaseConfig = {
  apiKey: "AIzaSyA1bL0g3QQatTU161FYTNr8sujJBqkXUkw",
  authDomain: "fulltrip.firebaseapp.com",
  databaseURL: "https://fulltrip.firebaseio.com",
  projectId: "fulltrip",
  storageBucket: "fulltrip.appspot.com",
  messagingSenderId: "77728748956",
  appId: "1:77728748956:web:f6ad76a3abf5f2fda5e459",
  measurementId: "G-R68X35NNVS",
};
firebase.initializeApp(firebaseConfig);
