import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Layout extends StatefulWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        height: 80,
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
                    _buildNavItem(
                      icon: Icons.home_filled,
                      index: 0,
                      selectedIndex: selectedIndex,
                      onTap: () {
                        setState(() => selectedIndex = 0);
                        context.go('/home');
                      },
                    ),
                    _buildNavItem(
                      icon: Icons.history_rounded,
                      index: 1,
                      selectedIndex: selectedIndex,
                      onTap: () {
                        setState(() => selectedIndex = 1);
                        context.go('/ride-history');
                      },
                    ),
                    _buildNavItem(
                      icon: Icons.account_balance_wallet_rounded,
                      index: 2,
                      selectedIndex: selectedIndex,
                      onTap: () {
                        setState(() => selectedIndex = 2);
                        context.go('/payment');
                      },
                    ),
                    _buildNavItem(
                      icon: Icons.settings_rounded,
                      index: 3,
                      selectedIndex: selectedIndex,
                      onTap: () {
                        setState(() => selectedIndex = 3);
                        context.go('/settings');
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
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: isSelected 
                ? const Color(0xFF6A1B9A) 
                : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
          // Icon with background shading when selected
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected 
                ? const Color(0xFF6A1B9A).withOpacity(0.1)
                : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 24,
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

// Alternative standalone version
class ExactBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  
  const ExactBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<ExactBottomNavBar> createState() => _ExactBottomNavBarState();
}

class _ExactBottomNavBarState extends State<ExactBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
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
          )
        ],
      ),
      child: Stack(
        children: [
          // Purple bar at bottom
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 100,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF6A1B9A),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          // Navigation items
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navItem(Icons.home_filled, 0),
                _navItem(Icons.history, 1),
                _navItem(Icons.account_balance_wallet_outlined, 2),
                _navItem(Icons.settings_outlined, 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    final isSelected = widget.currentIndex == index;
    
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top dot indicator
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: isSelected 
                ? const Color(0xFF6A1B9A) 
                : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
          // Icon with background shading
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected 
                ? const Color(0xFF6A1B9A).withOpacity(0.12)
                : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 22,
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