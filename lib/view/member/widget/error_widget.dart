import 'package:family_tree/bloc/member_bloc/member_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../configs/components/internet_exception_widget.dart'; // Importing the InternetExceptionWidget

/// A widget for displaying error messages related to member.
class MemberErrorWidget extends StatelessWidget {
  const MemberErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberBloc, MemberState>(
      buildWhen: (previous, current) => previous.membersList != current.membersList,
      builder: (context, state) {
        // Checking if the error message indicates no internet connection
        if (state.membersList.message.toString() == AppLocalizations.of(context)!.noInternetConnection) {
          // Displaying InternetExceptionWidget if there's no internet connection
          return InterNetExceptionWidget(
            onPress: () {
              // Dispatching PostFetched event to trigger fetching member data
              context.read<MemberBloc>().add(MemberFetch());
            },
          );
        } else {
          // Displaying error message as a clickable text if it's not related to internet connection
          return InkWell(
            onTap: () {
              // Dispatching PostFetched event to trigger fetching member data
              context.read<MemberBloc>().add(MemberFetch());
            },
            child: Center(child: Text(state.membersList.message.toString())),
          );
        }
      },
    );
  }
}
