import { defineConfig } from "astro/config";
import tailwind from "@astrojs/tailwind";
import react from "@astrojs/react";

export default defineConfig({
  site: 'https://DevrimVarli.github.io', // kendi kullanıcı adın
  base: '/GezginRotaRehberiAstro/',           // repo adınla birebir aynı
  integrations: [tailwind(), react()],
});
