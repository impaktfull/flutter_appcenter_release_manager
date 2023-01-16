## 2.1.1 - 2023-01-16
Fixed:
- (Android) Memory leak when using `openAndroidInstallScreen: false, keepAndroidNotification: true`

## 2.1.0 - 2023-01-15
Added:
- (Android) Support to decide if the download should open the install screen automatically or the user should click on the download notification. By default the install screen will open.
- (Android) Support to keep the notification after the download was completed. By default the notification will be dismissed after downloading.
- (Android) Setting `openAndroidInstallScreen` to false will set `keepAndroidNotification` true. Otherwise the `installRelease` Future will never finish
Updated:
- Github Actions
- Analyzer

## 2.0.1 - 2023-01-07
Updated:
- Dependencies
- Fixed analyzer warnings
- Version bump dart sdk to min 2.18.0
Removed:
- Travis
Added:
- Github Actions

## 2.0.0 - 2021-03-26
Breaking:
- #18

`/v0.1/apps` -> `/v0.1/tester/apps`

`/v0.1/apps/{owner_name}/{app_name}/releases` -> `/v0.1/apps/{owner_name}/{app_name}/releases?scope=testers`

- Removed some fields from App -> appSecret, platform, origin, createdAt, uploadedAt, releaseType

Added:
- Support for testers. Collaborators, members & testers can now use the app with an api token.

## 1.0.1 - 2021-03-19
Fixed:
- crash when fetching user details with null avatarurl

## 1.0.0 - 2021-03-13
Added:
- Nullsafety
- Nullsafety example

## 0.0.5 - 2020-12-26
Added:
- No access error so we can check if the api token is valid
Fixed:
- Non exposed exceptions

## 0.0.4 - 2020-12-26
Fixed:
- json.encode would fail if DateTime was used in a toJson

## 0.0.3 - 2020-12-26
Added:
- User Details
- Extra documentation: `Api Token should have read access only`

## 0.0.2 - 2020-12-18
Added:
- pub.dev version label 

## 0.0.1 - 2020-12-18
Initial Release
