/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./_build/default/src/output/src/**/*.{js, jsx, ts, tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
