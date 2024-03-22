part of 'product_model.dart';

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    id: json['id'] as int,
    productGroupId: json['productGroupId'] as int,
    productGroupDescription: json['productGroupDescription'] as String,
    productUnitId: json['productUnitId'] as int,
    productUnitDescription: json['productUnitDescription'] as String,
    code: json['code'] as String,
    barcode: json['barcode'] as String,
    description: json['description'] as String,
    minimumQuantity: json['minimumQuantity'] as double,
    maximumQuantity: json['maximumQuantity'] as double,
    isStock: json['isStock'] as bool,
    isActive: json['isActive'] as bool,
    image: json['image'] as String?,
    insertUser: json['insertUser'] as int,
    insertUserDescription: json['insertUserDescription'] as String,
    insertDate: json['insertDate'] == null
        ? null
        : DateTime.parse(json['insertDate'] as String),
    updateUser: json['updateUser'] as int,
    updateUserDescription: json['updateUserDescription'] as String,
    updateDate: json['updateDate'] == null
        ? null
        : DateTime.parse(json['updateDate'] as String),
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productGroupId': instance.productGroupId,
      'productGroupDescription': instance.productGroupDescription,
      'productUnitId': instance.productUnitId,
      'productUnitDescription': instance.productUnitDescription,
      'code': instance.code,
      'barcode': instance.barcode,
      'description': instance.description,
      'minimumQuantity': instance.minimumQuantity,
      'maximumQuantity': instance.maximumQuantity,
      'isStock': instance.isStock,
      'isActive': instance.isActive,
      'image': instance.image,
      'insertUser': instance.insertUser,
      'insertUserDescription': instance.insertUserDescription,
      'insertDate': instance.insertDate?.toIso8601String(),
      'updateUser': instance.updateUser,
      'updateUserDescription': instance.updateUserDescription,
      'updateDate': instance.updateDate?.toIso8601String(),
    };
