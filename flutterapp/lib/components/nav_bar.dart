import 'package:flutter/material.dart';
import 'package:flutterapp/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
            spreadRadius: 5.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 10.0,
        ),
        child: Row(
          children: [
            const Text(
              'アニメデータ',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'NotoSansJP',
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            const Expanded(
              child: SizedBox(
                width: 50,
              ),
            ),
            GNav(
              backgroundColor: Colors.black,
              rippleColor:
                  Colors.grey[800]!, // tab button ripple color when pressed
              hoverColor: Colors.grey[700]!, // tab button hover color
              haptic: true, // haptic feedback
              // tabBorderRadius: 15,
              // tabActiveBorder:
              //     Border.all(color: Colors.white, width: 2), // tab button border
              // tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
              // tabShadow: [
              //   BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
              // ], // tab button shadow
              curve: Curves.ease, // tab animation curves
              duration: Duration(milliseconds: 900), // tab animation duration
              gap: 10, // the tab button gap between icon and text
              color: Colors.white, // unselected icon color
              activeColor: spiritedAwayGreen, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor:
                  Colors.transparent, // selected tab background color
              padding: const EdgeInsets.symmetric(
                  horizontal: 50), // navigation bar padding
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.edit_outlined,
                  text: 'Modify',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
