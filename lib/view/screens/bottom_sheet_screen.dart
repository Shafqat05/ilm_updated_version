import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilm_updated_version/view/screens/searchbook_screen/advance_searchbook_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../global/app_colors.dart';
import '../../global/streamsObjects.dart';
import 'book_mark_screen/book_mark_screen.dart';
import 'bookbycatid_screen/bookbycatid_screen.dart';
import 'booksubslist_screen/booksubslist_screen.dart';
import 'category_book_screen/category_book_screen.dart';
import 'edit_profile/edit_profile_screen.dart';

bool goBack = true;

class BottomSheetScreen extends StatelessWidget {
  BottomSheetScreen({Key? key}) : super(key: key);

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    showExitPopup(BuildContext context) {
      return showDialog(

          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                content: Container(
                 // height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/iconcircle.png',
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.16,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      Text(
                        'ARE YOU SURE TO EXIT FROM APP?'.tr,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.038, fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.21,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: AppColors.allButtonColor),
                                  child: Center(
                                      child: Text(
                                    'NO'.tr,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.04),
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pop(true);
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSingupPage()));
                                  SystemNavigator.pop();
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.21,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: AppColors.allButtonColor),
                                  child: Center(
                                      child: Text(
                                    'YES'.tr,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.04),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                    ],
                  ),
                ),
              ));
      //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: () async {
        if (goBack) {
          print('Now showing dialog');
          showExitPopup(context);
          return false;
        } else {
          return true;
        }
      },
      child: PersistentTabView(
        context,
        controller: _controller,
        selectedTabScreenContext: (context) {},

        screens: _buildScreens(),
        items: _navBarsItems(),

        confineInSafeArea: true,
        backgroundColor: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor : AppColors.blackColor, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.

        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          // curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          // curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.simple,
        onItemSelected: (v) {
          print('selected index is = $v');
          active_tab_controller.add(v);
          if (v == 0 && !goBack) {
            goBack = true;
            print('Now showing dialog');
            //showExitPopup(context);
          } else {
            goBack = false;
          }
        },
        // Choose the nav bar style with this property.
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      CategoryHomeBookScreen(),
      AdvanceSearchBookScreen(),
      BookSubsListScreen(),
      BookMarkScreen(),
      EditProfileScreen(),
      // CategoryHomeBookScreen(),
      // AdvanceSearchBookScreen(),
      // MyBookSubsScreen(),
      // BookMarkScreen(),
      // ProfileScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        //title: ("Home"),
        activeColorPrimary: AppColors.allButtonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        //title: (""),
        activeColorPrimary: AppColors.allButtonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.auto_stories),
        // title: ("Home"),
        activeColorPrimary: AppColors.allButtonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.bookmark),

        // title: ("Settings"),
        activeColorPrimary: AppColors.allButtonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        // title: ("Home"),
        activeColorPrimary: AppColors.allButtonColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
