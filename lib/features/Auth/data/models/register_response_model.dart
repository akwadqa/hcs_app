// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'register_response_model.g.dart';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

@JsonSerializable()
class RegisterResponse {
    @JsonKey(name: "status_code")
    int statusCode;
    @JsonKey(name: "error")
    int error;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    Data data;

    RegisterResponse({
        required this.statusCode,
        required this.error,
        required this.message,
        required this.data,
    });

    factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

    Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class Data {
    @JsonKey(name: "token")
    String token;

    Data({
        required this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}
