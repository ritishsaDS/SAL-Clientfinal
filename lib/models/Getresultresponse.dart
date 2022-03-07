import 'dart:convert';

GetAssessmentsResultsResponseModel getAssessmentsResultsResponseModelFromJson(
    String str) =>
    GetAssessmentsResultsResponseModel.fromJson(json.decode(str));

String getAssessmentsResultsResponseModelToJson(
    GetAssessmentsResultsResponseModel data) =>
    json.encode(data.toJson());

class GetAssessmentsResultsResponseModel {
  GetAssessmentsResultsResponseModel(
      {this.assessmentsResultList, this.meta, this.resultList});

  List<AssessmentResultList> assessmentsResultList;
  List<String> resultList;
  Meta meta;

  factory GetAssessmentsResultsResponseModel.fromJson(
      Map<String, dynamic> json) =>
      GetAssessmentsResultsResponseModel(
        assessmentsResultList: List<AssessmentResultList>.from(
            json["assessment_results"]
                .map((x) => AssessmentResultList.fromJson(x))),
        meta: Meta.fromJson(
          json["meta"],
        ),
        resultList: json['result'].cast<String>(),
      );

  Map<String, dynamic> toJson() => {
    "assessment_results":
    List<dynamic>.from(assessmentsResultList.map((x) => x.toJson())),
    "meta": meta.toJson(),
    "result": resultList,
  };
}

/*{
      "age": "26",
      "assessment_id": "ywlxbz8yrlp942",
      "assessment_result_id": "oss37udvyoxjl9i2",
      "created_at": "2021-12-17 14:21:02",
      "created_by": "",
      "final_score": "73",
      "gender": "Male",
      "id": "33",
      "modified_at": "",
      "modified_by": "",
      "name": "shubham",
      "phone": "917986234745",
      "status": "1",
      "user_id": "dd2q3fceubq5o"
    },*/
class AssessmentResultList {
  AssessmentResultList({
    this.assessmentId,
    this.age,
    this.assessment_result_id,
    this.created_at,
    this.created_by,
    this.final_score,
    this.gender,
    this.id,
    this.modified_at,
    this.status,
    this.name,
    this.phone,
    this.user_id,
    this.modified_by,
  });

  String assessmentId;
  String age;
  String assessment_result_id;
  String created_at;
  String created_by;
  String final_score;
  String gender;
  String id;
  String modified_at;
  String modified_by;
  String name;
  String phone;
  String status;
  String user_id;

  factory AssessmentResultList.fromJson(Map<String, dynamic> json) =>
      AssessmentResultList(
        assessmentId: json["assessment_id"],
        created_at: json["created_at"],
        created_by: json["created_by"],
        id: json["id"],
        final_score: json["final_score"],
        gender: json["gender"],
        modified_at: json["modified_at"],
        modified_by: json["modified_by"],
        name: json["name"],
        phone: json["phone"],
        status: json["status"],
        user_id: json["user_id"],
        assessment_result_id: json["assessment_result_id"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
    "assessment_id": assessmentId,
    "created_at": created_at,
    "created_by": created_by,
    "id": id,
    "final_score": final_score,
    "modified_at": modified_at,
    "modified_by": modified_by,
    "user_id": user_id,
    "assessment_result_id": assessment_result_id,
    "age": age,
    "phone": phone,
    "name": name,
    "gender": gender,
    "status": status,
  };
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