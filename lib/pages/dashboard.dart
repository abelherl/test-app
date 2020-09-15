import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:test_app/components/any_billing.dart';
import 'package:test_app/components/any_menu_grid.dart';
import 'package:test_app/const.dart';
import 'package:test_app/models/any_menu_item.dart';
import 'package:test_app/services/data_dummy.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var selectedIndex = 0;
  var selectedCategoryMenu = dummyMenu;
  bool gridLayout = true;

  int getCrossAxisCount() {
    final width = MediaQuery.of(context).size.width;
    var crossAxisAmount = 3;

    if (width >= 700) {
      crossAxisAmount = 4;
    }
    if (width >= 1000) {
      crossAxisAmount = 5;
    }

    return crossAxisAmount;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildTabletLayout();
  }

  Widget buildTabletLayout() {
    void generateMenu(int index) {
      setState(() {
        selectedIndex = index;

        print(gridLayout);

        var menu = dummyMenu;
        if (index != 0) {
          menu = dummyMenu.where((item) => item.category == foodCategories[index].toLowerCase()).toList();
          print('$index $menu');
        }

        setState(() => selectedCategoryMenu = menu);
      });
    }

    return DefaultTabController(
      length: foodCategories.length,
      child: Scaffold(
        backgroundColor: aBackgroundColor,
        body: SafeArea(
          child: Row(
            children: [
              Container(
                width: 80,
                color: Colors.white,
              ),
              Expanded(
                child: Container(
                  color: aBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: aLargerPadding),
                        height: 115,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TabBar(
                              indicatorWeight: 3,
                              indicatorColor: aRed,
                              isScrollable: true,
                              labelColor: aRed,
                              unselectedLabelColor: aLightTextColor,
                              onTap: (index) => generateMenu(index),
                              tabs: foodCategories.map((item) {
                                return Tab(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: aPadding),
                                    child: Text(item,),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: aPadding,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(foodCategories[selectedIndex], style: aHeader2Style,),
                                Spacer(),
                                IconButton(
                                  onPressed: () => setState(() => gridLayout = true),
                                  icon: Icon(Icons.apps),
                                  color: gridLayout ? aRed : aLightTextColor,
                                ),
                                IconButton(
                                  onPressed: () => setState(() => gridLayout = false),
                                  icon: Icon(Icons.view_list),
                                  color: !gridLayout ? aRed : aLightTextColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: foodCategories.map((item) {
                              return Container(
                                height: double.infinity,
                                color: aBackgroundColor,
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      GridView(
                                        padding: EdgeInsets.symmetric(horizontal: aLargerPadding),
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.6,
                                          crossAxisSpacing: aLargerPadding,
                                          crossAxisCount: getCrossAxisCount(),
                                        ),
                                        children: selectedCategoryMenu.map((item) {
                                          return AnyMenuGrid(item: item);
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnyBilling(),
            ],
          ),
        ),
      ),
    );
  }
}
