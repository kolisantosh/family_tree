part of 'person_details_bloc.dart';

class PersonDetailsState extends Equatable {
  const PersonDetailsState({required this.treeData});

  final ApiResponse<TreeModel> treeData;

  PersonDetailsState copyWith({ApiResponse<TreeModel>? treeData}) {
    return PersonDetailsState(treeData: treeData ?? this.treeData);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [treeData];
}
