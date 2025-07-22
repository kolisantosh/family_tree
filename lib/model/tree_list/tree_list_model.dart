import 'package:freezed_annotation/freezed_annotation.dart'; // Importing freezed_annotation package

part 'tree_list_model.freezed.dart'; // Importing generated code for Freezed classes
part 'tree_list_model.g.dart'; // Importing generated code for JSON serialization

@freezed
class TreeListModel with _$TreeListModel {
  /// Factory constructor for creating a [TreeListModel] instance.
  factory TreeListModel({
    @JsonKey(name: 'name') @Default('') String name, // Name of the TV show
    @Default('') String permalink, // Permalink of the TV show
    @Default('') String endDate, // End date of the TV show
    @Default('') String imageThumbnailPath, // Image thumbnail path of the TV show
    @Default('') String status, // Status of the TV show
  }) = _TreeListModel; // Constructor for the freezed class

  /// Factory constructor for creating a [TreeListModel] instance from JSON.
  factory TreeListModel.fromJson(Map<String, dynamic> json) => _$TreeListModelFromJson(json); // JSON deserialization method
}
