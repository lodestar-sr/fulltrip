import moment from 'moment-timezone';
import firebase from '../../firebase';

require("firebase/firestore");

const storage = firebase.storage();
const db = firebase.firestore();

export const insertLot = async (res) => {
  uploadPhoto(res.photo_url).then(async snap => {
    const photoURL = await snap.ref.getDownloadURL();
    console.log(photoURL);

    db.collection("lots").add({
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
      photo_url: photoURL,
      price: res.price,
      quantity: res.quantity,
      service: res.service,
      starting_access_type: res.starting_access_type,
      starting_address: res.starting_address,
    })
      .then(docRef => {
        console.log("Document written with ID: ", docRef.id);
      })
      .catch(error => {
        console.error("Error adding document: ", error);
      });

  });
};

export const uploadPhoto = async (uri) => {
  const photo = await fetch(uri);
  const blob = await photo.blob();
  const ref = storage.ref().child('lots/Img_' + moment().format('YYYYMMDD_hhmmss') + '.jpg');
  return ref.put(blob);
};
