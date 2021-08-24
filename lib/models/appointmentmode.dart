import 'dart:convert';

AppointmentModel getCounsellorFromJson(String str) => AppointmentModel.fromJson(json.decode(str));

String getCounsellorToJson(AppointmentModel data) => json.encode(data.toJson());

class AppointmentModel {
  AppointmentModel({
    this.clientId,
    this.counsellorId,
    this.couponCode,
    this.date,
    this.noSession,
    this.time,
  });

  String clientId;
  String counsellorId;
  String couponCode;
  String date;
  String noSession;
  String time;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => AppointmentModel(
    clientId: json["client_id"],
    counsellorId: json["counsellor_id"],
    couponCode: json["coupon_code"],
    date: json["date"],
    noSession: json["no_session"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "counsellor_id": counsellorId,
    "coupon_code": couponCode,
    "date": date,
    "no_session": noSession,
    "time": time,
  };
}
