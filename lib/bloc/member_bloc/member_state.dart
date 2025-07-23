part of 'member_bloc.dart';

class MemberState extends Equatable {
  const MemberState({required this.membersList});

  final ApiResponse<MemberListModel> membersList;

  MemberState copyWith({ApiResponse<MemberListModel>? moviesList}) {
    return MemberState(membersList: moviesList ?? this.membersList);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [membersList];
}
