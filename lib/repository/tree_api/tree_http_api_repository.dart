import 'dart:convert';

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
  Future<TreeListModel> fetchTreeList(String relationId) async {
    var params = {"relative_id": relationId, "token": "llgjtihh4h-t4h4t5rhg5t4gt4wg84ts-8sh8t4gh84t8hg4t8g"};
    final response = await _apiServices.postApi(AppUrl.popularMemberItemListEndPoint, jsonEncode(params));
    return TreeListModel.fromJson(response);
  }
}
