export const getCurrentUserProfile = (profile) => async (dispatch) => {
  const req = db.collection("users").doc("userId");

  req.get().then((querySnapshot) => {
    querySnapshot.forEach((doc) => {
      console.log(`${doc.id} => ${doc.data()}`);
    });
  });
};
