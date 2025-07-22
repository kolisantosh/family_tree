// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TreeListModelImpl _$$TreeListModelImplFromJson(Map<String, dynamic> json) =>
    _$TreeListModelImpl(
      name: json['name'] as String? ?? '',
      permalink: json['permalink'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      network: json['network'] as String? ?? '',
      imageThumbnailPath: json['imageThumbnailPath'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$$TreeListModelImplToJson(_$TreeListModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'permalink': instance.permalink,
      'endDate': instance.endDate,
      'network': instance.network,
      'imageThumbnailPath': instance.imageThumbnailPath,
      'status': instance.status,
    };
