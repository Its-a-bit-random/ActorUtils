import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Actor Utils",
  description: "Making actors simple",
  base: "/ActorUtils/",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Setup', link: '/Setup/Setup' },
      { text: 'API', link: '/Api/ActorUtils' }
    ],

    sidebar: {
      "/Setup/": [
        {
          "text": "Getting Started",
          items: [
            { text: "Setup", link: "/Setup/Setup.md"}
          ]
        }
      ],
      "/Api/": [
        {
          text: "Api Reference",
          items: [
            {text: "Actor Utils", link: "/Api/ActorUtils.md"}
          ]
        }
      ]
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/Its-a-bit-random/ActorUtils' }
    ]
  }
})
