import 'package:quran_app/features/quran/domain/entities/ayah.dart';
import 'package:quran_app/features/quran/domain/entities/bookmark.dart';
import 'package:quran_app/features/quran/domain/entities/surah.dart';

typedef SurahView = Surah;
typedef BookmarkView = Bookmark;

final class SurahDetailView {
  const SurahDetailView({required this.surah, required this.ayahs});
  final Surah surah;
  final List<Ayah> ayahs;
}
