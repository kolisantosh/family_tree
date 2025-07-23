import 'package:freezed_annotation/freezed_annotation.dart';

part 'tree_model.freezed.dart';
part 'tree_model.g.dart';

@freezed
class TreeModel with _$TreeModel {
  const factory TreeModel({@JsonKey(name: "status") bool? status, @JsonKey(name: "data") Data? data}) = _TreeModel;

  factory TreeModel.fromJson(Map<String, dynamic> json) => _$TreeModelFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    @JsonKey(name: "member_id") String? memberId,
    @JsonKey(name: "primary_member") String? primaryMember,
    @JsonKey(name: "under_id") String? underId,
    @JsonKey(name: "relative_id") String? relativeId,
    @JsonKey(name: "relation") String? relation,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "moblie_no") String? moblieNo,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "profession") String? profession,
    @JsonKey(name: "age") String? age,
    @JsonKey(name: "d_o_b") DateTime? dOB,
    @JsonKey(name: "profile_img") String? profileImg,
    @JsonKey(name: "address") String? address,
    @JsonKey(name: "created_at") DateTime? createdAt,
    @JsonKey(name: "status") String? status,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
