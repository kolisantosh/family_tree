part of 'tree_bloc.dart';

class TreeState extends Equatable {
  const TreeState({required this.treeList});

  final ApiResponse<TreeListModel> treeList;

  TreeState copyWith({ApiResponse<TreeListModel>? treeList}) {
    return TreeState(treeList: treeList ?? this.treeList);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [treeList];
}
