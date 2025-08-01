import 'dart:async';

import 'package:family_tree/data/response/response.dart';
import 'package:family_tree/data/response/status.dart';
import 'package:family_tree/view/member/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/member_bloc/member_bloc.dart';
import '../../configs/Icon/icon.dart';
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

  bool get _isSearching {
    final query = _searchController.text.trim();
    return query.isNotEmpty && query.length > 2;
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
      // Floating button centered at bottom
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          backgroundColor: ThemeConfig.primaryColor,
          onPressed: () {
            Navigator.pushReplacementNamed(context, RoutesName.home);
          },
          child: const Icon(Icons.home, color: Colors.white),
          tooltip: AppLocalizations.of(context)!.title == null ? 'Home' : 'Home',
        ),
      ),
      body: BlocProvider(
        create: (_) => memberBloc..add(MemberFetch()),
        child: BlocBuilder<MemberBloc, MemberState>(
          buildWhen: (previous, current) => previous.membersList != current.membersList,
          builder: (BuildContext context, state) {
            return SafeArea(
              child: Column(
                children: [
                  // Replaced AppBar: title + search field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(
                        //   AppLocalizations.of(context)!.title,
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .headlineLarge
                        //       ?.copyWith(fontWeight: FontWeight.bold),
                        // ),
                        Image.asset(AppIcons.logo, height: 90, fit: BoxFit.cover),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            focusColor: ThemeConfig.borderColorDark,
                            hintText: AppLocalizations.of(context)!.search,
                            hintStyle: TextStyle(color: ThemeConfig.borderColorLight),
                            prefixIcon: const Icon(Icons.search, color: ThemeConfig.borderColorLight),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: ThemeConfig.borderColorLight, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: ThemeConfig.borderColorLight, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: ThemeConfig.borderColorLight, width: 1.5),
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        switch (state.membersList.status) {
                          case Status.loading:
                            return const Center(child: CircularProgressIndicator());
                          case Status.error:
                            return const MemberErrorWidget();
                          case Status.completed:
                            if (state.membersList.data == null) {
                              return Center(child: Text(AppLocalizations.of(context)!.noDataFound));
                            }
                            final membersList = state.membersList.data!.data ?? [];
                            if (membersList.isEmpty) {
                              return Center(child: Text(AppLocalizations.of(context)!.noDataFound));
                            }
                            // Decide what to show: first 6 when not searching, else full list
                            final displayList =
                                _isSearching ? membersList : (membersList.length > 6 ? membersList.sublist(0, 6) : membersList);

                            return ListView.builder(
                              itemCount: displayList.length,
                              itemBuilder: (context, index) {
                                final treeData = displayList[index];
                                return Card(
                                  child: ListTile(
                                    // tileColor:
                                    //     treeData.primaryMember == PrimaryMember.YES ? ThemeConfig.primaryColor.withOpacity(0.5) : null,
                                    onTap: () {
                                      Navigator.pushNamed(context, RoutesName.tree, arguments: treeData.relativeId);
                                    },
                                    leading: NetworkImageWidget(borderRadius: 5, imageUrl: treeData.profileImg.toString()),
                                    title: Text(treeData.name.toString()),
                                    subtitle: Text(treeData.address.toString()),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
