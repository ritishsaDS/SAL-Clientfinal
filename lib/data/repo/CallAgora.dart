
import 'dart:convert';

CallAgora getCallAgoraFromJson(String str) => CallAgora.fromJson(json.decode(str));
class CallAgora{
  Meta meta;

  CallAgora();

  factory CallAgora.fromJson(Map<String, dynamic> parsedJson) {
    CallAgora agoraToken = CallAgora();
    agoraToken.meta = Meta.fromJson(parsedJson["meta"]);
    return agoraToken;
  }

  Map<String, dynamic> toJson() {
    return {'meta': meta.toJson()};
  }
}

class Meta {
  Meta({
    this.message,
    this.messageType,
    this.status,
  });

  String message;
  String messageType;
  String status;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    message: json["message"],
    messageType: json["message_type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "message_type": messageType,
    "status": status,
  };
}