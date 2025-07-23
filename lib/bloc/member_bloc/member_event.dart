part of 'member_bloc.dart';

abstract class MemberEvent {}

class MemberFetch extends MemberEvent {}

class MemberSearch extends MemberEvent {
  String query;
  MemberSearch({required this.query});
}
