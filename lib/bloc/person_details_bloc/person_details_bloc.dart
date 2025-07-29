import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:family_tree/data/response/api_response.dart';
import 'package:family_tree/data/response/response.dart';
import 'package:family_tree/model/tree/tree_model.dart';
import 'package:flutter/foundation.dart';

import '../../repository/tree_detail_api/tree_detail_api_repository.dart';

part 'person_details_event.dart';
part 'person_details_state.dart';

class PersonDetailsBloc extends Bloc<PersonDetailsEvent, PersonDetailsState> {
  TreeDetailApiRepository treeDetailApiRepository;
  PersonDetailsBloc({required this.treeDetailApiRepository}) : super(PersonDetailsState(treeData: ApiResponse.loading())) {
    on<PersonDataFetch>(fetchTreeDetailsApi);
  }

  Future<void> fetchTreeDetailsApi(PersonDataFetch event, Emitter<PersonDetailsState> emit) async {
    await treeDetailApiRepository
        .fetchTreeDetail(event.memberId)
        .then((response) {
          emit(state.copyWith(treeData: ApiResponse.completed(response)));
        })
        .onError((error, stackTrace) {
          if (kDebugMode) {
            print(stackTrace);
            print(error);
          }

          emit(state.copyWith(treeData: ApiResponse.error(error.toString())));
        });
  }
}
