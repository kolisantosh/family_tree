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

  final Set<String> mainNodeIds = {};
  final Map<String, Node> nodeMap = {};
  final Set<String> visited = {};

  @override
  void initState() {
    super.initState();
    treeBloc = TreeBloc(treeApiRepository: getIt());
    treeBloc.add(TreeFetch(relationId: widget.relativeId));

    builder
      ..siblingSeparation = 100
      ..levelSeparation = 150
      ..subtreeSeparation = 150
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT;
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

                  return InteractiveViewer(
                    constrained: false,
                    boundaryMargin: const EdgeInsets.all(100),
                    minScale: 0.01,
                    maxScale: 5.6,
                    child: GraphView(
                      graph: graph,
                      algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                      paint:
                          Paint()
                            ..color = Colors.green
                            ..strokeWidth = 1
                            ..style = PaintingStyle.stroke,
                      builder: (Node node) {
                        final memberId = node.key?.value;
                        return rectangleWidget(memberId);
                      },
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> buildGraphFromTreeList(List<Datut> treeList) async {
    graph.nodes.clear();
    graph.edges.clear();

    final Map<String, Node> nodeMap = {};
    final Set<String> mainNodeIds = {};

    // 1. Create unique nodes
    for (final item in treeList) {
      if (item.memberId != null) {
        nodeMap.putIfAbsent(item.memberId!, () => Node.Id(item.memberId));
        if (item.primaryMember == 'yes') {
          mainNodeIds.add(item.memberId!);
        }
      }
      if (item.relativeId != null) {
        nodeMap.putIfAbsent(item.relativeId!, () => Node.Id(item.relativeId));
      }
    }

    // 2. Add edges from relativeId → memberId
    for (final item in treeList) {
      final parentId = item.primaryMember == 'yes' ? item.memberId : item.relativeId;
      final memberId = item.memberId;

      if (parentId != null && memberId != null && parentId != memberId && nodeMap.containsKey(parentId) && nodeMap.containsKey(memberId)) {
        graph.addEdge(nodeMap[parentId]!, nodeMap[memberId]!);
      }

      // 3. Add children edges if present
      if (item.children != null && item.children!.isNotEmpty) {
        for (final child in item.children!) {
          if (child.memberId == null) continue;

          nodeMap.putIfAbsent(child.memberId!, () => Node.Id(child.memberId));
          if (memberId != null && nodeMap.containsKey(memberId)) {
            graph.addEdge(nodeMap[memberId]!, nodeMap[child.memberId!]!);
          }
        }
      }
    }

    // You now have mainNodeIds and a fully connected graph.
  }

  Widget rectangleWidget(String? memberId) {
    final isMain = memberId != null && mainNodeIds.contains(memberId);

    return InkWell(
      onTap: () {
        print('Clicked node: $memberId');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [BoxShadow(color: isMain ? Colors.red : Colors.blue, spreadRadius: 1)],
        ),
        child: Text(
          'Node $memberId',
          style: TextStyle(fontWeight: isMain ? FontWeight.bold : FontWeight.normal, color: isMain ? Colors.red : Colors.black),
        ),
      ),
    );
  }
}
