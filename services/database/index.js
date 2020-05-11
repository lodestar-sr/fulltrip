const firebase = require("firebase");
// Required for side-effects
require("firebase/firestore");
const db = firebase.firestore();

export const insertLot = (res) => {
  db.collection("lots")
    .add({
      active: res.active,
      arrival_access_type: res.arrival_access_type,
      arrival_address: res.arrival_address,
      client_uid: res.client_uid,
      client_validation: res.client_validation,
      comments: res.comments,
      currentStep: res.currentStep,
      finished: res.finished,
      owner_uid: res.owner_uid,
      owner_validation: res.owner_validation,
      photo_url: res.photo_url,
      price: res.price,
      quantity: res.quantity,
      service: res.service,
      starting_access_type: res.starting_access_type,
      starting_address: res.starting_address,
    })
    .then(function (docRef) {
      console.log("Document written with ID: ", docRef.id);
    })
    .catch(function (error) {
      console.error("Error adding document: ", error);
    });
};
