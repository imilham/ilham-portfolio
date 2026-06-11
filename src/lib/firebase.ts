import { initializeApp, getApps, getApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import { getStorage } from "firebase/storage";
import { getAuth } from "firebase/auth";
import { getAnalytics, isSupported } from "firebase/analytics";

const firebaseConfig = {
  apiKey: "AIzaSyC4JMX3TvMpBdZ1I3-tIV9ETbDIQ4PHaKY",
  authDomain: "imilham-portfolio.firebaseapp.com",
  projectId: "imilham-portfolio",
  storageBucket: "imilham-portfolio.firebasestorage.app",
  messagingSenderId: "552536037639",
  appId: "1:552536037639:web:12fa0d0760831d0c83cda2",
  measurementId: "G-F6HZSPB576"
};

// Initialize Firebase only once
const app = getApps().length > 0 ? getApp() : initializeApp(firebaseConfig);

const db = getFirestore(app);
const storage = getStorage(app);
const auth = getAuth(app);

// Initialize Analytics safely on client side
let analytics;
if (typeof window !== "undefined") {
  isSupported().then(supported => {
    if (supported) {
      analytics = getAnalytics(app);
    }
  });
}

export { app, db, storage, auth, analytics };
