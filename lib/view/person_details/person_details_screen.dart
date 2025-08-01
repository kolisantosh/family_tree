import 'package:family_tree/bloc/person_details_bloc/person_details_bloc.dart';
import 'package:family_tree/configs/themes/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import '../../configs/routes/routes_name.dart';
import '../../data/response/status.dart';
import '../../dependency_injection/locator.dart';
import '../member/widget/error_widget.dart';

class PersonDetailsScreen extends StatefulWidget {
  final String memberId;
  const PersonDetailsScreen(this.memberId, {super.key});

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  late PersonDetailsBloc personDetailsBloc;

  @override
  void initState() {
    super.initState();
    personDetailsBloc = PersonDetailsBloc(treeDetailApiRepository: getIt());
    personDetailsBloc.add(PersonDataFetch(memberId: widget.memberId));
  }

  @override
  void dispose() {
    personDetailsBloc.close();
    super.dispose();
  }

  String _formatDob(String? dobRaw) {
    if (dobRaw == null || dobRaw.isEmpty) return '-';
    try {
      final dt = DateTime.parse(dobRaw);
      return DateFormat.yMMMMd().format(dt);
    } catch (_) {
      return dobRaw;
    }
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text('$label: ', style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600))),
          Expanded(
            child: Text(
              value == null || value.isEmpty ? '-' : value,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeConfig.primaryColor,
        title: Text(""),
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          backgroundColor: ThemeConfig.primaryColor,
          onPressed: () {
            Navigator.pushReplacementNamed(context, RoutesName.home);
          },
          tooltip: loc.title == null ? 'Home' : 'Home',
          child: const Icon(Icons.home, color: Colors.white),
        ),
      ),
      body: SafeArea(
        top: false,
        child: BlocProvider.value(
          value: personDetailsBloc,
          child: BlocBuilder<PersonDetailsBloc, PersonDetailsState>(
            buildWhen: (previous, current) => previous.treeData != current.treeData,
            builder: (context, state) {
              switch (state.treeData.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());
                case Status.error:
                  return TreeErrorWidget(widget.memberId);
                case Status.completed:
                  if (state.treeData.data == null || state.treeData.data!.data == null) {
                    return Center(child: Text(loc.noDataFound));
                  }

                  final person = state.treeData.data!.data!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: double.infinity,
                          color: ThemeConfig.primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (person.profileImg != null && person.profileImg!.isNotEmpty) {
                                    showDialog(
                                      context: context,
                                      useSafeArea: true,
                                      builder:
                                          (_) => Dialog(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            backgroundColor: Colors.transparent,
                                            insetPadding: const EdgeInsets.all(8),
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: MediaQuery.of(context).size.height * 0.6,
                                                  child: PhotoView(
                                                    imageProvider: NetworkImage(person.profileImg!),
                                                    loadingBuilder: (context, event) => const Center(child: CircularProgressIndicator()),
                                                    errorBuilder:
                                                        (context, error, stackTrace) =>
                                                            const Center(child: Icon(Icons.broken_image, size: 80, color: Colors.white)),
                                                    backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                                                    minScale: PhotoViewComputedScale.contained,
                                                    maxScale: PhotoViewComputedScale.covered * 2.5,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 8,
                                                  right: 8,
                                                  child: IconButton(
                                                    icon: const Icon(Icons.close, color: Colors.white),
                                                    onPressed: () => Navigator.of(context).pop(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                    );
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      person.profileImg != null && person.profileImg!.isNotEmpty ? NetworkImage(person.profileImg!) : null,
                                  backgroundColor: Colors.white24,
                                  child:
                                      (person.profileImg == null || person.profileImg!.isEmpty)
                                          ? const Icon(Icons.person, size: 50, color: Colors.white)
                                          : null,
                                ),
                              ),

                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      person.name ?? '-',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelLarge?.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      person.relation ?? '-',
                                      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white70),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      person.primaryMember != null && person.primaryMember!.toLowerCase() == 'yes'
                                          ? 'Primary Member'
                                          : 'Member',
                                      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white70, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // _buildInfoRow('Member ID', person.memberId),
                                  // _buildInfoRow('Relative ID', person.relativeId),
                                  // _buildInfoRow('Under ID', person.underId),
                                  _buildInfoRow('Relation', person.relation),
                                  _buildInfoRow('Profession', person.profession),
                                  _buildInfoRow('Age', person.age),
                                  _buildInfoRow('Date of Birth', _formatDob(person.dOB!.toIso8601String())),
                                  _buildInfoRow('Mobile', person.moblieNo),
                                  _buildInfoRow('Email', person.email),
                                  _buildInfoRow('Address', person.address),
                                  // _buildInfoRow('Created At', person.createdAt),
                                  _buildInfoRow('Status', person.status == '1' ? 'Active' : 'Inactive'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
