/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./lib/**/*.dart",
    "./web/**/*.html",
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        accent: '#AB4AFF',
        dark: {
          bg: '#0A0A0C',
          card: '#121216',
          border: '#1A1A22',
          text: '#F4F4F6',
          muted: '#8A8A93',
          secondary: '#C4C4CC',
        }
      },
    },
  },
  plugins: [],
};
