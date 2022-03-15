// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex'
  ],
  safelist: [
    {
      pattern: /(border|text)-(green|blue|indigo|purple|pink)-(6|7|8)00/
    }
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        'cool-gray': {
          '50': '#f8fafc',
          '100': '#f1f5f9',
          '200': '#e2e8f0',
          '300': '#cfd8e3',
          '400': '#97a6ba',
          '500': '#64748b',
          '600': '#475569',
          '700': '#364152',
          '800': '#27303f',
          '900': '#1a202e',
        }
      },
      gridTemplateColumns: {
        'auto-fit': 'repeat(auto-fit, minmax(3rem, 1fr))'
      }
    }
  },
  variants: {
    extend: {
      //backgroundColor: ['responsive', 'hover', 'focus', 'active']
      backgroundColor: ['active', 'disabled'],
      opacity: ['disabled'],
      cursor: ['disabled']
    }
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}
