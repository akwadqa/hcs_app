// To parse this JSON data, do
//
//     final homeBlockModel = homeBlockModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'home_block_model.g.dart';

HomeBlockModel homeBlockModelFromJson(String str) => HomeBlockModel.fromJson(json.decode(str));

String homeBlockModelToJson(HomeBlockModel data) => json.encode(data.toJson());

@JsonSerializable()
class HomeBlockModel {
    @JsonKey(name: "status_code")
    int statusCode;
    @JsonKey(name: "error")
    int error;
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "data")
    List<HomeBlockModelDatum> data;

    HomeBlockModel({
        required this.statusCode,
        required this.error,
        required this.message,
        required this.data,
    });

    factory HomeBlockModel.fromJson(Map<String, dynamic> json) => _$HomeBlockModelFromJson(json);

    Map<String, dynamic> toJson() => _$HomeBlockModelToJson(this);
}

@JsonSerializable()
class HomeBlockModelDatum {
    @JsonKey(name: "id")
    String id;
    @JsonKey(name: "type")
    String type;
    @JsonKey(name: "background")
    String? background;
    @JsonKey(name: "view")
    dynamic view;
    @JsonKey(name: "data")
    List<DatumDatum> data;
    @JsonKey(name: "title")
    String? title;

    HomeBlockModelDatum({
        required this.id,
        required this.type,
        required this.background,
        required this.view,
        required this.data,
        this.title,
    });

    factory HomeBlockModelDatum.fromJson(Map<String, dynamic> json) => _$HomeBlockModelDatumFromJson(json);

    Map<String, dynamic> toJson() => _$HomeBlockModelDatumToJson(this);
}

@JsonSerializable()
class DatumDatum {
    @JsonKey(name: "banner_image")
    String? bannerImage;
    @JsonKey(name: "banner_type")
    String? bannerType;
    @JsonKey(name: "banner_view")
    dynamic bannerView;
    @JsonKey(name: "view_id")
    dynamic viewId;
    @JsonKey(name: "banner_link")
    dynamic bannerLink;
    @JsonKey(name: "item_group_id")
    String? itemGroupId;
    @JsonKey(name: "image")
    String? image;
    @JsonKey(name: "background_color")
    String? backgroundColor;
    @JsonKey(name: "website_title")
    dynamic websiteTitle;
    @JsonKey(name: "route")
    String? route;
    @JsonKey(name: "category_view")
    dynamic categoryView;
    @JsonKey(name: "weightage")
    int? weightage;
    @JsonKey(name: "child_item_groups")
    List<ChildItemGroup>? childItemGroups;
    @JsonKey(name: "website_item_id")
    String? websiteItemId;
    @JsonKey(name: "item_name")
    String? itemName;
    @JsonKey(name: "mobile_default_uom")
    dynamic mobileDefaultUom;
    @JsonKey(name: "website_image")
    dynamic websiteImage;
    @JsonKey(name: "item_price")
    double? itemPrice;
    @JsonKey(name: "discount_percent")
    String? discountPercent;
    @JsonKey(name: "discount_amount")
    int? discountAmount;
    @JsonKey(name: "discounted_price")
    double? discountedPrice;

    DatumDatum({
        this.bannerImage,
        this.bannerType,
        this.bannerView,
        this.viewId,
        this.bannerLink,
        this.itemGroupId,
        this.image,
        this.backgroundColor,
        this.websiteTitle,
        this.route,
        this.categoryView,
        this.weightage,
        this.childItemGroups,
        this.websiteItemId,
        this.itemName,
        this.mobileDefaultUom,
        this.websiteImage,
        this.itemPrice,
        this.discountPercent,
        this.discountAmount,
        this.discountedPrice,
    });

    factory DatumDatum.fromJson(Map<String, dynamic> json) => _$DatumDatumFromJson(json);

    Map<String, dynamic> toJson() => _$DatumDatumToJson(this);
}

@JsonSerializable()
class ChildItemGroup {
    @JsonKey(name: "item_group_id")
    String itemGroupId;
    @JsonKey(name: "image")
    String? image;
    @JsonKey(name: "background_color")
    String? backgroundColor;
    @JsonKey(name: "website_title")
    dynamic websiteTitle;
    @JsonKey(name: "route")
    String route;
    @JsonKey(name: "category_view")
    dynamic categoryView;
    @JsonKey(name: "weightage")
    int weightage;
    @JsonKey(name: "child_item_groups")
    List<ChildItemGroup> childItemGroups;

    ChildItemGroup({
        required this.itemGroupId,
        required this.image,
        required this.backgroundColor,
        required this.websiteTitle,
        required this.route,
        required this.categoryView,
        required this.weightage,
        required this.childItemGroups,
    });

    factory ChildItemGroup.fromJson(Map<String, dynamic> json) => _$ChildItemGroupFromJson(json);

    Map<String, dynamic> toJson() => _$ChildItemGroupToJson(this);
}
