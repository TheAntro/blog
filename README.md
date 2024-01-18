# blog

A project to create a personal blog site.

You can read the blog at [blog.antro.dev](https://blog.antro.dev).

## Development environment

The blog site uses Astro as a framework. Refer to [Astro documentation](https://docs.astro.build/en/getting-started/) for more details on Astro.

[Prettier](https://prettier.io/) is used for code formatting purposes.

Package manager for this project is [npm](https://www.npmjs.com/). [Volta](https://volta.sh/) is used to manage node and npm versions.

## Deployment with nginx

Running `npm run build` generates a static site to `/dist` directory. Site can be served with nginx by copying the contents of the `/dist` directory to the directory configured as the root for an nginx site.

For example, to serve the site as the nginx default site, run these commands:

```bash
npm run build
rm -rf /var/www/html/*
cp -a dist/. /var/www/html/
```
