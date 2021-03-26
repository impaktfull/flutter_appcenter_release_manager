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
