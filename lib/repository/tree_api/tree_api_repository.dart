import '../../model/tree_list/tree_list_model.dart';

/// Abstract class defining methods for tree API repositories.
abstract class TreeApiRepository {
  /// Fetches the list of tree from the API.
  ///
  /// Returns a [TreeListModel] representing the list of tree.
  Future<TreeListModel> fetchTreeList(String relationId);
}
