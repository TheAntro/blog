import { defineConfig } from "astro/config";
import { storyblok } from "@storyblok/astro";
import basicSsl from "@vitejs/plugin-basic-ssl";
import { loadEnv } from "vite";

export default defineConfig({
  integrations: [
    storyblok({
      accessToken: (loadEnv(process.env.NODE_ENV || "development", process.cwd(), "STORYBLOK").STORYBLOK_TOKEN) || process.env.STORYBLOK_TOKEN,
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
