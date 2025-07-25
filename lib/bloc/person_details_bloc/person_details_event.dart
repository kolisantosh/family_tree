part of 'person_details_bloc.dart';

abstract class PersonDetailsEvent {}

class PersonDataFetch extends PersonDetailsEvent {
  String memberId;
  PersonDataFetch({required this.memberId});
}
