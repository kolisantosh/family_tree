import 'package:family_tree/bloc/person_details_bloc/person_details_bloc.dart';
import 'package:family_tree/configs/themes/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../configs/routes/routes_name.dart';
import '../../data/response/status.dart';
import '../../dependency_injection/locator.dart';
import '../member/widget/error_widget.dart';

class PersonDetailsScreen extends StatefulWidget {
  String memberId = '';
  PersonDetailsScreen(this.memberId, {super.key});

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  late PersonDetailsBloc personDetailsBloc;

  @override
  void initState() {
    // TODO: implement initState
    personDetailsBloc = PersonDetailsBloc(treeDetailApiRepository: getIt());
    personDetailsBloc.add(PersonDataFetch(memberId: widget.memberId));

    super.initState();
  }

  @override
  void dispose() {
    personDetailsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          backgroundColor: ThemeConfig.primaryColor,
          onPressed: () {
            Navigator.pushReplacementNamed(context, RoutesName.home);
          },
          tooltip: AppLocalizations.of(context)!.title == null ? 'Home' : 'Home',
          child: const Icon(Icons.home, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: BlocProvider.value(
          value: personDetailsBloc,
          child: BlocBuilder<PersonDetailsBloc, PersonDetailsState>(
            buildWhen: (previous, current) => previous.treeData != current.treeData,
            builder: (context, state) {
              switch (state.treeData.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());

                case Status.error:
                  return const MemberErrorWidget();

                case Status.completed:
                  if (state.treeData.data == null) {
                    return Center(child: Text(AppLocalizations.of(context)!.noDataFound));
                  }

                  final treeList = state.treeData.data!.data;
                  if (treeList == null) {
                    return Center(child: Text(AppLocalizations.of(context)!.noDataFound));
                  }

                  return Column(children: [Container(height: 200, color: ThemeConfig.primaryColor, child: Text(treeList.name!))]);
              }
            },
          ),
        ),
      ),
    );
  }
}
