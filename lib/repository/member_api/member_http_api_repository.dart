import 'dart:convert';

import '../../data/network/network_api_services.dart';
import '../../model/member_list/member_list_model.dart';
import '../../utils/app_url.dart';
import 'member_list_api_repository.dart';

/// Implementation of [MemberApiRepository] for making HTTP requests to fetch member list.
class MemberHttpApiRepository implements MemberApiRepository {
  final _apiServices = NetworkApiService();

  /// Fetches the list of member from the API.
  ///
  /// Returns a [MemberListModel] representing the list of member.
  @override
  Future<MemberListModel> fetchMemberList() async {
    var params = {"token": "30e29df2e9cbdc7d5d3047f9a5cd0b1f60e14ae5"};
    final response = await _apiServices.postApi(AppUrl.popularMemberListEndPoint, jsonEncode(params));
    return MemberListModel.fromJson(response);
  }

  @override
  Future<MemberListModel> searchMemberList(String query) async {
    var params = {"search": query, "token": "9f3a2b1c-xyz-789secure-abcdefgh-ff5f54f45sf4"};
    final response = await _apiServices.postApi(AppUrl.popularMemberSearchEndPoint, jsonEncode(params));
    return MemberListModel.fromJson(response);
  }
}
