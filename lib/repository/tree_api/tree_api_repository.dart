import '../../model/tree_list/tree_list_model.dart';

/// Abstract class defining methods for movies API repositories.
abstract class TreeApiRepository {
  /// Fetches the list of movies from the API.
  ///
  /// Returns a [TreeListModel] representing the list of movies.
  Future<TreeListModel> fetchTreeList();
}
