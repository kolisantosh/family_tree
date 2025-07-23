import '../../model/tree/tree_model.dart';

/// Abstract class defining methods for tree API repositories.
abstract class TreeDetailApiRepository {
  /// Fetches the detail of tree from the API.
  ///
  /// Returns a [TreeModel] representing the detail of tree.
  Future<TreeModel> fetchTreeDetail(String memberId);
}
