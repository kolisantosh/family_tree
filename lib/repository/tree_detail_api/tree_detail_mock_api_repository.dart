import 'package:family_tree/repository/tree_api/tree_api_repository.dart';
import 'package:family_tree/repository/tree_detail_api/tree_detail_api_repository.dart';

import '../../model/tree/tree_model.dart';

/// Mock implementation of [TreeApiRepository] for simulating fetching member list.
class TreeDetailMockApiRepository implements TreeDetailApiRepository {
  @override
  Future<TreeModel> fetchTreeDetail(String memberId) async {
    // Simulate a delay to mimic network latency
    await Future.delayed(const Duration(seconds: 2));
    // Mock response data
    dynamic responseData = {
      "status": true,
      "data": {
        "member_id": "2",
        "primary_member": "yes",
        "under_id": "0",
        "relative_id": "730419",
        "relation": "",
        "name": "John Due",
        "moblie_no": "7412589632",
        "email": "aansari81786@gmail.com",
        "profession": "Devlaper",
        "age": "25",
        "d_o_b": "2025-07-12",
        "profile_img": "https://staging.infowebsoftware.com/FamilyTree/uploads/profile.png",
        "address": "A/112 Panorama Complex, R C Dutt Road, R C Dutt Road",
        "created_at": "2025-07-12 10:49:00",
        "status": "1",
      },
    };
    return TreeModel.fromJson(responseData);
  }
}
