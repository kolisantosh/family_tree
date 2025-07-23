import 'package:family_tree/repository/tree_api/tree_api_repository.dart';

import '../../model/tree_list/tree_list_model.dart';

/// Mock implementation of [TreeApiRepository] for simulating fetching member list.
class TreeMockApiRepository implements TreeApiRepository {
  @override
  Future<TreeListModel> fetchTreeList(String relationId) async {
    // Simulate a delay to mimic network latency
    await Future.delayed(const Duration(seconds: 2));
    // Mock response data
    dynamic responseData = {
      "status": true,
      "data": [
        {
          "member_id": "3",
          "primary_member": "no",
          "under_id": "2",
          "relative_id": "2",
          "relation": "Sun",
          "name": "Ram",
          "moblie_no": "7896541236",
          "email": "ram@gmail.com",
          "profession": "Devlaper",
          "age": "30",
          "d_o_b": "2025-07-12",
          "profile_img": "https://staging.infowebsoftware.com/FamilyTree/uploads/profile.png",
          "address": "112, Doshi Chamber, Poona Sholapur Street Cor, Masjid Bunder (east)",
          "created_at": "2025-07-12 11:42:35",
          "status": "1",
        },
        {
          "member_id": "8",
          "primary_member": "no",
          "under_id": "3",
          "relative_id": "730419",
          "relation": "Sun",
          "name": "Ramgopal",
          "moblie_no": "8569856989",
          "email": "ramgopal@gmail.com",
          "profession": "Docter",
          "age": "22",
          "d_o_b": "2000-06-20",
          "profile_img": "https://staging.infowebsoftware.com/FamilyTree/uploads/3.png",
          "address": "Nr Maninagar Police Station, Maninagar",
          "created_at": "2025-07-14 08:02:37",
          "status": "1",
        },
      ],
    };
    return TreeListModel.fromJson(responseData);
  }
}
