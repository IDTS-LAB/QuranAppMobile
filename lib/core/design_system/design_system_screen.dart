import 'package:flutter/material.dart';
import 'package:quran_app/core/widgets/typography/app_section_label.dart';

import '../../../app/theme/app_theme.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_spacing.dart';
import '../widgets/buttons/app_floating_action_button.dart';
import '../widgets/buttons/app_icon_button.dart';
import '../widgets/buttons/app_primary_button.dart';
import '../widgets/buttons/app_secondary_button.dart';
import '../widgets/cards/app_card.dart';
import '../widgets/indicators/app_badge.dart';
import '../widgets/indicators/app_circular_progress.dart';
import '../widgets/indicators/app_progress_bar.dart';

/// Noble Forest Design System Showcase Screen
///
/// This screen visually demonstrates the complete Noble Forest system.
/// Structure it similarly to the supplied reference.
class DesignSystemScreen extends StatelessWidget {
  const DesignSystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.light().scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Design System'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            // Desktop/tablet layout - multi-column
            return _buildDesktopLayout(context);
          } else {
            // Mobile layout - single column
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Left column - Principles and Colors
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.section),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBrandPrinciples(context),
                const SizedBox(height: AppSpacing.section),
                _buildColorPalette(context),
              ],
            ),
          ),
        ),
        // Right column - Typography, Components, Spacing & Shadows
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.section),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTypography(context),
                const SizedBox(height: AppSpacing.section),
                _buildCoreComponents(context),
                const SizedBox(height: AppSpacing.section),
                _buildSpacingAndShadows(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBrandPrinciples(context),
          const SizedBox(height: AppSpacing.lg),
          _buildColorPalette(context),
          const SizedBox(height: AppSpacing.lg),
          _buildTypography(context),
          const SizedBox(height: AppSpacing.lg),
          _buildCoreComponents(context),
          const SizedBox(height: AppSpacing.lg),
          _buildSpacingAndShadows(context),
        ],
      ),
    );
  }

  Widget _buildBrandPrinciples(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionLabel('BRAND PRINCIPLES'),
        const SizedBox(height: AppSpacing.md),
        _buildPrincipleCard(
          context,
          'Calm & Spiritual',
          'Prioritizing white space and natural tones to foster a meditative environment.',
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildPrincipleCard(
          context,
          'Respectful Focus',
          'The Quranic text is the anchor. UI never competes with scripture.',
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildPrincipleCard(
          context,
          'Trustworthy & Private',
          'No social feeds or generic tracking. Data is local and private by default.',
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildPrincipleCard(
          context,
          'Premium Modernity',
          'Subtle shadows and refined typography instead of flashy decorative elements.',
        ),
      ],
    );
  }

  Widget _buildPrincipleCard(
    BuildContext context,
    String title,
    String description,
  ) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.nobleGreen,
                    fontWeight: FontWeight.w600,
                  ) ??
                  Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPalette(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionLabel('COLOR PALETTE'),
        const SizedBox(height: AppSpacing.md),
        _buildColorSwatch(
          context,
          'Noble Green',
          '#1B4B32',
          AppColors.nobleGreen,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildColorSwatch(
          context,
          'Noble Gold',
          '#C1A461',
          AppColors.nobleGold,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildColorSwatch(
          context,
          'Canvas Background',
          '#FDFCF8',
          AppColors.canvas,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildColorSwatch(
          context,
          'Text Primary',
          '#2D3436',
          AppColors.textPrimary,
        ),
      ],
    );
  }

  Widget _buildColorSwatch(
    BuildContext context,
    String name,
    String hex,
    Color color,
  ) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    hex,
                    style:
                        Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: AppColors.textSecondary) ??
                        Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypography(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionLabel('TYPOGRAPHY'),
        const SizedBox(height: AppSpacing.md),
        const AppSectionLabel('LATIN INTERFACE'),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'IBM Plex Sans',
          style:
              Theme.of(context).textTheme.titleMedium
                  ?.copyWith(color: AppColors.nobleGreen) ??
              Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Clean, modern, and highly legible for interface elements, settings, and navigational labels.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        const AppSectionLabel('ARABIC SCRIPT'),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'IBM Plex Sans Arabic',
          style:
              Theme.of(context).textTheme.titleMedium
                  ?.copyWith(color: AppColors.nobleGreen) ??
              Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Elegant and balanced Arabic typography optimized for mobile screen reading.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildCoreComponents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionLabel('CORE COMPONENTS'),
        const SizedBox(height: AppSpacing.md),
        _buildComponentSection(context, 'CARDS & CONTAINERS', [
          _buildCardDemo(
            context,
            'Primary Card',
            '2rem / 32px rounded corners',
          ),
          const SizedBox(height: AppSpacing.md),
          _buildCardDemo(
            context,
            'Surface Container',
            '1rem / 16px rounded corners',
          ),
        ]),
        const SizedBox(height: AppSpacing.lg),
        _buildComponentSection(context, 'INTERACTION', [
          AppPrimaryButton(label: 'Primary Button', onPressed: () {}),
          const SizedBox(width: AppSpacing.md),
          AppSecondaryButton(label: 'Secondary Button', onPressed: () {}),
          const SizedBox(width: AppSpacing.md),
          AppIconButton(icon: const Icon(Icons.play_arrow), tooltip: 'Play'),
          const SizedBox(width: AppSpacing.md),
          AppFloatingActionButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () {},
          ),
        ]),
        const SizedBox(height: AppSpacing.lg),
        _buildComponentSection(context, 'PROGRESS & INDICATORS', [
          AppProgressBar(value: 0.65),
          const SizedBox(height: AppSpacing.md),
          AppCircularProgress(),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              AppBadge(label: 'tag', variant: AppBadgeVariant.tag),
              AppBadge(label: 'PREMIUM', variant: AppBadgeVariant.premium),
              AppBadge(label: 'success', variant: AppBadgeVariant.success),
              AppBadge(label: 'neutral', variant: AppBadgeVariant.neutral),
            ],
          ),
        ]),
      ],
    );
  }

  Widget _buildCardDemo(
    BuildContext context,
    String title,
    String description,
  ) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.nobleGreen,
                    fontWeight: FontWeight.w600,
                  ) ??
                  Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(description, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionLabel(title),
        const SizedBox(height: AppSpacing.md),
        ...children,
      ],
    );
  }

  Widget _buildSpacingAndShadows(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionLabel('SPACING & SHADOWS'),
        const SizedBox(height: AppSpacing.md),
        _buildSpacingDemo(context),
        const SizedBox(height: AppSpacing.lg),
        _buildShadowDemo(context),
      ],
    );
  }

  Widget _buildSpacingDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Base Unit: 8px', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            _buildSpacingBox('xs', AppSpacing.xs),
            _buildSpacingBox('sm', AppSpacing.sm),
            _buildSpacingBox('md', AppSpacing.md),
            _buildSpacingBox('lg', AppSpacing.lg),
            _buildSpacingBox('xl', AppSpacing.xl),
            _buildSpacingBox('xxl', AppSpacing.xxl),
            _buildSpacingBox('xxxl', AppSpacing.xxxl),
            _buildSpacingBox('section', AppSpacing.section),
          ],
        ),
      ],
    );
  }

  Widget _buildSpacingBox(String label, double size) {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(size),
        child: Text(
          label,
          style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
        ),
      ),
    );
  }

  Widget _buildShadowDemo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shadow SM — Subtle Depth',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          shadow: AppShadows.sm,
          child: Container(height: 40, color: AppColors.surface),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Shadow XL — Floating UI',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          shadow: AppShadows.xl,
          child: Container(height: 40, color: AppColors.surface),
        ),
      ],
    );
  }
}
