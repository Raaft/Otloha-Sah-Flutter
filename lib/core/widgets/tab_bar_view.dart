import 'package:flutter/material.dart';

class TabBarViewApp extends StatefulWidget {
  const TabBarViewApp({
    Key? key,
    required this.countTap,
    required this.titles,
    required this.widgets,
  }) : super(key: key);

  final int countTap;
  final List<String> titles;
  final List<Widget> widgets;

  @override
  _TabBarViewAppState createState() => _TabBarViewAppState();
}

class _TabBarViewAppState extends State<TabBarViewApp>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.countTap,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: Colors.white,
              ),
              child: TabBar(
                tabs: [
                  ...widget.titles.map((title) => Tab(
                        text: title,
                      ))
                ],
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [...widget.widgets],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
