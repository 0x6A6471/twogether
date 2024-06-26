// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Button from "./Button.res.mjs";
import * as Caml_option from "rescript/lib/es6/caml_option.js";
import * as JsxRuntime from "react/jsx-runtime";

function App(props) {
  var match = React.useState(function () {
        return 0;
      });
  var setCount = match[1];
  return JsxRuntime.jsxs("div", {
              children: [
                JsxRuntime.jsx("h1", {
                      children: "What is this about?",
                      className: "text-3xl font-semibold"
                    }),
                JsxRuntime.jsx("p", {
                      children: "This is a simple template for a Vite project using ReScript & Tailwind CSS."
                    }),
                JsxRuntime.jsx("h2", {
                      children: "Fast Refresh ",
                      className: "text-2xl font-semibold mt-5"
                    }),
                JsxRuntime.jsx(Button.make, {
                      children: Caml_option.some("count is " + match[0].toString()),
                      onClick: (function (param) {
                          setCount(function (count) {
                                return count + 1 | 0;
                              });
                        })
                    }),
                JsxRuntime.jsxs("p", {
                      children: [
                        "Edit ",
                        JsxRuntime.jsx("code", {
                              children: "src/App.res"
                            }),
                        " and save to test Fast Refresh."
                      ]
                    })
              ],
              className: "p-6"
            });
}

var make = App;

export {
  make ,
}
/* react Not a pure module */
