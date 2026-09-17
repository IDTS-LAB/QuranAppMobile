import '../../domain/entities/ayah.dart';
import '../../domain/entities/bookmark.dart';
import '../../domain/entities/surah.dart';

typedef SurahView = Surah;
typedef BookmarkView = Bookmark;

final class SurahDetailView {
  const SurahDetailView({required this.surah, required this.ayahs});
  final Surah surah;
  final List<Ayah> ayahs;
}
