import 'package:freezed_annotation/freezed_annotation.dart'; // Importing freezed_annotation package

part 'member_list_model.freezed.dart';
part 'member_list_model.g.dart';

@freezed
class MemberListModel with _$MemberListModel {
  const factory MemberListModel({@JsonKey(name: "status") bool? status, @JsonKey(name: "data") List<Datum>? data}) = _MemberListModel;

  factory MemberListModel.fromJson(Map<String, dynamic> json) => _$MemberListModelFromJson(json);
}

@freezed
class Datum with _$Datum {
  const factory Datum({
    @JsonKey(name: "member_id") String? memberId,
    @JsonKey(name: "primary_member") PrimaryMember? primaryMember,
    @JsonKey(name: "under_id") String? underId,
    @JsonKey(name: "relative_id") String? relativeId,
    @JsonKey(name: "relation") Relation? relation,
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
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}

enum PrimaryMember {
  @JsonValue("no")
  NO,
  @JsonValue("yes")
  YES,
}

final primaryMemberValues = EnumValues({"no": PrimaryMember.NO, "yes": PrimaryMember.YES});

enum Relation {
  @JsonValue("Daughter")
  DAUGHTER,
  @JsonValue("")
  EMPTY,
  @JsonValue("Son")
  SON,
  @JsonValue("Sun")
  SUN,
}

final relationValues = EnumValues({"Daughter": Relation.DAUGHTER, "": Relation.EMPTY, "Son": Relation.SON, "Sun": Relation.SUN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
