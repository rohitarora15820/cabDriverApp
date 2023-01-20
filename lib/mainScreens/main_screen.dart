import 'package:cabapp/tabPages/earning_tab.dart';
import 'package:cabapp/tabPages/home_tab.dart';
import 'package:cabapp/tabPages/profile_tab.dart';
import 'package:cabapp/tabPages/ratings_tab.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int selectedTab = 0;
  onItemClicked(int index) {
    setState(() {
      selectedTab = index;
      _tabController!.index = selectedTab;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          HomeTabScreen(),
          EarningTabScreen(),
          RatingTabScreen(),
          ProfileTabScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.credit_card), label: 'Earnings'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Rating'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
          unselectedItemColor: Colors.white54,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedTab,
          selectedLabelStyle: TextStyle(fontSize: 14),
          showUnselectedLabels: true,
          onTap: onItemClicked),
    );
  }
}
