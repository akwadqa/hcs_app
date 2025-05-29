// To parse this JSON data, do
//
//     final creditsModel = creditsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'credits_model.g.dart';

CreditsModel creditsModelFromJson(String str) =>
    CreditsModel.fromJson(json.decode(str));

String creditsModelToJson(CreditsModel data) => json.encode(data.toJson());

@JsonSerializable()
class CreditsModel {
  @JsonKey(name: "status_code")
  int statusCode;
  @JsonKey(name: "error")
  int error;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "pagination")
  Pagination pagination;
  @JsonKey(name: "data")
  List<Datum> data;

  CreditsModel({
    required this.statusCode,
    required this.error,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory CreditsModel.fromJson(Map<String, dynamic> json) =>
      _$CreditsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreditsModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "website_item_id")
  dynamic websiteItemId;
  @JsonKey(name: "item_code")
  String itemCode;
  @JsonKey(name: "website_image")
  String? websiteImage;
  @JsonKey(name: "item_name")
  String itemName;
  @JsonKey(name: "background_color")
  String backgroundColor;
  @JsonKey(name: "currency")
  String currency;
  @JsonKey(name: "in_stock")
  int inStock;
  @JsonKey(name: "is_stock_item")
  int isStockItem;
  @JsonKey(name: "item_price")
  double itemPrice;
  @JsonKey(name: "discount_percent")
  String discountPercent;
  @JsonKey(name: "discount_amount")
  int discountAmount;
  @JsonKey(name: "discounted_price")
  double discountedPrice;

  Datum({
    required this.websiteItemId,
    required this.itemCode,
    required this.websiteImage,
    required this.itemName,
    required this.backgroundColor,
    required this.currency,
    required this.inStock,
    required this.isStockItem,
    required this.itemPrice,
    required this.discountPercent,
    required this.discountAmount,
    required this.discountedPrice,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: "page")
  int page;
  @JsonKey(name: "limit")
  int limit;
  @JsonKey(name: "total_items")
  int totalItems;
  @JsonKey(name: "total_pages")
  int totalPages;

  Pagination({
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
