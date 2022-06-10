# sl_flutter_firebase_analytics
***
This package is used for collecting and sending analytical information from the app to "Firebase".
## Installation
##### 1. Add to pubspec.yaml
```yaml
sl_flutter_firebase_analytics:
       git:
         url: https://github.com/solutelabs/sl_flutter_firebase_analytics
         ref: dev
```
## How to use
***
##### 1. Enabling analytics.
```dart
Analytics().init(
    isEnabled: true, // set value to false for disable 'Analytics'
  );
```
##### 2. To track PageRoute transitions.
```dart
MaterialApp(
    navigatorObservers: Analytics().observer == null
        ? []
        : [Analytics().observer],
  );
```
###### when app is  opened.
```dart
Analytics().logAppOpened();
```
##### 4. Sending information about current screen.
```dart
Analytics().setCurrentScreen(screenName: "<CURRENT_SCREEN_NAME_HERE>");
```
##### 4. Setting routes/screens which need to be ignored for analytics.
```dart
Analytics().setIgnoredRoutes([
      'IGNORED_SCREEN_NAME_1',
      'IGNORED_SCREEN_NAME_2',
      '.....................',
      'IGNORED_SCREEN_NAME_N'
    ]);
```
##### 4. Sending information during user login.
```dart
Analytics().logLoginEvent(userId: "<USER_ID_HERE", deviceToken: "<FIREBASE_TOKEN_HERE>",);
```
##### 7. Sending information during user logout.
```dart
Analytics().logLogoutEvent();
```
##### 8. Sending information about important events to "Firebase".
```dart
Analytics().logToFirebase(
      name: "<EVENT_NAME_HERE>",
      params: <String, dynamic>{'PARAM_1': 'VALUE_1',
                                'PARAM_1': 'VALUE_1',
                                '.......': '.......',
                                'PARAM_N': 'VALUE_N'},
    );
```
