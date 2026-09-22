import 'package:matule/layers/data/models/settings_model.dart';

///```
///Settings({
///   String required uuid,
///   int? required code,
///   String required token,
///   String required userid,
///   bool notification = true,
///});
///```
class Settings extends SettingsModel {
  Settings({
    required this.uuid,
    required this.code,
    required this.token,
    required this.userid,
    this.notification = true,
  });

  String uuid;
  String? code;
  String token;
  String userid;
  bool notification;

  @override
  Map<String, dynamic> toMap() => {
    'uuid': uuid,
    'code': code,
    'token': token,
    'userid': userid,
    'notification': notification,
  };

  factory Settings.fromMap(Map<String, dynamic> json) {
    return Settings(
      uuid: json['uuid'],
      code: json['code'],
      token: json['token'],
      userid: json['userid'],
      notification: json['notification'],
    );
  }
}
