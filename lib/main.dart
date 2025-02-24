import 'dart:async';
import 'dart:io';

import 'package:deeplink_dev/sdk_callback.dart';
import 'package:flutter/material.dart';
import 'package:deeplink_dev/attribution_sdk_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    startSdk();
  }

  Future<void> startSdk() async {
    if (Platform.isAndroid) {
      AttributionSdkCore.instance
          .setSdkCallback(SdkCallback(onSdkInitCompleted: (int code) {
        if (code == 0) {
          //Initialization successful
        } else {
          //Initialization failed, for specific failure reasons refer to the code interpretation
        }
      }, onAttributionSuccess: (Map<String, dynamic> attribution) {
        //Obtain attribution results successfully
      }, onAttributionFailed: (int code) {
        //Failed to obtain attribution results
      }));

      //[Optional] This property is used to identify the source of the installation package to better understand how users obtain the app.
      //You can set the property value before initializing the SDK. If not passed in or null is passed in, the default is empty
      AttributionSdkCore.instance.setPackageSource("YOUR_PACKAGE_SOURCE");

      //[Optional] Defaults to false. You can set the property value before initializing the SDK.
      //When true is passed, it means that the developer wants to customize the device ID.
      //Attribution and events will be reported only when the developer passes in a custom device ID.
      //When false is passed, the SDK will generate the device ID internally.
      AttributionSdkCore.instance.setWaitForDeviceId(true);

      //[Optional] By default, the SDK will automatically generate a device ID.
      //The custom device ID passed by the developer will take effect only when AttrSdk.setWaitForDeviceId is passed true.
      AttributionSdkCore.instance.setDeviceId("A-B-C-D");

      //[Optional] Defaults to false. You can set the property value before initializing the SDK.
      // When true is passed, it means that the developer wants to customize the account ID to associate the account with the attribution information.
      // Attribution will be reported only if and when the developer passes in a customized account ID.
      // When false is passed, the SDK will not generate a account ID internally.
      AttributionSdkCore.instance.setWaitForAccountId(true);

      //[Optional] Defaults to empty. Used to associate the account system in the developer's business logic with the attribution information.
      AttributionSdkCore.instance.setAccountId("1234");

      //[Optional] By default, the SDK will automatically obtain Gaid, and developers do not need to set it manually
      //You can set the property value before initializing the SDK.
      AttributionSdkCore.instance.setGaid("ABCD-EFGH-IJKL-MNOP");

      AttributionSdkCore.instance.setOnAttributionListener();
      AttributionSdkCore.instance.initSdk("YOUR_APP_ID","[Optional]META_APP_ID","[Optional]APPS_FLYER_DEV_KEY");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AttributionFlutterPlugin'),
        ),
        body: const Center(),
      ),
    );
  }
}