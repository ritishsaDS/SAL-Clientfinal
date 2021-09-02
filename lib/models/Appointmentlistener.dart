import 'dart:convert';

Appointmentlistener getCounsellorFromJson(String str) => Appointmentlistener.fromJson(json.decode(str));

String getCounsellorToJson(Appointmentlistener data) => json.encode(data.toJson());

class Appointmentlistener {
  Appointmentlistener({
    this.clientId,
    this.listenerid,
    this.couponCode,
    this.date,
    this.noSession,
    this.time,
  });

  String clientId;
  String listenerid;
  String couponCode;
  String date;
  String noSession;
  String time;

  factory Appointmentlistener.fromJson(Map<String, dynamic> json) => Appointmentlistener(
    clientId: json["client_id"],
    listenerid: json["listener_id"],
    couponCode: json["coupon_code"],
    date: json["date"],
    noSession: json["no_session"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "listener_id": listenerid,
    "coupon_code": couponCode,
    "date": date,
    "no_session": noSession,
    "time": time,
  };
}
