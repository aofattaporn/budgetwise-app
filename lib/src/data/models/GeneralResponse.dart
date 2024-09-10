class GeneralResponse {
  final int code;
  final String description;
  final dynamic data;

  GeneralResponse(
    this.code,
    this.description,
    this.data,
  );

  // Convert an Interceptor object into a Map (JSON).
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'description': description,
      'data': data,
    };
  }

  // Convert a Map (JSON) into an Interceptor object.
  factory GeneralResponse.fromJson(Map<String, dynamic> json) {
    return GeneralResponse(
      json['code'] as int,
      json['description'] as String,
      json['data'],
    );
  }
}
