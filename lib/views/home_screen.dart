import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tabs/about_tab.dart';
import 'tabs/projects_tab.dart';
import 'tabs/contact_tab.dart';
import '../providers/theme_provider.dart';
import '../core/constants/app_colors.dart';
import '../models/profile_model.dart';

class HomeScreen extends StatefulWidget {
  final ProfileModel profile;
  const HomeScreen({super.key, required this.profile});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<List<Color>> _gradients = const [
    AppColors.aboutGradient,
    AppColors.projectsGradient,
    AppColors.contactGradient,
  ];

  final List<_NavItem> _navItems = const [
    _NavItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'About',
    ),
    _NavItem(
      icon: Icons.rocket_launch_outlined,
      activeIcon: Icons.rocket_launch_rounded,
      label: 'Projects',
    ),
    _NavItem(
      icon: Icons.mail_outline_rounded,
      activeIcon: Icons.mail_rounded,
      label: 'Contact',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeGradient = _gradients[_currentIndex];
    final tabs = [
      AboutTab(profile: widget.profile, gradient: _gradients[0]),
      ProjectsTab(projects: widget.profile.projects, gradient: _gradients[1]),
      ContactTab(contact: widget.profile.contact, gradient: _gradients[2]),
    ];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Gradient background
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  activeGradient[0].withValues(alpha: isDark ? 0.25 : 0.12),
                  activeGradient[1].withValues(alpha: isDark ? 0.08 : 0.04),
                  isDark ? AppColors.darkBg : AppColors.lightBg,
                ],
                stops: const [0.0, 0.25, 0.6],
              ),
            ),
          ),

          // Top-right blob
          Positioned(
            top: -80,
            right: -80,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    activeGradient[0].withValues(alpha: 0.4),
                    activeGradient[0].withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),

          // Bottom-left blob
          Positioned(
            bottom: 80,
            left: -60,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    activeGradient[1].withValues(alpha: 0.3),
                    activeGradient[1].withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),

          // Tab content
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0.05, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOut),
                    ),
                child: child,
              ),
            ),
            child: KeyedSubtree(
              key: ValueKey(_currentIndex),
              child: tabs[_currentIndex],
            ),
          ),

          // Theme toggle button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 16,
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return GestureDetector(
                  onTap: () => themeProvider.setTheme(
                    isDark ? ThemeMode.light : ThemeMode.dark,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: activeGradient[0].withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      isDark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Modern floating nav bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: 68,
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurface.withValues(alpha: 0.95)
                : Colors.white.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: activeGradient[0].withValues(alpha: 0.3),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_navItems.length, (index) {
              final item = _navItems[index];
              final isActive = _currentIndex == index;
              final color = _gradients[index][0];

              return GestureDetector(
                onTap: () => _onNavTap(index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: isActive ? 20 : 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: isActive
                        ? LinearGradient(
                            colors: [
                              color.withValues(alpha: 0.18),
                              color.withValues(alpha: 0.08),
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1.0, end: isActive ? 1.3 : 1.0),
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.elasticOut,
                        builder: (context, scale, _) {
                          return Transform.scale(
                            scale: scale,
                            child: Icon(
                              isActive ? item.activeIcon : item.icon,
                              color: isActive
                                  ? color
                                  : (isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary),
                              size: 22,
                            ),
                          );
                        },
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: isActive
                            ? Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Text(
                                    item.label,
                                    style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
