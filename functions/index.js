
// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

const functions = require("firebase-functions");
const admin = require("firebase-admin");

// initialize firebase admin
admin.initializeApp();

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started
//

// send notification to the recive user
exports.sendNotification = functions.firestore
    .document("messages/{docId}")
    .onCreate((snap, context) => {
      // when creating a new document in messages collection
      // the data of that created document can be accessed via this snap
      const newValue = snap.data();

      console.log(newValue);

      // reciver device token
      const token = newValue.reciverToken;

      // declairing the notification payload
      const payload = {
        notification: {
          title: newValue.senderName,
          body: newValue.message,
        },
        data: {
          conId: newValue.conId,
        },
      };

      // send the notification
      admin.messaging().sendToDevice(token, payload).then((response) => {
        // logging the response
        console.log(response);
      }).catch((error) =>{
        console.log(error);
      });
    });

