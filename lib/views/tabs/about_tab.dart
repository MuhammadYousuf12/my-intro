import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/profile_model.dart';
import '../../widgets/chip_wrap.dart';
import '../../widgets/info_card.dart';
import '../../widgets/info_row.dart';

// About tab - personal introduction, responsive for all screen sizes
class AboutTab extends StatelessWidget {
  final ProfileModel profile;
  final List<Color> gradient;
  const AboutTab({super.key, required this.profile, required this.gradient});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    final horizontalPad = isLandscape ? size.width * 0.12 : 20.0;
    final headerHeight = isLandscape ? 140.0 : 200.0;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          horizontalPad,
          MediaQuery.of(context).padding.top + 60,
          horizontalPad,
          100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card - responsive height
            Container(
              width: double.infinity,
              height: headerHeight,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          gradient[0].withValues(alpha: 0.6),
                          gradient[1].withValues(alpha: 0.75),
                        ]
                      : gradient,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: gradient[0].withValues(alpha: 0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: isLandscape
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _avatar(profile),
                        const SizedBox(width: 20),
                        _nameSection(profile),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _avatar(profile),
                        const SizedBox(height: 12),
                        _nameSection(profile),
                      ],
                    ),
            ),
            const SizedBox(height: 20),

            InfoCard(
              title: 'Skills',
              icon: Icons.code_rounded,
              iconColor: gradient[0],
              child: ChipWrap(text: profile.skills, color: gradient[0]),
            ),

            InfoCard(
              title: 'Future Goals',
              icon: Icons.flag_rounded,
              iconColor: gradient[0],
              child: Text(
                profile.futureGoals,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.7,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ),

            InfoCard(
              title: 'Thanks for this Internship',
              icon: Icons.favorite_rounded,
              iconColor: gradient[0],
              child: Text(
                profile.gratitude,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.7,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ),

            InfoCard(
              title: 'Academic Background',
              icon: Icons.school_rounded,
              iconColor: gradient[0],
              child: Column(
                children: [
                  InfoRow(label: 'Degree', value: profile.degree),
                  InfoRow(label: 'Institute', value: profile.university),
                ],
              ),
            ),

            InfoCard(
              title: 'Hobbies & Interests',
              icon: Icons.interests_rounded,
              iconColor: gradient[0],
              child: ChipWrap(text: profile.hobbies, color: gradient[0]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatar(ProfileModel profile) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.2),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
          width: 3,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/profile_image.jpg',
          fit: BoxFit.cover,

          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.white.withValues(alpha: 0.3),
              child: Center(
                child: Text(
                  profile.name.isNotEmpty ? profile.name[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _nameSection(ProfileModel profile) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          profile.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
