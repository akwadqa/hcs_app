// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditsModel _$CreditsModelFromJson(Map<String, dynamic> json) => CreditsModel(
  statusCode: (json['status_code'] as num).toInt(),
  error: (json['error'] as num).toInt(),
  message: json['message'] as String,
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  data: (json['data'] as List<dynamic>)
      .map((e) => Datum.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CreditsModelToJson(CreditsModel instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'error': instance.error,
      'message': instance.message,
      'pagination': instance.pagination,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
  websiteItemId: json['website_item_id'],
  itemCode: json['item_code'] as String,
  websiteImage: json['website_image'] as String?,
  itemName: json['item_name'] as String,
  backgroundColor: json['background_color'] as String,
  currency: json['currency'] as String,
  inStock: (json['in_stock'] as num).toInt(),
  isStockItem: (json['is_stock_item'] as num).toInt(),
  itemPrice: (json['item_price'] as num).toDouble(),
  discountPercent: json['discount_percent'] as String,
  discountAmount: (json['discount_amount'] as num).toInt(),
  discountedPrice: (json['discounted_price'] as num).toDouble(),
);

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
  'website_item_id': instance.websiteItemId,
  'item_code': instance.itemCode,
  'website_image': instance.websiteImage,
  'item_name': instance.itemName,
  'background_color': instance.backgroundColor,
  'currency': instance.currency,
  'in_stock': instance.inStock,
  'is_stock_item': instance.isStockItem,
  'item_price': instance.itemPrice,
  'discount_percent': instance.discountPercent,
  'discount_amount': instance.discountAmount,
  'discounted_price': instance.discountedPrice,
};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  totalItems: (json['total_items'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
    };
