// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tree_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TreeListModel _$TreeListModelFromJson(Map<String, dynamic> json) {
  return _TreeListModel.fromJson(json);
}

/// @nodoc
mixin _$TreeListModel {
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError; // Name of the TV show
  String get permalink =>
      throw _privateConstructorUsedError; // Permalink of the TV show
  String get endDate =>
      throw _privateConstructorUsedError; // End date of the TV show
  String get network =>
      throw _privateConstructorUsedError; // Network of the TV show
  String get imageThumbnailPath =>
      throw _privateConstructorUsedError; // Image thumbnail path of the TV show
  String get status => throw _privateConstructorUsedError;

  /// Serializes this TreeListModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TreeListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TreeListModelCopyWith<TreeListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreeListModelCopyWith<$Res> {
  factory $TreeListModelCopyWith(
    TreeListModel value,
    $Res Function(TreeListModel) then,
  ) = _$TreeListModelCopyWithImpl<$Res, TreeListModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'name') String name,
    String permalink,
    String endDate,
    String network,
    String imageThumbnailPath,
    String status,
  });
}

/// @nodoc
class _$TreeListModelCopyWithImpl<$Res, $Val extends TreeListModel>
    implements $TreeListModelCopyWith<$Res> {
  _$TreeListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TreeListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? permalink = null,
    Object? endDate = null,
    Object? network = null,
    Object? imageThumbnailPath = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            permalink:
                null == permalink
                    ? _value.permalink
                    : permalink // ignore: cast_nullable_to_non_nullable
                        as String,
            endDate:
                null == endDate
                    ? _value.endDate
                    : endDate // ignore: cast_nullable_to_non_nullable
                        as String,
            network:
                null == network
                    ? _value.network
                    : network // ignore: cast_nullable_to_non_nullable
                        as String,
            imageThumbnailPath:
                null == imageThumbnailPath
                    ? _value.imageThumbnailPath
                    : imageThumbnailPath // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TreeListModelImplCopyWith<$Res>
    implements $TreeListModelCopyWith<$Res> {
  factory _$$TreeListModelImplCopyWith(
    _$TreeListModelImpl value,
    $Res Function(_$TreeListModelImpl) then,
  ) = __$$TreeListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'name') String name,
    String permalink,
    String endDate,
    String network,
    String imageThumbnailPath,
    String status,
  });
}

/// @nodoc
class __$$TreeListModelImplCopyWithImpl<$Res>
    extends _$TreeListModelCopyWithImpl<$Res, _$TreeListModelImpl>
    implements _$$TreeListModelImplCopyWith<$Res> {
  __$$TreeListModelImplCopyWithImpl(
    _$TreeListModelImpl _value,
    $Res Function(_$TreeListModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TreeListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? permalink = null,
    Object? endDate = null,
    Object? network = null,
    Object? imageThumbnailPath = null,
    Object? status = null,
  }) {
    return _then(
      _$TreeListModelImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        permalink:
            null == permalink
                ? _value.permalink
                : permalink // ignore: cast_nullable_to_non_nullable
                    as String,
        endDate:
            null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                    as String,
        network:
            null == network
                ? _value.network
                : network // ignore: cast_nullable_to_non_nullable
                    as String,
        imageThumbnailPath:
            null == imageThumbnailPath
                ? _value.imageThumbnailPath
                : imageThumbnailPath // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TreeListModelImpl implements _TreeListModel {
  _$TreeListModelImpl({
    @JsonKey(name: 'name') this.name = '',
    this.permalink = '',
    this.endDate = '',
    this.network = '',
    this.imageThumbnailPath = '',
    this.status = '',
  });

  factory _$TreeListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TreeListModelImplFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String name;
  // Name of the TV show
  @override
  @JsonKey()
  final String permalink;
  // Permalink of the TV show
  @override
  @JsonKey()
  final String endDate;
  // End date of the TV show
  @override
  @JsonKey()
  final String network;
  // Network of the TV show
  @override
  @JsonKey()
  final String imageThumbnailPath;
  // Image thumbnail path of the TV show
  @override
  @JsonKey()
  final String status;

  @override
  String toString() {
    return 'TreeListModel(name: $name, permalink: $permalink, endDate: $endDate, network: $network, imageThumbnailPath: $imageThumbnailPath, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreeListModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.permalink, permalink) ||
                other.permalink == permalink) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.imageThumbnailPath, imageThumbnailPath) ||
                other.imageThumbnailPath == imageThumbnailPath) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    permalink,
    endDate,
    network,
    imageThumbnailPath,
    status,
  );

  /// Create a copy of TreeListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TreeListModelImplCopyWith<_$TreeListModelImpl> get copyWith =>
      __$$TreeListModelImplCopyWithImpl<_$TreeListModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TreeListModelImplToJson(this);
  }
}

abstract class _TreeListModel implements TreeListModel {
  factory _TreeListModel({
    @JsonKey(name: 'name') final String name,
    final String permalink,
    final String endDate,
    final String network,
    final String imageThumbnailPath,
    final String status,
  }) = _$TreeListModelImpl;

  factory _TreeListModel.fromJson(Map<String, dynamic> json) =
      _$TreeListModelImpl.fromJson;

  @override
  @JsonKey(name: 'name')
  String get name; // Name of the TV show
  @override
  String get permalink; // Permalink of the TV show
  @override
  String get endDate; // End date of the TV show
  @override
  String get network; // Network of the TV show
  @override
  String get imageThumbnailPath; // Image thumbnail path of the TV show
  @override
  String get status;

  /// Create a copy of TreeListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TreeListModelImplCopyWith<_$TreeListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
