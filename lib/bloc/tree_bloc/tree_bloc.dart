import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:family_tree/data/response/api_response.dart';
import 'package:family_tree/data/response/response.dart';
import 'package:family_tree/repository/tree_api/tree_api_repository.dart';
import 'package:flutter/foundation.dart';

import '../../model/tree_list/tree_list_model.dart';

part 'tree_event.dart';
part 'tree_state.dart';

class TreeBloc extends Bloc<TreeEvent, TreeState> {
  TreeApiRepository treeApiRepository;
  TreeBloc({required this.treeApiRepository}) : super(TreeState(treeList: ApiResponse.loading())) {
    on<TreeFetch>(fetchTreeListApi);
  }

  Future<void> fetchTreeListApi(TreeFetch event, Emitter<TreeState> emit) async {
    await treeApiRepository
        .fetchTreeList()
        .then((response) {
          emit(state.copyWith(treeList: ApiResponse.completed(response)));
        })
        .onError((error, stackTrace) {
          if (kDebugMode) {
            print(stackTrace);
            print(error);
          }

          emit(state.copyWith(treeList: ApiResponse.error(error.toString())));
        });
  }
}
