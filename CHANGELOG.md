# Changelog
All notable changes to this project will be documented in this file.

The format based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]


---


## [2.2.0] - 2020-11-19
## Changed
- Android deepwall-core module updated to 2.1.5.

## Fixed
- Android wrong event data model fixed.

## [2.1.0] - 2020-11-11
### Added
- Exported `DeepWallValidateReceiptTypes` enum.
- Rewrite ios side from scratch using objective-c.

### Changed
- iOS swift file requirement for project is no longer needed.
- Android deepwall-core module updated to 2.1.1.

## Removed
- Unnecessary gradle files removed.

## Fixed
- Fixed android event data models json cast.

## [2.0.1] - 2020-10-28
### Fixed
- Fix typo for android `closePaywall` method name. `closePayWall -> closePaywall`
- Fix usage static frameworks on ios podspec file.

## [2.0.0] - 2020-10-27
### Added
- Ios sdk v2 implemented.
- Android sdk v2 implemented.
- Added [example file](example/App.js).
- Added Android `validateReceipt` method.
- Added new events.
  - `PAYWALL_REQUESTED`
  - `PAYWALL_RESPONSE_RECEIVED` 
  - `PAYWALL_NOT_OPENED`

### Changed
- Method names updated
  - `requestLanding -> requestPaywall`
  - `closeLanding -> closePaywall`
  - `hideLandingLoadingIndicator -> hidePaywallLoadingIndicator`
- Event names updated
  - `LANDING_OPENED -> PAYWALL_OPENED`
  - `LANDING_CLOSED -> PAYWALL_CLOSED`
  - `LANDING_RESPONSE_FAILURE -> PAYWALL_RESPONSE_FAILURE`
  - `LANDING_ACTION_SHOW_DISABLED -> PAYWALL_ACTION_SHOW_DISABLED`
  - `LANDING_PURCHASING_PRODUCT -> PAYWALL_PURCHASING_PRODUCT`
  - `LANDING_PURCHASE_SUCCESS -> PAYWALL_PURCHASE_SUCCESS`
  - `LANDING_PURCHASE_FAILED -> PAYWALL_PURCHASE_FAILED`
  - `LANDING_RESTORE_SUCCESS -> PAYWALL_RESTORE_SUCCESS`
  - `LANDING_RESTORE_FAILED -> PAYWALL_RESTORE_FAILED`
  - `LANDING_EXTRA_DATA_RECEIVED -> PAYWALL_EXTRA_DATA_RECEIVED`
 
## [1.1.0] - 2020-10-26 
### Changed
- Minimum react native version updated to `0.56.0`.

### Added
- Android debug/release manifest files.

### Fixed
- Fix android metro bundle not working error.

## Removed
- Unnecessary dev dependencies removed.
- Unused root gradle files removed.

## [1.0.3] - 2020-10-21
### Added
- Changelog file.
- EventBus "removeListener" method.

### Changed
- Readme android installation section updated.

### Deprecated
- EventBus "dispatch" and "listen" methods deprecated.Use "fireEvent" and "addListener" instead.

## [1.0.2] - 2020-09-30
### Fixed
- Fix ios wrapper event bridge error

### Changed
- Readme installation url updated.

## [1.0.1] - 2020-09-29
### Fixed
- Fix ios react native bridge handling

## [1.0.0] - 2020-09-23
### Added
- Initial release of the project.
