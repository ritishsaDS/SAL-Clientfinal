class CreateTherapistProfileModal {
  String accessToken;
  String clientId;
  String mediaUrl;
  Meta meta;
  String refreshToken;

  CreateTherapistProfileModal(
      {this.accessToken,
        this.clientId,
        this.mediaUrl,
        this.meta,
        this.refreshToken});

  CreateTherapistProfileModal.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    clientId = json['client_id'];
    mediaUrl = json['media_url'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['client_id'] = this.clientId;
    data['media_url'] = this.mediaUrl;
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}

class Meta {
  String message;
  String messageType;
  String status;

  Meta({this.message, this.messageType, this.status});

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageType = json['message_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['message_type'] = this.messageType;
    data['status'] = this.status;
    return data;
  }
}
