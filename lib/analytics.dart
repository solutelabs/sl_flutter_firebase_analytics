import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'analytics_route_observer.dart';

/// Class that collects and send analytical information to `Firebase`
class Analytics {
  /// Initialises
  factory Analytics() => _instance;

  Analytics._internal();

  /// A public instance of the class [Analytics].
  static final Analytics _instance = Analytics._internal();

  /// Contains ignored routes/screen names.
  List<String> ignoredRoutes = <String>[];

  late FirebaseAnalytics _firebaseAnalytics;

  /// An instance of custom route observer created for analytics.
  late AnalyticsRouteObserver observer;

  /// Initialises the `Analytics`.
  /// bool [isEnabled] enables or disables "Analytics".
  Future<void> init({required bool isEnabled}) async {
    _firebaseAnalytics = FirebaseAnalytics.instance;
    observer = AnalyticsRouteObserver(onNewRoute: _newRouteHandler);

    // Enable or disable the analytics on this device.
    await _firebaseAnalytics.setAnalyticsCollectionEnabled(isEnabled);
  }

  /// Captures `screen_view` event on route changes.
  void _newRouteHandler(PageRoute<dynamic> route) {
    setCurrentScreen(
      screenName: route.settings.name ?? '',
      // ignore: avoid_as
      properties: route.settings.arguments as dynamic,
    );
  }

  /// Captures `app_open` event when the app is opened.
  void logAppOpened() {
    _firebaseAnalytics.logAppOpen();
  }

  /// Captures information about current screen in use.
  void setCurrentScreen({
    required String screenName,
    Map<String, dynamic> properties = const <String, dynamic>{},
  }) {
    if (ignoredRoutes.contains(screenName)) {
      return;
    }
    _firebaseAnalytics.setCurrentScreen(screenName: screenName);
  }

  /// Captures `login` event upon a successful user log in.
  Future<void> logLoginEvent(
      {required String deviceToken, required int userId}) async {
    await _setFirebaseUserId(userId.toString());
    await _firebaseAnalytics.logLogin();
  }

  /// Captures `logout` event when the user logs out.
  void logLogoutEvent() {
    _firebaseAnalytics.logEvent(name: 'logout');
  }

  /// Sets the user id to `Firebase`.
  Future<void> _setFirebaseUserId(String userId) =>
      _firebaseAnalytics.setUserId();

  /// Logs custom events to `Firebase`.
  Future<void> logToFirebase({
    required String name,
    Map<String, dynamic>? params,
  }) =>
      _firebaseAnalytics.logEvent(
        name: name,
        parameters: params,
      );
}
