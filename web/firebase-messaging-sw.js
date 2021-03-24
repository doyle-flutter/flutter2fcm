importScripts('https://www.gstatic.com/firebasejs/8.2.10/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.2.10/firebase-messaging.js');

firebase.initializeApp({
     apiKey: "AIzaSyBjxfS52q1DrxoDGqp7JM_5cDzv9L6xUaQ",
     authDomain: "allm-bda05.firebaseapp.com",
     databaseURL: "https://allm-bda05.firebaseio.com",
     projectId: "allm-bda05",
     storageBucket: "allm-bda05.appspot.com",
     messagingSenderId: "957776137461",
     appId: "1:957776137461:web:494fe2c807259d071c89bc",
     measurementId: "G-J91QRJK6V8"
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});