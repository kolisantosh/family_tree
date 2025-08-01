import 'package:family_tree/configs/routes/routes_name.dart';
import 'package:family_tree/configs/themes/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graphview/GraphView.dart';

import '../../bloc/tree_bloc/tree_bloc.dart';
import '../../data/response/status.dart';
import '../../dependency_injection/locator.dart';
import '../../model/tree_list/tree_list_model.dart';
import '../member/widget/error_widget.dart';

class TreeView extends StatefulWidget {
  final String relativeId;
  const TreeView(this.relativeId, {super.key});

  @override
  State<TreeView> createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  late TreeBloc treeBloc;
  final Graph graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  var noPrimaryMember = false;
  final Set<String> mainNodeIds = {};
  final Map<String, Node> nodeMap = {};
  Map<String, Datut> memberDataMap = {};

  @override
  void initState() {
    super.initState();
    treeBloc = TreeBloc(treeApiRepository: getIt());
    treeBloc.add(TreeFetch(relationId: widget.relativeId));

    builder
      ..siblingSeparation = 10
      ..levelSeparation = 15
      ..subtreeSeparation = 15
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  @override
  void dispose() {
    treeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider.value(
          value: treeBloc,
          child: BlocBuilder<TreeBloc, TreeState>(
            buildWhen: (previous, current) => previous.treeList != current.treeList,
            builder: (context, state) {
              switch (state.treeList.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());

                case Status.error:
                  return const MemberErrorWidget();

                case Status.completed:
                  if (state.treeList.data == null) {
                    return Center(child: Text(AppLocalizations.of(context)!.noDataFound));
                  }

                  final treeList = state.treeList.data!.data ?? [];
                  if (treeList.isEmpty) {
                    return Center(child: Text(AppLocalizations.of(context)!.noDataFound));
                  }

                  // Build the graph
                  buildGraphFromTreeList(treeList);

                  return noPrimaryMember
                      ? Center(child: Text(AppLocalizations.of(context)!.noDataFound))
                      : InteractiveViewer(
                        constrained: false,
                        boundaryMargin: EdgeInsets.zero,
                        minScale: 0.001,
                        // maxScale: 5.5,
                        child: Stack(
                          children: [
                            // Background world map image; public domain / Wikimedia example
                            Positioned.fill(
                              child: Opacity(
                                opacity: 0.3, // 0.0 = fully transparent, 1.0 = fully opaque
                                child: Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/World_map_-_low_resolution.svg/1200px-World_map_-_low_resolution.svg.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            GraphView(
                              graph: graph,
                              algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                              paint:
                                  Paint()
                                    ..color = Colors.green
                                    ..strokeWidth = 1
                                    ..style = PaintingStyle.stroke,
                              builder: (Node node) {
                                print(node);
                                final memberId = node.key?.value;
                                final datut = memberDataMap[memberId];
                                // if (datut == null) {
                                //   final datut = memberDataMap[mainNodeIds.first];
                                //   return rectangleWidget(memberId, name: datut!.name!, imageUrl: datut.profileImg!);
                                // }
                                // return rectangleWidget(memberId, name: datut.name!, imageUrl: datut.profileImg!);

                                return datut == null
                                    ? rectangleWidget(memberId)
                                    : rectangleWidget(memberId, name: datut.name!, imageUrl: datut.profileImg!);
                              },
                            ),
                          ],
                        ),
                      );
              }
            },
          ),
        ),
      ),
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
    );
  }

  // 1. Add this to your _TreeViewState
  Future<void> buildGraphFromTreeList(List<Datut> treeList) async {
    graph.nodes.clear();
    graph.edges.clear();
    memberDataMap.clear();

    final Map<String, Node> nodeMap = {};
    String? rootMemberId;

    // Step 1: Map all members and find the root (primary_member)
    for (final item in treeList) {
      if (item.memberId != null) {
        memberDataMap[item.memberId!] = item;
        nodeMap.putIfAbsent(item.memberId!, () => Node.Id(item.memberId));

        if (item.primaryMember! == PrimaryMember.YES) {
          rootMemberId = item.memberId;
        }
      }

      // Also map children if any
      if (item.children != null) {
        for (final child in item.children!) {
          if (child.memberId != null) {
            memberDataMap[child.memberId!] = child;
            nodeMap.putIfAbsent(child.memberId!, () => Node.Id(child.memberId));
          }
        }
      }
    }

    // Safety check
    if (rootMemberId == null) {
      print('No primary member found.');
      setState(() {
        noPrimaryMember = true;
      });
      return;
    }

    // Step 2: Build graph recursively
    void addEdgesRecursively(Datut parent) {
      final parentId = parent.memberId;
      if (parentId == null || !nodeMap.containsKey(parentId)) return;

      // Children in nested `children` list
      if (parent.children != null) {
        for (final child in parent.children!) {
          if (child.memberId == null) continue;
          graph.addEdge(nodeMap[parentId]!, nodeMap[child.memberId!]!);
          addEdgesRecursively(child);
        }
      }

      // Children in flat list where under_id == parentId
      for (final entry in memberDataMap.entries) {
        final member = entry.value;
        if (member.underId == parentId && member.memberId != parentId) {
          graph.addEdge(nodeMap[parentId]!, nodeMap[member.memberId!]!);
          addEdgesRecursively(member);
        }
      }
    }

    // Start building from root
    final root = memberDataMap[rootMemberId];
    if (root != null) {
      // addEdgesRecursively(root);

      for (final parent in treeList) {
        final parentId = parent.memberId;
        if (parentId == null || !nodeMap.containsKey(parentId)) return;

        // Children in nested `children` list
        if (parent.children != null) {
          for (final child in parent.children!) {
            if (child.memberId == null) continue;
            graph.addEdge(nodeMap[parentId]!, nodeMap[child.memberId!]!);
            addEdgesRecursively(child);
          }
        }

        // Children in flat list where under_id == parentId
        for (final entry in memberDataMap.entries) {
          final member = entry.value;
          if (member.underId == parentId && member.memberId != parentId) {
            graph.addEdge(nodeMap[parentId]!, nodeMap[member.memberId!]!);
            addEdgesRecursively(member);
          }
        }
      }
    }
  }

  Widget rectangleWidget(String? memberId, {String? name, String? imageUrl}) {
    final isMain = memberId != null && mainNodeIds.contains(memberId);

    return InkWell(
      onTap: () {
        print('Clicked node: $memberId');
        Navigator.pushNamed(context, RoutesName.person_details, arguments: memberId);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: (imageUrl != null) ? null : BoxDecoration(color: ThemeConfig.primaryColor, borderRadius: BorderRadius.circular(4)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (imageUrl != null) ...[
              Container(
                width: 44, // image 40 + border padding
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ThemeConfig.primaryColor, // or whatever color you want
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
            Text(
              name ?? '$memberId',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                shadows: [
                  Shadow(
                    offset: Offset(1.5, 1.5), // horizontal & vertical shadow offset
                    blurRadius: 3.0, // how blurry the shadow is
                    color: Colors.white.withOpacity(0.4), // shadow color with opacity
                  ),
                ],
                color: isMain ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
