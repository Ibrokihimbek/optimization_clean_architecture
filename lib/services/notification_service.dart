// ignore_for_file: unreachable_from_main, discarded_futures, unawaited_futures
import "dart:async";
import "dart:developer";
import "dart:io";

import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/foundation.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:pizza_hut_client_mobile/firebase_options.dart";
import "package:pizza_hut_client_mobile/router/app_routes.dart";

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
InitializationSettings initializationSettings = const InitializationSettings(
  android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  iOS: DarwinInitializationSettings(),
  macOS: DarwinInitializationSettings(),
);

FirebaseMessaging instance = FirebaseMessaging.instance;

sealed class NotificationService {
  const NotificationService._();

  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if (kDebugMode) {
        if (Platform.isIOS || Platform.isMacOS) {
          final String? apnsToken = await instance.getAPNSToken();
          if (apnsToken != null) {
            instance.getToken().then(
                  (String? token) => log("FCM TOKEN: $token"),
                );
          }
        } else {
          instance.getToken().then(
                (String? token) => log("FCM TOKEN: $token"),
              );
        }
      }
    } on Exception catch (e, s) {
      log("Firebase initialize error: $e $s");
    }
    await setupFlutterNotifications();
    await foregroundNotification();
    backgroundNotification();
    await terminateNotification();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> setupFlutterNotifications() async {
    if (Platform.isIOS || Platform.isAndroid) {
      final NotificationSettings settings = await instance.requestPermission();
      await instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      log("User granted permission: ${settings.authorizationStatus}");
    }
    channel = const AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notifications",
      description: "This channel is used for important notifications.",
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static void showFlutterNotification(RemoteMessage message) {
    if (message.data.containsKey("title") && message.data.containsKey("body")) {
      flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.data["title"],
        message.data["body"],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            styleInformation: BigTextStyleInformation(
              message.data["body"] ?? "",
              contentTitle: message.data["title"],
            ),
            icon: "@mipmap/ic_launcher",
            priority: Priority.high,
            importance: Importance.high,
            visibility: NotificationVisibility.public,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: "default",
          ),
        ),
        payload: message.data["route"],
      );
    }
  }

  static Future<void> foregroundNotification() async {
    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    /// when tapped
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        debugPrint("foreground notification tapped");
        debugPrint("$response");
        chuck.showInspector();
      },
    );
  }

  static void backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        debugPrint("A new onMessageOpenedApp event was published!");
        showFlutterNotification(message);
      },
    );
  }

  static Future<void> terminateNotification() async {
    final RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage == null) {
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
    } else {
      showFlutterNotification(remoteMessage);
    }
  }
}

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.setupFlutterNotifications();

  /// notification data empty enable this line
  if (message.notification?.title == null &&
      message.notification?.body == null) {
    NotificationService.showFlutterNotification(message);
  }
}
