import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'dart:convert';

class AnimeModel {
  final String title;
  final String coverUrl;
  final String videoUrl;

  AnimeModel({required this.title, required this.coverUrl, required this.videoUrl});
}

class AnimeScraper {
  // دالة جلب البيانات الحية من الموقع برمجياً
  Future<List<AnimeModel>> scrapeLatestAnime() async {
    List<AnimeModel> loadedAnime = [];
    
    try {
      // 1. إرسال طلب للموقع لأخذ كود الـ HTML (استبدل الرابط بموقع الأنمي الخاص بك)
      final response = await http.get(Uri.parse('https://example-anime-site.com/latest-updates'));

      if (response.statusCode == 200) {
        // 2. تفكيك الكود وقراءته برمجياً
        var document = parser.parse(response.body);
        
        // 3. استهداف عناصر الأنمي بناءً على الكلاسات الخاصة بالموقع (تتغير حسب تصميم كل موقع)
        var animeCards = document.querySelectorAll('.anime-card');

        for (var card in animeCards) {
          String title = card.querySelector('.anime-title')?.text.trim() ?? 'أنمي غير معروف';
          String coverUrl = card.querySelector('img')?.attributes['src'] ?? 'https://via.placeholder.com/150';
          
          // استخراج رابط صفحة المشاهدة أو رابط الـ iframe مباشرة
          String videoPageUrl = card.querySelector('a')?.attributes['href'] ?? '';

          loadedAnime.add(AnimeModel(
            title: title,
            coverUrl: coverUrl,
            videoUrl: videoPageUrl,
          ));
        }
      }
    } catch (e) {
      print("خطأ أثناء جلب البيانات: $e");
    }

    // إذا فشل السحب أو كان الموقع تجريبياً، يتم إرجاع بيانات احتياطية لكي لا يتوقف التطبيق
    if (loadedAnime.isEmpty) {
      loadedAnime = [
        AnimeModel(title: "One Piece", coverUrl: "https://images.unsplash.com/photo-1578632767115-351597cf2477?w=500", videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
        AnimeModel(title: "Attack on Titan", coverUrl: "https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?w=500", videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
        AnimeModel(title: "Demon Slayer", coverUrl: "https://images.unsplash.com/photo-1560169897-fc0cdbdfa4d5?w=500", videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"),
      ];
    }

    return loadedAnime;
  }
}
