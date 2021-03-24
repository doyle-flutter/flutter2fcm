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

  @override
  void initState() {
    Future(noti.init);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: TextButton(
        child: Text("Local Notifications Show!"),
        onPressed: () async => await noti.show(),
      ),
    ),
  );
}
