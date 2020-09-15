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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildTabletLayout();
  }

  DefaultTabController buildPhoneLayout() {
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
        appBar: AppBar(
          title: Icon(Icons.fastfood),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white,),
              onPressed: () {
                Navigator.pushNamed(context, '/billing');
              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 40,
              child: TabBar(
                indicatorWeight: 3,
                indicatorColor: aRed,
                isScrollable: true,
                labelColor: aRed,
                unselectedLabelColor: aLightTextColor,
                onTap: (index) => generateMenu(index),
                tabs: foodCategories.map((item) {
                  return Tab(
                    child: Text(item,),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: foodCategories.map((item) {
                  return Container(
                    height: double.infinity,
                    color: aBackgroundColor,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: aPadding),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: aPadding),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(item, style: aHeader2Style,),
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
                          ),
                          SizedBox(height: aPadding,),
                          GridView(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: aPadding, left: aPadding, right: aPadding),
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.8,
                              crossAxisSpacing: aPadding,
                              crossAxisCount: 2,
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
    );
  }

  Widget buildTabletLayout() {
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
                  child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: foodCategories.map((item) {
                        return Container(
                          height: double.infinity,
                          color: aBackgroundColor,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: aLargerPadding),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(item, style: aHeader2Style,),
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
                                SizedBox(height: aPadding,),
                                GridView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.6,
                                    crossAxisSpacing: aLargerPadding,
                                    crossAxisCount: 4,
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
              ),
              AnyBilling(),
            ],
          ),
        ),
      ),
    );
  }
}
