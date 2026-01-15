import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print("🔔 Background Message: ${message.messageId}");
    print("Data: ${message.data}");
  }
}

class NotificationService extends GetxService {
  static NotificationService get to => Get.find<NotificationService>();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  String? _fcmToken;

  String? get fcmToken => _fcmToken;

  /// Initialize notifications
  Future<NotificationService> init() async {
    await _requestPermissions();
    await _initLocalNotifications();
    _initListeners();
    print('notification service initalize');
    return this;
  }

  /// Request notification permissions (Android + iOS)
  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      // Android 13+ requires runtime permission
      await _messaging.requestPermission();
    } else if (Platform.isIOS) {
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        if (kDebugMode) print("❌ iOS Notifications permission denied");
      } else {
        if (kDebugMode) print("✅ iOS Notifications permission granted");
      }
    }
  }

  /// Initialize local notifications and channels
  Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        if (kDebugMode) print("📌 Notification tapped: ${details.payload}");
      },
    );

    // const highPriorityChannel = AndroidNotificationChannel(
    //   "high_priority_channel",
    //   "High Priority Notifications",
    //   importance: Importance.high,
    //   sound: RawResourceAndroidNotificationSound("signal_alert"),
    //   playSound: true,
    // );

    // const normalChannel = AndroidNotificationChannel(
    //   "normal_channel",
    //   "Normal Notifications",
    //   importance: Importance.defaultImportance,
    //   sound: RawResourceAndroidNotificationSound("happy_bell_alert"),
    //   playSound: true,
    // );

    final androidPlugin =
        _localNotifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    // if (androidPlugin != null) {
    //   await androidPlugin.createNotificationChannel(highPriorityChannel);
    //   await androidPlugin.createNotificationChannel(normalChannel);
    // }
  }

  /// Get FCM token and listen for refresh
  Future<void> initToken() async {
    try {
      // if (defaultTargetPlatform == TargetPlatform.iOS) {
      //   await _messaging.getAPNSToken();
      // }
      _fcmToken = await _messaging.getToken();
      if (_fcmToken != null) {
        if (kDebugMode) print("♻️ FCM Token: $_fcmToken");
      }
    } catch (e) {
      if (kDebugMode) print("❌ Failed to get FCM token: $e");
    }

    _messaging.onTokenRefresh.listen((newToken) {
      // if (kDebugMode) print("♻️ FCM Token refreshed: $newToken");
      try {
        if (newToken.isNotEmpty) {
          // APIManager.registerDeviceToken(deviceToken: newToken);
        }
      } catch (e) {
        print(e);
      }
    });
  }

  /// Setup message listeners
  void _initListeners() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message);
      if (kDebugMode) print("📩 Foreground message: ${message.data}");

      // Show in-app snackbar
      // if (message.notification != null) {
      //   showMySnackbar(
      //     title: message.notification!.title ?? "",
      //     msg: message.notification!.body ?? "",
      //   );
      // }

      // Show local notification with custom sound
      _showLocalNotification(message);
      // _handleNavigation(message,isKilledState: false);
    });

    // Opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) print("👉 Opened from background: ${message.messageId}");
    });

    // App launched from terminated
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        if (kDebugMode)
          print("🚀 App launched from terminated: ${message.messageId}");
      }
    });

    // Background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Show notification with custom sound based on type
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final type = message.data['type'] ?? "normal";

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        type == "urgent" ? "high_priority_channel" : "normal_channel",
        type == "urgent" ? "High Priority" : "Normal",
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
      ),
      iOS: DarwinNotificationDetails(
        sound: type == "urgent" ? "happyBellAlert.wav" : "signalAlert.wav",
      ),
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? "OneHaven",
      message.notification?.body ?? "",
      details,
      payload: message.data['screen'],
    );
  }

  /// Handle navigation or actions based on notification
  /// /// Subscribe current user to a topic based on their Firebase UID
  Future<void> subscribeToCurrentUserTopic(String user) async {
    try {
      if (user.isNotEmpty) {
        await _messaging.subscribeToTopic(user);
        if (kDebugMode) print("✅ Subscribed to user topic: $user");
      } else {
        if (kDebugMode) print("❌ No logged-in user to subscribe");
      }
    } catch (e) {
      if (kDebugMode) print("❌ Failed to subscribe user topic: $e");
    }
  }

  /// Unsubscribe current user from their topic
  Future<void> unsubscribeFromCurrentUserTopic(String user) async {
    try {
      if (user.isNotEmpty) {
        await _messaging.unsubscribeFromTopic(user);
        if (kDebugMode) print("✅ Unsubscribed from user topic: $user");
      }
    } catch (e) {
      if (kDebugMode) print("❌ Failed to unsubscribe user topic: $e");
    }
  }
}
