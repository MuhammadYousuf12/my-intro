import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../models/profile_model.dart';
import '../../widgets/contact_tile.dart';

// Contact tab - email, phone, LinkedIn with deep links
class ContactTab extends StatelessWidget {
  final ContactModel contact;
  final List<Color> gradient;
  const ContactTab({super.key, required this.contact, required this.gradient});

  Future<void> _launch(String url, BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      // }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open link.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    final horizontalPad = isLandscape ? size.width * 0.12 : 20.0;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPad,
                MediaQuery.of(context).padding.top + 60,
                horizontalPad,
                100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Feel free to reach out.',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  ContactTile(
                    icon: Icons.mail_rounded,
                    label: 'Email',
                    value: contact.email,
                    gradient: gradient,
                    onTap: () => _launch('mailto:${contact.email}', context),
                  ),
                  const SizedBox(height: 14),

                  ContactTile(
                    icon: Icons.phone_rounded,
                    label: 'Phone',
                    value: contact.phone,
                    gradient: gradient,
                    onTap: () => _launch('tel:${contact.phone}', context),
                  ),
                  const SizedBox(height: 14),

                  ContactTile(
                    icon: Icons.link_rounded,
                    label: 'LinkedIn',
                    value: 'muhammadyousufsorathia',
                    gradient: gradient,
                    onTap: () => _launch(contact.linkedin, context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
