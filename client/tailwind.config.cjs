/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.res.mjs"],
  theme: {
    extend: {
      colors: {
        gray: {
          50: "#f6f6f5",
          100: "#e7e7e6",
          200: "#d1d1d0",
          300: "#b1b0af",
          400: "#8a8a86",
          500: "#6f6f6b",
          600: "#5e5d5c",
          700: "#504f4e",
          800: "#464644",
          900: "#343433",
          900: "#262626",
        },
      },
      animation: {
        spin: "spin 1.5s linear infinite",
      },
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
