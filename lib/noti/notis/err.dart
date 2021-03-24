import 'package:func/noti/notis/ab/abNoti.dart';

class AppNoti implements Noti{
  @override
  Future<bool> init() async => false;

  @override
  Future<void> show() async{
    print("ERROR");
    return;
  }
}