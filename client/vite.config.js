import { nodeResolve } from "@rollup/plugin-node-resolve";

export default {
  build: {
    outDir: "./dist",
  },
  plugins: [nodeResolve()],
  server: {
    watch: {
      ignored: ["**/_opam/**"], // Ignore the _opam directory to reduce file watching
    },
  },
};
