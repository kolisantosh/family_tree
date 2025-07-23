import '../../data/network/network_api_services.dart';
import '../../model/tree/tree_model.dart';
import '../../utils/app_url.dart';
import 'tree_detail_api_repository.dart';

/// Implementation of [TreeApiRepository] for making HTTP requests to fetch Tree list.
class TreeDetailHttpApiRepository implements TreeDetailApiRepository {
  final _apiServices = NetworkApiService();

  /// Fetches the list of Tree from the API.
  ///
  /// Returns a [TreeModel] representing the list of Tree.
  @override
  Future<TreeModel> fetchTreeDetail(String memberId) async {
    var params = {"member_id": memberId, "token": "dufuewjc545w-kkfghferf5ef8ehegf6511d-iuefeihddehi"};
    final response = await _apiServices.postApi(AppUrl.popularMemberItemListEndPoint, params);
    return TreeModel.fromJson(response);
  }
}
