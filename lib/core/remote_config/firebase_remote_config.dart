// import 'dart:convert';

// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:DEMO_mobile_v2/core/di/app-context.dart';
// import 'package:DEMO_mobile_v2/data/models/remote_config_model.dart';

// class FirebaseRemoteConfigure {
//   static initConfig() async {
//     final remoteConfig = FirebaseRemoteConfig.instance;
//     await remoteConfig.fetchAndActivate();
//   }

//   static Future<Map<String, String>> getAllRemoteConfigValues() async {
//     final remoteConfig = FirebaseRemoteConfig.instance;
//     await remoteConfig.activate();
//     await remoteConfig.fetchAndActivate();

//     var data = remoteConfig.getAll();
//     Map<String, String> result = {};
//     data.forEach((key, value) {
//       result.addAll({key: value.asString()});
//     });
//     print(result);
//     AppContext.setRemoteConfigValue(RemoteConfigModel.fromMap(result));
//     return result;
//   }
// }
