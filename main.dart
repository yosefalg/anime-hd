import 'dart:async';

// ==========================================
// 1. نموذج البيانات (Data Models)
// ==========================================

class VideoServer {
  final String serverName;
  final String videoUrl; // رابط البث المباشر (MP4 أو m3u8)
  final String quality;   // الجودة (1080p, 720p, 480p)

  VideoServer({
    required this.serverName,
    required this.videoUrl,
    required this.quality,
  });
}

class Episode {
  final int episodeNumber;
  final String uploadDate;
  final List<VideoServer> servers;

  Episode({
    required this.episodeNumber,
    required this.uploadDate,
    required this.servers,
  });
}

class Anime {
  final int id;
  final String title;
  final String coverUrl;
  final String genre;
  final double rating;
  final List<Episode> episodes;

  Anime({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.genre,
    required this.rating,
    required this.episodes,
  });
}

// ==========================================
// 2. محرك جلب الأكواد والبيانات (Scraping & API Simulator)
// ==========================================

class AnimeScraperEngine {
  // محاكاة جلب قاعدة بيانات كاملة للأنميات والحلقات من المواقع الكبرى برمجياً
  Future<List<Anime>> fetchAnimeDataFromWeb() async {
    // محاكاة تأخير الشبكة أثناء جلب البيانات (Network Delay)
    await Future.delayed(Duration(seconds: 2));

    return [
      Anime(
        id: 101,
        title: "One Piece",
        coverUrl: "https://animehd.com/covers/one_piece.jpg",
        genre: "أكشن، مغامرة، خيال",
        rating: 9.2,
        episodes: [
          Episode(
            episodeNumber: 1100,
            uploadDate: "2026-05-15",
            servers: [
              VideoServer(serverName: "Google Drive", videoUrl: "https://redirector.gvt1.com/videoplayback?id=op1100_1080p.mp4", quality: "1080p"),
              VideoServer(serverName: "Mega", videoUrl: "https://mega.nz/stream/op1100_720p.mp4", quality: "720p"),
              VideoServer(serverName: "Fembed", videoUrl: "https://fembed.com/v/op1100_480p.mp4", quality: "480p"),
            ],
          ),
          Episode(
            episodeNumber: 1101,
            uploadDate: "2026-05-20", // تاريخ رفع الحلقة اليوم
            servers: [
              VideoServer(serverName: "Google Drive", videoUrl: "https://redirector.gvt1.com/videoplayback?id=op1101_1080p.mp4", quality: "1080p"),
              VideoServer(serverName: "UpToStream", videoUrl: "https://uptostream.com/raw/op1101_720p.mp4", quality: "720p"),
            ],
          )
        ],
      ),
      Anime(
        id: 102,
        title: "Attack on Titan",
        coverUrl: "https://animehd.com/covers/aot.jpg",
        genre: "دراما، أكشن، خيال مظلم",
        rating: 9.5,
        episodes: [
          Episode(
            episodeNumber: 1,
            uploadDate: "2013-04-07",
            servers: [
              VideoServer(serverName: "Archive", videoUrl: "https://archive.org/download/aot_01/aot_01_1080p.mp4", quality: "1080p"),
              VideoServer(serverName: "MyCloud", videoUrl: "https://mycloud.to/v/aot_01_720p.mp4", quality: "720p"),
            ],
          )
        ],
      ),
    ];
  }
}

// ==========================================
// 3. مشغل الفيديو المتقدم ونظام التحكم (Video Player Manager)
// ==========================================

class VideoPlayerManager {
  // دالة لتشغيل الرابط المباشر المستخرج داخل التطبيق
  void initializeStreaming(VideoServer server, String animeTitle, int episodeNum) {
    print("\n[جاري تهيئة مشغل الفيديو الداخلي... 🎬]");
    print("🎬 تشغيل الآن: $animeTitle - الحلقة ($episodeNum)");
    print("🌐 السيرفر المختار: ${server.serverName} | الجودة: [${server.quality}]");
    print("🔗 رابط البth المباشر المُمرر للمشغل: \x1B[32m${server.videoUrl}\x1B[0m");
    print("[تم تشغيل الحلقة بنجاح وبدون إعلانات منبثقة! 🍿]");
  }
}

// ==========================================
// 4. نقطة الانطلاق وتشغيل النظام (Main Execution)
// ==========================================

void main() async {
  print("==================================================");
  print("🔥 بدء تشغيل نظام منصة Anime HD لجلب وبث الأنمي 🔥");
  print("==================================================");

  AnimeScraperEngine scraper = AnimeScraperEngine();
  VideoPlayerManager player = VideoPlayerManager();

  print("[1] جاري الاتصال بالمواقع وسحب الروابط برمجياً (Scraping)...");
  List<Anime> database = await scraper.fetchAnimeDataFromWeb();
  print("[تم] جلب البيانات بنجاح! عدد الأنميات المتوفرة حالياً في السيرفر: ${database.length}\n");

  // محاكاة مستخدم يتصفح التطبيق ويبحث عن أنمي "One Piece"
  String userSearch = "One Piece";
  print("🔍 مستخدم يبحث عن: '$userSearch'");

  try {
    // البحث في قاعدة البيانات المجلوبة
    Anime selectedAnime = database.firstWhere((anime) => anime.title.toLowerCase() == userSearch.toLowerCase());
    print("📍 تم العثور على: ${selectedAnime.title} | التصنيف: ${selectedAnime.genre} | التقييم: ⭐ ${selectedAnime.rating}");

    // اختيار الحلقة الأخيرة تلقائياً (مثلاً الحلقة 1101)
    Episode latestEpisode = selectedAnime.episodes.last;
    print("📺 الحلقة المتوفرة للمشاهدة فوراً: الحلقة رقم (${latestEpisode.episodeNumber}) المرفوعة بتاريخ: ${latestEpisode.uploadDate}");

    // تصفية السيرفرات واختيار سيرفر "Google Drive" بجودة "1080p" كخيار أول لأنه الأسرع للمستخدم
    print("\n🛠️ جاري تصفية سيرفرات البث وفحص الروابط الشغالة...");
    VideoServer bestServer = latestEpisode.servers.firstWhere(
      (server) => server.quality == "1080p" && server.serverName == "Google Drive",
      orElse: () => latestEpisode.servers.first, // إذا لم يجد، يأخذ أول سيرفر متاح
    );

    // تمرير الرابط المباشر المستخرج إلى مشغل الفيديو ليعمل فوراً
    player.initializeStreaming(bestServer, selectedAnime.title, latestEpisode.episodeNumber);

  } catch (e) {
    print("❌ عذراً، الأنمي المطلوب غير متوفر في محرك البحث حالياً.");
  }

  print("\n==================================================");
  print("🏁 تم إنهاء محاكاة النظام بنجاح وجاهز للربط بالواجهات");
  print("==================================================");
}
