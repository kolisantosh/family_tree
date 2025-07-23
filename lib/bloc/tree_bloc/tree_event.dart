part of 'tree_bloc.dart';

abstract class TreeEvent {}

class TreeFetch extends TreeEvent {
  String relationId;
  TreeFetch({required this.relationId});
}
