import 'dart:async';

import 'package:family_tree/data/response/response.dart';
import 'package:family_tree/data/response/status.dart';
import 'package:family_tree/model/member_list/member_list_model.dart';
import 'package:family_tree/view/member/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/member_bloc/member_bloc.dart';
import '../../configs/components/network_image_widget.dart';
import '../../configs/routes/routes_name.dart';
import '../../configs/themes/theme_config.dart';
import '../../dependency_injection/locator.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({Key? key}) : super(key: key);

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  late MemberBloc memberBloc;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    memberBloc = MemberBloc(memberApiRepository: getIt());
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();
      if (query.isNotEmpty && query.length > 2) {
        memberBloc.add(MemberSearch(query: query));
      } else {
        memberBloc.add(MemberFetch());
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    memberBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeConfig.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.title, style: TextStyle(color: Colors.white)),
        // actions: const [LogoutButtonWidget(), SizedBox(width: 20)],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search,
                hintStyle: TextStyle(color: ThemeConfig.borderColorDark),
                prefixIcon: const Icon(Icons.search, color: ThemeConfig.borderColorDark),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ThemeConfig.borderColorDark, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ThemeConfig.borderColorDark, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ThemeConfig.borderColorDark, width: 1.5),
                ),
              ),
              onFieldSubmitted: (value) {
                if (value.isNotEmpty && value.length > 2) {
                  memberBloc.add(MemberSearch(query: value));
                } else {
                  memberBloc.add(MemberFetch());
                }
              },
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => memberBloc..add(MemberFetch()),
        child: BlocBuilder<MemberBloc, MemberState>(
          buildWhen: (previous, current) => previous.membersList != current.membersList,
          builder: (BuildContext context, state) {
            switch (state.membersList.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return const MemberErrorWidget();
              case Status.completed:
                if (state.membersList.data == null) {
                  return Text(AppLocalizations.of(context)!.noDataFound);
                }
                final movieList = state.membersList.data!.data ?? [];
                return ListView.builder(
                  itemCount: movieList.length,
                  itemBuilder: (context, index) {
                    final treeData = movieList[index];
                    return Card(
                      child: ListTile(
                        tileColor: treeData.primaryMember == PrimaryMember.YES ? ThemeConfig.primaryColor.withOpacity(0.5) : null,
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.tree, arguments: treeData.relativeId);
                        },
                        leading: NetworkImageWidget(borderRadius: 5, imageUrl: treeData.profileImg.toString()),
                        title: Text(treeData.name.toString()),
                        subtitle: Text(treeData.address.toString()),
                        trailing: Text(treeData.status.toString()),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
