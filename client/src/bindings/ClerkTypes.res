module Url = {
  type t // Define the type

  @new
  external make: string => t = "URL" // Binding for URL constructor

  @val
  external href: t => string = "href" // Binding for href property
}

type layout = {
  animations: bool,
  helpPageUrl: string,
  logoImageUrl: string,
  logoLinkUrl: string,
  // TODO: should be one of: 'inside' | 'outside'
  logoPlacement: string,
  privacyPageUrl: string,
  shimmer: bool,
  showOptionalFields: bool,
  // TODO: should be one of: 'blockButton' | 'iconButton' | 'auto'
  socialButtonsVariant: string,
  termsPageUrl: string,
}

type fontWeight = {
  normal: int,
  medium: int,
  semibold: int,
  bold: int,
}

type variables = {
  colorPrimary: string,
  colorDanger: string,
  colorSuccess: string,
  colorWarning: string,
  colorNeutral: string,
  colorText: string,
  colorTextOnPrimaryBackground: string,
  colorTextSecondary: string,
  colorBackground: string,
  colorInputText: string,
  colorInputBackground: string,
  colorShimmer: string,
  fontFamily: string,
  fontFamilyButtons: string,
  fontSize: string,
  fontWeight: fontWeight,
  borderRadius: string,
  spacingUnit: string,
}

type appearance = {
  layout: option<layout>,
  variables: option<variables>,
}

type isSatellite =
  | Bool
  | UrlFunc(Url.t => bool)

type domain =
  | String
  | UrlFunc(Url.t => bool)

type telemetryRecord = {
  disabled: option<bool>,
  debug: option<bool>,
}

type telemetry =
  | False
  | Record(telemetryRecord)

module User = {
  type t = {
    firstName: option<string>,
    lastName: option<string>,
    fullName: option<string>,
    username: string,
    hasImage: bool,
    imageUrl: string,
  }
}
