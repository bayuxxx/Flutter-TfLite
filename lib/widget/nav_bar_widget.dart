import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:uas_ubay/color/colors.dart';
import 'package:uas_ubay/pages/kacamata_page.dart';
import 'package:uas_ubay/pages/home_page.dart';
import 'package:uas_ubay/pages/sayuran_page.dart';
import 'package:uas_ubay/pages/profil_page.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({
    super.key,
    required PageController pageControlller,  
    required PageController pageController,
  }) : _pageControlller = pageControlller;

  final PageController _pageControlller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageControlller,
        children: const[
          HomePage(),
          KacamataPage(),
          SayuranPage(),
          ProfilPage(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        color: Colors.white,
        controller: _pageControlller,
        flat: true,
        useActiveColorByDefault: false,
        items: [
          RollingBottomBarItem(Icons.home,
              label: 'Home', activeColor: Warna.merah),
          RollingBottomBarItem(Icons.camera,
              label: 'Sunglass', activeColor: Warna.merah),
          RollingBottomBarItem(Icons.camera,
              label: 'Vegan', activeColor: Warna.merah),
          RollingBottomBarItem(Icons.person,
              label: 'Profile', activeColor: Warna.merah),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _pageControlller.animateToPage(
            index,
            duration: const Duration(seconds: 2),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
