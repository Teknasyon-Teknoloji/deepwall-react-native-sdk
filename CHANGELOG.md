# Changelog
All notable changes to this project will be documented in this file.

## [Unreleased](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.9.2...main)
### Fixed
- On android added hasActivity check
- Added new event for android if deepwall init failure happens


---


## [2.9.2 (2021-12-09)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.9.1..2.9.2)
### Changed
- On iOS, `deepwall-core` version upgraded to version `2.4.1`.
- On Android, `deepwall-core` version upgraded to version `2.4.1`.
- Readme updated.

## [2.9.1 (2021-11-25)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.9.0...2.9.1)
### Fixed
- On iOS "UserProperties" object fields mandatory error.

### Added
- Added missing examples to [readme](README.md) file.

### Changed
- Readme updated.

## [2.9.0 (2021-11-22)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.8.0...2.9.0)
### Changed
- Readme updated.
- On iOS, `deepwall-core` version upgraded to version `2.4.0`.
- On Android, `deepwall-core` version upgraded to version `2.4.0`.
- Example file updated.

## [2.8.0 (2021-06-09)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.7.1...2.8.0)
### Added
- Added missing examples to [readme](README.md) file.

### Changed
- package-lock.json file deleted.
- On iOS, `deepwall-core` version upgraded to version `2.3.0`.
- On iOS, you can remove `use_frameworks!` from podfile.
- On Android, `deepwall-core` version upgraded to version `2.3.0`.
- On Android, `compileSdkVersion` and `targetSdkVersion` set to 30.
- On Android, kotlin version updated to `1.4.32`.
- Example file updated.
- Readme updated.
- On Android Make sure your gradle version is `3.6.4` or higher (see readme file "Troubleshooting" section for more information).

## [2.7.1 (2021-04-09)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.7.0...2.7.1)
### Fixed
- On iOS "ATT_STATUS_CHANGED" event not firing error fixed.

## [2.7.0 (2021-04-08)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.6.0...2.7.0)
### Fixed
- Changelog refactored.

### Changed
- On iOS `deepwall-core` version upgraded to version `~> 2.2`.

### Added
- On iOS added new "requestAppTracking" method.
- On iOS added new "sendExtraDataToPaywall" method for sending extra data to paywalls.
- Added new event for ios "DeepWallEvents.ATT_STATUS_CHANGED".

## [2.6.0 (2021-04-01)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.5.2...2.6.0)
### Fixed
- On iOS "debugAdvertiseAttributions" parameter updated

## [2.5.2 (2021-03-12)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.5.1...2.5.2)
### Changed
- On Android `deepwall-core` version upgraded to version `2.2.2`

## [2.5.1 (2021-02-16)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.5.0...2.5.1)
### Changed
- On Android `deepwall-core` version upgraded to version `2.2.1`

## [2.5.0 (2021-02-16)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.4.0...2.5.0)
### Added
- Added homepage info into `package.json`
- Added `AppsFlyer` support.
- On Android added new methods
  - consumeProduct
  - setProductUpgradePolicy
  - updateProductUpgradePolicy
- On Android added new events
  - deepWallPaywallConsumeSuccess
  - deepWallPaywallConsumeFailure
- General code refactor
- Added new events
  - PAYWALL_CONSUME_SUCCESS
  - PAYWALL_CONSUME_FAIL
- Exported new enums
  - ProrationTypes
  - UpgradePolicies
- Added new methods
  - consumeProduct
  - setProductUpgradePolicy
  - updateProductUpgradePolicy

### Changed
- On iOS `deepwall-core` version upgraded to version `2.1.0`
- On Android `deepwall-core` version upgraded to version `2.2.0`

## [2.4.0 (2021-02-16)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.3.0...2.4.0)
### Added
- Exported DeepWallEnvironmentStyles.
- Added passing extra data example into readme

### Fixed
- Readme file EventBus example typo fixed.
- Fixed event firing multiple times on hot reload issue [#17](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/pull/17)

## [2.3.0 (2020-12-23)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.2.0...2.3.0)
### Changed
- On iOS added nullability checks for event models.
- Android deepwall-core module updated to 2.1.6.

## [2.2.0 (2020-11-19)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.1.0...2.2.0)
### Changed
- Android deepwall-core module updated to 2.1.5.

### Fixed
- Android wrong event data model fixed.

## [2.1.0 (2020-11-11)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.0.1...2.1.0)
### Added
- Exported `DeepWallValidateReceiptTypes` enum.
- Rewrite ios side from scratch using objective-c.

### Changed
- iOS swift file requirement for project is no longer needed.
- Android deepwall-core module updated to 2.1.1.

### Removed
- Unnecessary gradle files removed.

### Fixed
- Fixed android event data models json cast.

## [2.0.1 (2020-10-28)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/2.0.0...2.0.1)
### Fixed
- Fix typo for android `closePaywall` method name. `closePayWall -> closePaywall`
- Fix usage static frameworks on ios podspec file.

## [2.0.0 (2020-10-27)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/1.1.0...2.0.0)
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

## [1.1.0 (2020-10-26)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/1.0.3...1.1.0)
### Changed
- Minimum react native version updated to `0.56.0`.

### Added
- Android debug/release manifest files.

### Fixed
- Fix android metro bundle not working error.

### Removed
- Unnecessary dev dependencies removed.
- Unused root gradle files removed.

## [1.0.3 (2020-10-21)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/1.0.2...1.0.3)
### Added
- Changelog file.
- EventBus "removeListener" method.

### Changed
- Readme android installation section updated.

### Deprecated
- EventBus "dispatch" and "listen" methods deprecated.Use "fireEvent" and "addListener" instead.

## [1.0.2 (2020-09-30)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/1.0.1...1.0.2)
### Fixed
- Fix ios wrapper event bridge error

### Changed
- Readme installation url updated.

## [1.0.1 (2020-09-29)](https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk/compare/1.0.0...1.0.1)
### Fixed
- Fix ios react native bridge handling

## 1.0.0 (2020-09-23)
### Added
- Initial release of the project.
