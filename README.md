# AppCenter Release Manager


[![pub package](https://img.shields.io/pub/v/appcenter_release_manager.svg)](https://pub.dartlang.org/packages/appcenter_release_manager)
[![Build Status](https://travis-ci.com/vanlooverenkoen/flutter_appcenter_release_manager.svg?branch=master)](https://travis-ci.com/vanlooverenkoen/flutter_appcenter_release_manager)
[![Coverage Status](https://coveralls.io/repos/github/vanlooverenkoen/flutter_appcenter_release_manager/badge.svg)](https://coveralls.io/github/vanlooverenkoen/flutter_appcenter_release_manager)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

Download appcenter updates straight from your iOS or Android app.


### Use the predefined UI with the AppcenterReleaseManagerLatestReleases widget
```dart
  AppcenterReleaseManagerLatestReleases(
    apiToken: 'your-api-token',
    ownerName: 'your-owner-name',
    appName: 'your-app-name',
  ),
```

### Use the manager to create your custom ui. Should be used as a repository/service
```dart
AppCenterReleaseManager(
  apiToken: 'your-api-token',
)
```

### Install by url or release details:
```dart
final details = await AppCenterReleaseManager(apiToken: '').getLatestReleaseDetails('owner_name','app_name');
AppCenterReleaseManager(apiToken: '').installRelease(details);                                                      
```

Or by url
```dart
final details = await AppCenterReleaseManager(apiToken: '').getLatestReleaseDetails('owner_name','app_name');
AppCenterReleaseManager(apiToken: '').installReleaseByUrl(details.installUrl, appName: 'your-app-name', appVersion: 'your-version'); //appName & appVersion will be used in the notification on android. On iOS this is never used                                                      
```

### Other available methods for the AppCenterReleaseManager:
```dart
AppCenterReleaseManager(apiToken: '').getAllOrganizations(); //global api token only

AppCenterReleaseManager(apiToken: '').getAllApps(); //global api token only

AppCenterReleaseManager(apiToken: '').getAllApps(ownerName: 'owner_name'); //global api token only

AppCenterReleaseManager(apiToken: '').getReleases('owner_name','app_name'); //global/app api token only

AppCenterReleaseManager(apiToken: '').getReleaseDetails('owner_name','app_name', 'id'); //global/app api token only

AppCenterReleaseManager(apiToken: '').getLatestReleaseDetails('owner_name','app_name'); //global/app api token only
```

### Android Production:

This package automaticly adds an extra permission to install apps from Android 8 & above.

```xml
    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
```

For most cases you don't want this permission in Production. To remove this. Add the following lines to the AndroidManifest.xml for the flavour/buildtype where you don't want this permission

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="your-package-name">

    <uses-permission
        android:name="android.permission.REQUEST_INSTALL_PACKAGES"
        tools:node="remove" />

</manifest>
```

In most cases you will place this in

`/android/app/src/release/AndroidManifest.xml`

But if you are using a flavour like `prod`, `alpha`, `beta` it will probably only be added here:

`/android/app/src/prod/AndroidManifest.xml`

This will make sure that the permission is only removed in `prod` so you can still install updates in `beta` & `alpha`
