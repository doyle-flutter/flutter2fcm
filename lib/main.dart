import 'package:flutter/material.dart';
import 'package:func/noti/importNoti.dart' as appNoti;
import 'package:func/noti/notis/ab/abNoti.dart';

void main() => runApp(MaterialApp(home: Func(), ));

class Func extends StatefulWidget {
  @override
  _FuncState createState() => _FuncState();
}

class _FuncState extends State<Func> {

  Noti noti = appNoti.AppNoti();

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // AndroidNotificationDetails android = AndroidNotificationDetails('id', 'notiTitle', 'notiDesc', importance: Importance.max, priority: Priority.max);
  // IOSNotificationDetails ios = IOSNotificationDetails();
  // NotificationDetails? detail;
  //
  // static Future<void> backInit(RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //   print('Handling a background message ${message.messageId}');
  //   return;
  // }

  @override
  void initState() {

    Future(noti.init);

    // Future(() async{
    //   PermissionStatus status = await Permission.notification.request();
    //   while(status.isDenied){
    //     status = await Permission.notification.request();
    //     await openAppSettings();
    //   }
    //   AndroidInitializationSettings initSettingsAndroid = AndroidInitializationSettings('app_icon');
    //   IOSInitializationSettings initSettingsIOS = IOSInitializationSettings(
    //     requestSoundPermission: true,
    //     requestBadgePermission: true,
    //     requestAlertPermission: true,
    //   );
    //   InitializationSettings initSettings = InitializationSettings(
    //     android: initSettingsAndroid,
    //     iOS: initSettingsIOS,
    //   );
    //   flutterLocalNotificationsPlugin.initialize(initSettings);
    //   detail = NotificationDetails(android: android, iOS: ios);
    //   await flutterLocalNotificationsPlugin
    //       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    //       ?.createNotificationChannel(AndroidNotificationChannel(
    //     'high_importance_channel', // id
    //     'High Importance Notifications', // title
    //     'This channel is used for important notifications.', // description
    //     importance: Importance.high,
    //   ));
    //   await flutterLocalNotificationsPlugin
    //       .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
    //       ?.requestPermissions(
    //       alert: true,
    //       badge: true,
    //       sound: true
    //   );
    //   return;
    // })
    //   .then((_) async {
    //     await Firebase.initializeApp();
    //     FirebaseMessaging?.onBackgroundMessage(_FuncState.backInit);
    //     RemoteMessage? r = await FirebaseMessaging.instance.getInitialMessage();
    //     print("INIT r : ${r ?? 'r'}");
    //     String? token = await FirebaseMessaging.instance.getToken();
    //     print("token : ${token ?? 'token NULL!'}");
    //     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //       alert: true,
    //       badge: true,
    //       sound: true,
    //     );
    //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //       RemoteNotification? notification = message.notification;
    //       AndroidNotification? android = message.notification?.android;
    //       if (notification != null && android != null) {
    //         flutterLocalNotificationsPlugin.show(
    //           notification.hashCode,
    //           notification.title,
    //           notification.body,
    //           detail
    //         );
    //       }
    //     });
    //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) => print('ON_APP :$message'));
    //   });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ElevatedButton(
        child: Text("Local Notifications Show!"),
        onPressed: () async => await noti.show(),
      ),
    ),
  );
}
