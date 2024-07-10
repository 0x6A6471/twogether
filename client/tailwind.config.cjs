/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.res.mjs"],
  theme: {
    extend: {},
  },
  plugins: [require("@tailwindcss/forms")],
};
