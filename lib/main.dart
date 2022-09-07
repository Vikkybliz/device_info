import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

void main() {
  runApp(const MyDeviceInfo());
}

class MyDeviceInfo extends StatefulWidget {
  const MyDeviceInfo({Key? key}) : super(key: key);

  @override
  State<MyDeviceInfo> createState() => _MyDeviceInfoState();
}

class _MyDeviceInfoState extends State<MyDeviceInfo> {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String info = '';
  Map showAllInfo = {};

  Future anyDeviceInfo() async {
    if(Platform.isAndroid){
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      setState(() {
        info = '${androidDeviceInfo.brand!} ${androidDeviceInfo.model!}';
        showAllInfo = androidDeviceInfo.toMap();
      });
    }else if(Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      setState(() {
        info = iosDeviceInfo.model!;
        showAllInfo = iosDeviceInfo.toMap();
      });
    }else if (Platform.isWindows){
      WindowsDeviceInfo windowsDeviceInfo = await deviceInfoPlugin.windowsInfo;
      setState(() {
        info = windowsDeviceInfo.computerName;
        showAllInfo = windowsDeviceInfo.toMap();
      });
    }
  }
  @override
  void initState() {
    anyDeviceInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Device Info'),
        ),
        body: Center(child: Text(info)),
      ),
    );
  }
}
