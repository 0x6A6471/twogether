module ClerkProvider = {
  @module("@clerk/clerk-react") @react.component
  external make: (
    ~publishableKey: string,
    ~routerPush: string => unit=?,
    ~routerReplace: string => unit=?,
    ~clerkJSUrl: string=?,
    ~clerkJSVariant: string=?,
    ~clerkJSVersion: string=?,
    ~supportEmail: string=?,
    ~appearance: ClerkTypes.appearance=?,
    // NOTE: localization is experimental
    // localization Localization | undefined
    ~allowRedirectOrigins: array<string>=?,
    ~signInForceRedirectUrl: string=?,
    ~signUpForceRedirectUrl: string=?,
    ~signInFallbackRedirectUrl: string=?,
    ~signUpFallbackRedirectUrl: string=?,
    ~isSatellite: ClerkTypes.isSatellite=?,
    ~domain: string=?,
    ~signInUrl: string=?,
    ~signUpUrl: string=?,
    ~telemetry: ClerkTypes.telemetry=?,
    ~children: React.element,
  ) => React.element = "ClerkProvider"
}

module SignedOut = {
  @module("@clerk/clerk-react") @react.component
  external make: (~children: React.element) => React.element = "SignedOut"
}

module SignedIn = {
  @module("@clerk/clerk-react") @react.component
  external make: (~children: React.element) => React.element = "SignedIn"
}

module SignInButton = {
  type mode = [
    | #redirect
    | #modal
  ]

  @module("@clerk/clerk-react") @react.component
  external make: (
    ~forceRedirectUrl: string=?,
    ~fallbackRedirectUrl: string=?,
    ~signUpForceRedicretUrl: string=?,
    ~signUpFallbackRedirectUrl: string=?,
    ~mode: mode=?,
    ~children: React.element,
  ) => React.element = "SignInButton"
}

module SignOutButton = {
  type signOutOptions = {"sessionId": string, "redirectUrl": string}
  @module("@clerk/clerk-react") @react.component
  external make: (
    ~redirectUrl: string=?,
    ~signOutOptions: signOutOptions=?,
    ~fallbackRedirectUrl: string=?,
    ~children: React.element,
  ) => React.element = "SignOutButton"
}

@module("@clerk/clerk-react")
external useUser: unit => {
  "isSignedIn": bool,
  "isLoaded": bool,
  "user": Js.Nullable.t<ClerkTypes.user>,
} = "useUser"
