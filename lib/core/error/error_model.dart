class ErrorModel {
  String messageError;
  int statusCode;

  ErrorModel({required this.messageError, required this.statusCode});

  factory ErrorModel.fromJson(Map<String, dynamic> json, int statCode) {
    return ErrorModel(messageError: json['message'], statusCode: statCode);
  }
}
