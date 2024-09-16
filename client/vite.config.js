import { nodeResolve } from "@rollup/plugin-node-resolve";

export default {
  build: {
    outDir: "./dist",
  },
  plugins: [nodeResolve()],
};
// vite.config.js
// import { defineConfig } from "vite";
// import melangePlugin from "vite-plugin-melange";
//
// export default defineConfig({
//   plugins: [
//     melangePlugin({
//       buildCommand: "opam exec -- dune build",
//       watchCommand: "opam exec -- dune build --watch",
//       emitDir: ".",
//       buildTarget: "output",
//     }),
//   ],
//   resolve: {
//     alias: {
//       melange: "/_build/default/src/output/melange",
//     },
//   },
//});
