import i18n from "i18next";
import detector from "i18next-browser-languagedetector";
import { reactI18nextModule } from "react-i18next";

import translationEN from './locales/en/translation.json';
import translationJA from './locales/ja/translation.json';
import translationCN from './locales/cn/translation.json';
import translationTW from './locales/tw/translation.json';

// the translations
const resources = {
  en: {
    translation: translationEN
  },
  tw: {
    translation: translationTW
  },
  ja: {
    translation: translationJA
  },
  cn: {
    translation: translationCN
  }
};

const setLocalStorage = (key, value) => {
    localStorage.setItem(key, value);
};

const getLocalStorage = (key) => {
    return localStorage.getItem(key);
};

const changI18nLanguage = (i18nKey) => {
    i18n.changeLanguage(i18nKey).then(r => r);
};

i18n
  .use(detector)
  .use(reactI18nextModule) // passes i18n down to react-i18next
  .init({
    resources,
    lng: localStorage.getItem("lang") || "ja",//default
    fallbackLng: "en",

    keySeparator: false, // we do not use keys in form messages.welcome

    interpolation: {
      escapeValue: false // react already safes from xss
    }
  });
const i18nKeys = Object.keys(resources).reduce((obj,key)=>{
    obj[key]=key;
    return obj;
}, {});

export { i18nKeys, setLocalStorage, getLocalStorage, changI18nLanguage };
export default i18n;
