importScripts("https://www.gstatic.com/firebasejs/9.22.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.22.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyA2IT8A025MsqOH9cGfDygo8vX2Hy1igSk',
  appId: '1:838972151248:web:e08eee73d06c5b625155d5',
  messagingSenderId: '838972151248',
  projectId: 'campuspulse-949fe',
  authDomain: 'campuspulse-949fe.firebaseapp.com',
  storageBucket: 'campuspulse-949fe.firebasestorage.app',
  measurementId: 'G-PYYVXV55B3',
});

const messaging = firebase.messaging();