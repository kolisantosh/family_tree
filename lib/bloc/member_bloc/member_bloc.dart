import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:family_tree/data/response/api_response.dart';
import 'package:family_tree/data/response/response.dart';
import 'package:family_tree/model/member_list/member_list_model.dart';
import 'package:flutter/foundation.dart';

import '../../repository/member_api/member_list_api_repository.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberApiRepository memberApiRepository;
  MemberBloc({required this.memberApiRepository}) : super(MemberState(membersList: ApiResponse.loading())) {
    on<MemberFetch>(fetchMemberListApi);
    on<MemberSearch>(searchMemberApi);
  }

  Future<void> fetchMemberListApi(MemberFetch event, Emitter<MemberState> emit) async {
    await memberApiRepository
        .fetchMemberList()
        .then((response) {
          emit(state.copyWith(moviesList: ApiResponse.completed(response)));
        })
        .onError((error, stackTrace) {
          if (kDebugMode) {
            print(stackTrace);
            print(error);
          }

          emit(state.copyWith(moviesList: ApiResponse.error(error.toString())));
        });
  }

  Future<void> searchMemberApi(MemberSearch event, Emitter<MemberState> emit) async {
    await memberApiRepository
        .searchMemberList(event.query)
        .then((response) {
          emit(state.copyWith(moviesList: ApiResponse.completed(response)));
        })
        .onError((error, stackTrace) {
          if (kDebugMode) {
            print(stackTrace);
            print(error);
          }

          emit(state.copyWith(moviesList: ApiResponse.error(error.toString())));
        });
  }
}
