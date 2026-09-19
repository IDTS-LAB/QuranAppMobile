import 'package:flutter/material.dart';
import 'package:quran_app/core/widgets/typography/quran_text.dart';

import 'package:quran_app/app/theme/app_spacing.dart';
import 'package:quran_app/app/theme/app_typography.dart';
import 'package:quran_app/core/widgets/cards/app_card.dart';
import 'package:quran_app/core/widgets/buttons/app_icon_button.dart';
import 'package:quran_app/features/quran/domain/entities/ayah.dart';

/// Tile for a single ayah.
///
/// Pure presentation: renders the [ayah] entity, reflects [bookmarked],
/// and forwards user actions via [onBookmark]. Reports visibility via
/// [onVisible] (fired once post-frame) so pages can persist the reading
/// position. No data access or business logic inside.
///
/// Padding comes from [AppCard] (no double-wrapping); long translations
/// wrap naturally; the footer row keeps the bookmark action reachable.
class AyahTile extends StatefulWidget {
  /// Creates an ayah tile.
  const AyahTile({
    super.key,
    required this.ayah,
    required this.bookmarked,
    required this.onBookmark,
    this.onVisible,
  });

  /// Ayah entity to render.
  final Ayah ayah;

  /// Whether the ayah is bookmarked.
  final bool bookmarked;

  /// Bookmark toggle handler.
  final VoidCallback onBookmark;

  /// Visibility callback for reading-position persistence.
  final ValueChanged<Ayah>? onVisible;

  @override
  State<AyahTile> createState() => _AyahTileState();
}

class _AyahTileState extends State<AyahTile> {
  @override
  void initState() {
    super.initState();
    final ValueChanged<Ayah>? onVisible = widget.onVisible;
    if (onVisible != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          onVisible(widget.ayah);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          QuranText(
            text: widget.ayah.arabicText,
            size: QuranTextSize.medium,
            textAlign: TextAlign.right,
          ),
          if (widget.ayah.translation != null) ...<Widget>[
            const SizedBox(height: AppSpacing.sm),
            Text(
              widget.ayah.translation ?? '',
              style: AppTypography.bodyMedium,
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  'Ayah ${widget.ayah.numberInSurah}',
                  style: AppTypography.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              AppIconButton(
                icon: Icon(
                  widget.bookmarked ? Icons.bookmark : Icons.bookmark_outline,
                ),
                tooltip: widget.bookmarked ? 'Remove bookmark' : 'Bookmark',
                onPressed: widget.onBookmark,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
