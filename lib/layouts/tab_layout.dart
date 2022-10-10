import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/stores/setting_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabLayout extends StatefulWidget {
  final List<IconData> tabs;
  final List<Widget> pages;

  const TabLayout({super.key, required this.tabs, required this.pages});

  @override
  State<StatefulWidget> createState() => _TabLayoutState();
}

class _TabLayoutState extends State<TabLayout> {
  final int _initialIndex = 0;
  late int _currentActiveIndex;

  @override
  void initState() {
    super.initState();
    setCurrentActiveIndex(_initialIndex);
    getIsScheduledSetting();
  }

  void setCurrentActiveIndex(int value) {
    setState(() {
      _currentActiveIndex = value;
    });
  }

  void getIsScheduledSetting() async {
    final setting = Provider.of<SettingStore>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isScheduled = prefs.getBool('isScheduled');
    if (kDebugMode) {
      print('Stored is scheduled: ${isScheduled! ? 'true' : 'false'}');
    }
    await setting.scheduledRecommendedRestaurant(isScheduled!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      initialIndex: _initialIndex,
      child: Scaffold(
        body: TabBarView(
          children: widget.pages,
        ),
        bottomNavigationBar: TabBar(
          isScrollable: false,
          indicatorColor: Colors.green,
          tabs: List.generate(
              widget.tabs.length,
                  (index) =>
                  Tab(
                    icon: Icon(widget.tabs[index],
                        color: index == _currentActiveIndex
                            ? Colors.green
                            : Colors.black12),
                  )),
          onTap: setCurrentActiveIndex,
        ),
      ),
    );
  }
}
