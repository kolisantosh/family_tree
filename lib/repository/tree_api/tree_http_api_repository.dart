import '../../data/network/network_api_services.dart';
import '../../model/tree_list/tree_list_model.dart';
import '../../utils/app_url.dart';
import 'tree_api_repository.dart';

/// Implementation of [TreeApiRepository] for making HTTP requests to fetch Tree list.
class TreeHttpApiRepository implements TreeApiRepository {
  final _apiServices = NetworkApiService();

  /// Fetches the list of Tree from the API.
  ///
  /// Returns a [TreeListModel] representing the list of Tree.
  @override
  Future<TreeListModel> fetchTreeList() async {
    final response = await _apiServices.getApi(AppUrl.popularTreeListEndPoint);
    return TreeListModel.fromJson(response);
  }
}
