import type { AppLogo, StoreLinks } from "./types";

export const appInfo = {
  title: "Gezgin Rota Rehberim",
  description:
    "Gezgin Rota Rehberim, seyahat planlamanızı kolaylaştıran, en iyi rotaları sunan ve offline harita desteği sağlayan bir uygulamadır.",
  logo: {
    type: "image" as AppLogo["type"],
    src: "app-icon.png", // public klasörüne kendi ikonunu koy
  },
  storeLinks: {
    apple: "https://apps.apple.com/tr/app/gezgin-rota-rehberim/idXXXXXX",  // App Store linkini buraya ekle
    google: "https://play.google.com/store/apps/details?id=com.devriim.gezginrota", // Play Store linkini buraya ekle
  } as StoreLinks,
};
