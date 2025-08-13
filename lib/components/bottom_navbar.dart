import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tukugo/screen/drawer/profile_drawer.dart';
import 'package:tukugo/screen/drawer/wallet.dart';
import 'package:tukugo/screen/history_screen.dart';
import 'package:tukugo/screen/home_screen.dart';
import 'package:tukugo/screen/notification_screen.dart';
import 'package:tukugo/screen/drawer/wallet.dart';

class Layout extends StatefulWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentPage = 0;
  List<Widget> pages = [
    HomeScreen(),
    PaymentHistory(),
    MyWallet(),
    ProfileScreen(),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        height: 88,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Stack(
          children: [
            // Purple bar at the bottom center
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 100,
                height: 4,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6A1B9A),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Navigation items
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Home
                    _buildNavItem(
                      icon: Icons.home_rounded,
                      index: 0,
                      selectedIndex: selectedIndex,
                      onTap: () {
                        setState(() => selectedIndex = 0);
                        context.go('/home');
                      },
                    ),
                    // Profile
                    _buildNavItem(
                      icon: Icons.history,
                      index: 1,
                      selectedIndex: selectedIndex,
                      onTap: () {
                        setState(() => selectedIndex = 1);
                        context.go('/ride-history');
                      },
                    ),
                    // History
                    _buildNavItem(
                      icon: Icons.wallet,
                      index: 2,
                      selectedIndex: selectedIndex,
                      onTap: () {
                        setState(() => selectedIndex = 2);
                        context.go('/nav/wallet');
                      },
                    ),
                    // Notifications
                    _buildNavItem(
                      icon: Icons.settings,
                      index: 3,
                      selectedIndex: selectedIndex,
                      onTap: () {
                        setState(() => selectedIndex = 3);
                        context.go('/home/profile');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required int selectedIndex,
    required VoidCallback onTap,
  }) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dot indicator on top of selected icon
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF6A1B9A) : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
          // Icon with background shading when selected
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF6A1B9A).withOpacity(0.1)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 30,
              color: isSelected
                  ? const Color(0xFF6A1B9A)
                  : const Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }
}
