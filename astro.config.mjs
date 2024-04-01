import { defineConfig } from "astro/config";
import storyblok from "@storyblok/astro";
import { loadEnv } from "vite";
import basicSsl from "@vitejs/plugin-basic-ssl";

const env = loadEnv("", process.cwd(), "STORYBLOK");

export default defineConfig({
  integrations: [
    storyblok({
      accessToken: env.STORYBLOK_TOKEN,
      apiOptions: {
        region: "eu",
      },
      components: {
        page: "storyblok/Page",
        teaser: "storyblok/Teaser",
        article: "storyblok/Article",
        'all-articles': "storyblok/AllArticles",
      },
    }),
  ],
  vite: {
    plugins: [basicSsl()],
    server: {
      https: true,
    },
  },
});
