# 4.0.1

# Fix

- Example documentation related to credentials

# 4.0.0

## Breaking:

- Refactor to impaktfull
- Updated dependencies
- Updated min versions
- Updated kotlin version
- License

# 3.0.1

Don't fail if release notes are `null` (we fall back to an empty string)

# 3.0.0
Min flutter version 3.3.0

Updated:
- Dependencies
- Kotlin version to 1.6.0

# 2.2.0
Added:
- (Android) Support for aab files

# 2.1.1
Fixed:
- (Android) Memory leak when using `openAndroidInstallScreen: false, keepAndroidNotification: true`

# 2.1.0
Added:
- (Android) Support to decide if the download should open the install screen automatically or the user should click on the download notification. By default the install screen will open.
- (Android) Support to keep the notification after the download was completed. By default the notification will be dismissed after downloading.
- (Android) Setting `openAndroidInstallScreen` to false will set `keepAndroidNotification` true. Otherwise the `installRelease` Future will never finish
Updated:
- Github Actions
- Analyzer

# 2.0.1
Updated:
- Dependencies
- Fixed analyzer warnings
- Version bump dart sdk to min 2.18.0
Removed:
- Travis
Added:
- Github Actions

# 2.0.0
Breaking:
- #18

`/v0.1/apps` -> `/v0.1/tester/apps`

`/v0.1/apps/{owner_name}/{app_name}/releases` -> `/v0.1/apps/{owner_name}/{app_name}/releases?scope=testers`

- Removed some fields from App -> appSecret, platform, origin, createdAt, uploadedAt, releaseType

Added:
- Support for testers. Collaborators, members & testers can now use the app with an api token.

# 1.0.1
Fixed:
- crash when fetching user details with null avatarurl

# 1.0.0
Added:
- Nullsafety
- Nullsafety example

# 0.0.5
Added:
- No access error so we can check if the api token is valid
Fixed:
- Non exposed exceptions

# 0.0.4
Fixed:
- json.encode would fail if DateTime was used in a toJson

# 0.0.3
Added:
- User Details
- Extra documentation: `Api Token should have read access only`

# 0.0.2
Added:
- pub.dev version label 

# 0.0.1
Initial Release
