import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  return;
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true
      );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MaterialApp(home: Func(),));
}

class Func extends StatefulWidget {
  @override
  _FuncState createState() => _FuncState();
}

class _FuncState extends State<Func> {

  AndroidNotificationDetails android = AndroidNotificationDetails('id', 'notiTitle', 'notiDesc',
      importance: Importance.max, priority: Priority.max);
  IOSNotificationDetails ios = IOSNotificationDetails();
  NotificationDetails? detail;

  @override
  void initState() {
    Future(() async{
      PermissionStatus status = await Permission.notification.request();
      while(status.isDenied){
        status = await Permission.notification.request();
        await openAppSettings();
      }
      AndroidInitializationSettings initSettingsAndroid = AndroidInitializationSettings('app_icon');
      IOSInitializationSettings initSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );
      InitializationSettings initSettings = InitializationSettings(
        android: initSettingsAndroid,
        iOS: initSettingsIOS,
      );
      flutterLocalNotificationsPlugin.initialize(initSettings);
      detail = NotificationDetails(android: android, iOS: ios);
      return;
    })
      .then((_) async {
        RemoteMessage? r = await FirebaseMessaging.instance.getInitialMessage();
        String? token = await FirebaseMessaging.instance.getToken();
        print("token : ${token ?? 'token NULL!'}");
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (notification != null && android != null) {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              detail
            );
          }
        });
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) => print('ON_APP :$message'));
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ElevatedButton(
        child: Text("Local Notifications Show!"),
        onPressed: () async => await flutterLocalNotificationsPlugin.show(1, "local_title", "local_body", detail),
      ),
    ),
  );
}
