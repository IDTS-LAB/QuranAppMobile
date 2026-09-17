import 'package:flutter/material.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/ayah.dart';

/// Tile for a single ayah.
///
/// Pure presentation: renders the [ayah] entity, reflects [bookmarked],
/// and forwards user actions via [onBookmark]. Reports visibility via
/// [onVisible] (fired once post-frame) so pages can persist the reading
/// position. No data access or business logic inside.
class AyahTile extends StatefulWidget {
  const AyahTile({
    super.key,
    required this.ayah,
    required this.bookmarked,
    required this.onBookmark,
    this.onVisible,
  });

  final Ayah ayah;
  final bool bookmarked;
  final VoidCallback onBookmark;
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              widget.ayah.arabicText,
              style: AppTypography.arabic,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
            if (widget.ayah.translation != null) ...<Widget>[
              const SizedBox(height: AppSpacing.sm),
              Text(widget.ayah.translation ?? ''),
            ],
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: <Widget>[
                Text('Ayah ${widget.ayah.numberInSurah}'),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    widget.bookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                  ),
                  tooltip: widget.bookmarked
                      ? 'Remove bookmark'
                      : 'Bookmark',
                  onPressed: widget.onBookmark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
