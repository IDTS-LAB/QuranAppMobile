import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/app/theme/app_colors.dart';
import 'package:quran_app/app/theme/app_typography.dart';

class HomePageHeader extends ConsumerWidget {
  const HomePageHeader({super.key, required this.name, this.profilePhoto});

  final String name;
  final String? profilePhoto;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assalamu Alaikum,",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: AppTypography.titleMedium.fontSize,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                color: AppColors.nobleGreen,
                fontSize: AppTypography.headlineLarge.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Monday, 23 Oct • 8 Rabi' al-Thani",
              style: TextStyle(
                color: AppColors.nobleGold,
                fontWeight: .bold,
                fontSize: AppTypography.titleMedium.fontSize,
              ),
            ),
          ],
        ),
        CircleAvatar(
          child: Text(profilePhoto == null ? name[0] : profilePhoto!),
        ),
      ],
    );
  }
}
