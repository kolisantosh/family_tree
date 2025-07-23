import '../../model/member_list/member_list_model.dart';

/// Abstract class defining methods for member API repositories.
abstract class MemberApiRepository {
  /// Fetches the list of Member from the API.
  ///
  /// Returns a [MemberListModel] representing the list of Member.
  Future<MemberListModel> fetchMemberList();
  Future<MemberListModel> searchMemberList(String query);
}
