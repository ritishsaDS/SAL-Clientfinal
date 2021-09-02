import 'dart:convert';

AppointmentTherapist getCounsellorFromJson(String str) => AppointmentTherapist.fromJson(json.decode(str));

String getCounsellorToJson(AppointmentTherapist data) => json.encode(data.toJson());

class AppointmentTherapist {
  AppointmentTherapist({
    this.clientId,
    this.therapistId,
    this.couponCode,
    this.date,
    this.noSession,
    this.time,
  });

  String clientId;
  String therapistId;
  String couponCode;
  String date;
  String noSession;
  String time;

  factory AppointmentTherapist.fromJson(Map<String, dynamic> json) => AppointmentTherapist(
    clientId: json["client_id"],
    therapistId: json["therapist_id"],
    couponCode: json["coupon_code"],
    date: json["date"],
    noSession: json["no_session"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "therapist_id": therapistId,
    "coupon_code": couponCode,
    "date": date,
    "no_session": noSession,
    "time": time,
  };
}
