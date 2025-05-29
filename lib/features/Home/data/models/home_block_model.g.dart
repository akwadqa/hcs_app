// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_block_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBlockModel _$HomeBlockModelFromJson(Map<String, dynamic> json) =>
    HomeBlockModel(
      statusCode: (json['status_code'] as num).toInt(),
      error: (json['error'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => HomeBlockModelDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeBlockModelToJson(HomeBlockModel instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };

HomeBlockModelDatum _$HomeBlockModelDatumFromJson(Map<String, dynamic> json) =>
    HomeBlockModelDatum(
      id: json['id'] as String,
      type: json['type'] as String,
      background: json['background'] as String?,
      view: json['view'],
      data: (json['data'] as List<dynamic>)
          .map((e) => DatumDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$HomeBlockModelDatumToJson(
  HomeBlockModelDatum instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'background': instance.background,
  'view': instance.view,
  'data': instance.data,
  'title': instance.title,
};

DatumDatum _$DatumDatumFromJson(Map<String, dynamic> json) => DatumDatum(
  bannerImage: json['banner_image'] as String?,
  bannerType: json['banner_type'] as String?,
  bannerView: json['banner_view'],
  viewId: json['view_id'],
  bannerLink: json['banner_link'],
  itemGroupId: json['item_group_id'] as String?,
  image: json['image'] as String?,
  backgroundColor: json['background_color'] as String?,
  websiteTitle: json['website_title'],
  route: json['route'] as String?,
  categoryView: json['category_view'],
  weightage: (json['weightage'] as num?)?.toInt(),
  childItemGroups: (json['child_item_groups'] as List<dynamic>?)
      ?.map((e) => ChildItemGroup.fromJson(e as Map<String, dynamic>))
      .toList(),
  websiteItemId: json['website_item_id'] as String?,
  itemName: json['item_name'] as String?,
  mobileDefaultUom: json['mobile_default_uom'],
  websiteImage: json['website_image'],
  itemPrice: (json['item_price'] as num?)?.toDouble(),
  discountPercent: json['discount_percent'] as String?,
  discountAmount: (json['discount_amount'] as num?)?.toInt(),
  discountedPrice: (json['discounted_price'] as num?)?.toDouble(),
);

Map<String, dynamic> _$DatumDatumToJson(DatumDatum instance) =>
    <String, dynamic>{
      'banner_image': instance.bannerImage,
      'banner_type': instance.bannerType,
      'banner_view': instance.bannerView,
      'view_id': instance.viewId,
      'banner_link': instance.bannerLink,
      'item_group_id': instance.itemGroupId,
      'image': instance.image,
      'background_color': instance.backgroundColor,
      'website_title': instance.websiteTitle,
      'route': instance.route,
      'category_view': instance.categoryView,
      'weightage': instance.weightage,
      'child_item_groups': instance.childItemGroups,
      'website_item_id': instance.websiteItemId,
      'item_name': instance.itemName,
      'mobile_default_uom': instance.mobileDefaultUom,
      'website_image': instance.websiteImage,
      'item_price': instance.itemPrice,
      'discount_percent': instance.discountPercent,
      'discount_amount': instance.discountAmount,
      'discounted_price': instance.discountedPrice,
    };

ChildItemGroup _$ChildItemGroupFromJson(Map<String, dynamic> json) =>
    ChildItemGroup(
      itemGroupId: json['item_group_id'] as String,
      image: json['image'] as String?,
      backgroundColor: json['background_color'] as String?,
      websiteTitle: json['website_title'],
      route: json['route'] as String,
      categoryView: json['category_view'],
      weightage: (json['weightage'] as num).toInt(),
      childItemGroups: (json['child_item_groups'] as List<dynamic>)
          .map((e) => ChildItemGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChildItemGroupToJson(ChildItemGroup instance) =>
    <String, dynamic>{
      'item_group_id': instance.itemGroupId,
      'image': instance.image,
      'background_color': instance.backgroundColor,
      'website_title': instance.websiteTitle,
      'route': instance.route,
      'category_view': instance.categoryView,
      'weightage': instance.weightage,
      'child_item_groups': instance.childItemGroups,
    };
