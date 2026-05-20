import 'package:flutter/material.dart';
import 'dart:async';

// ==========================================
// 1. النواة البرمجية ونموذج البيانات
// ==========================================

class VideoServer {
  final String serverName;
  final String videoUrl;
  final String quality;

  VideoServer({required this.serverName, required this.videoUrl, required this.quality});
}

class Episode {
  final int episodeNumber;
  final List<VideoServer> servers;

  Episode({required this.episodeNumber, required this.servers});
}

class AnimeData {
  final String title;
  final String coverUrl;
  final String genre;
  final double rating;
  final List<Episode> episodes;

  AnimeData({
    required this.title, 
    required this.coverUrl, 
    required this.genre, 
    required this.rating, 
    required this.episodes
  });
}

// ==========================================
// 2. نقطة تشغيل التطبيق (Flutter Entry Point)
// ==========================================

void main() => runApp(AnimeHDApp());

class AnimeHDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // الثيم السينمائي المظلم
      home: AnimeHomeScreen(),
    );
  }
}

// ==========================================
// 3. واجهة المستخدم التفاعلية (UI)
// ==========================================

class AnimeHomeScreen extends StatefulWidget {
  @override
  _AnimeHomeScreenState createState() => _AnimeHomeScreenState();
}

class _AnimeHomeScreenState extends State<AnimeHomeScreen> {
  // قاعدة البيانات المجلوبة برمجياً والتي تغذي الواجهة بالكامل
  final List<AnimeData> animeDatabase = [
    AnimeData(
      title: "One Piece",
      genre: "أكشن، مغامرة",
      rating: 9.2,
      coverUrl: "https://images.unsplash.com/photo-1578632767115-351597cf2477?w=500",
      episodes: [
        Episode(episodeNumber: 1101, servers: [
          VideoServer(serverName: "Google Drive", videoUrl: "https://redirector.gvt1.com/op1101_1080p.mp4", quality: "1080p"),
          VideoServer(serverName: "Mega", videoUrl: "https://mega.nz/op1101_720p.mp4", quality: "720p")
        ])
      ]
    ),
    AnimeData(
      title: "Attack on Titan",
      genre: "خيال مظلم، دراما",
      rating: 9.5,
      coverUrl: "https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?w=500",
      episodes: [
        Episode(episodeNumber: 1, servers: [
          VideoServer(serverName: "Archive Server", videoUrl: "https://archive.org/aot_01_1080p.mp4", quality: "1080p")
        ])
      ]
    ),
    AnimeData(
      title: "Demon Slayer",
      genre: "شياطين، تاريخي",
      rating: 8.7,
      coverUrl: "https://images.unsplash.com/photo-1560169897-fc0cdbdfa4d5?w=500",
      episodes: [
        Episode(episodeNumber: 55, servers: [
          VideoServer(serverName: "UpToStream", videoUrl: "https://uptostream.com/ds_55_720p.mp4", quality: "720p")
        ])
      ]
    )
  ];

  // دالة محاكاة تشغيل السيرفر المستخرج عند الضغط على الأنمي
  void playAnimeEpisode(AnimeData anime) {
    var latestEpisode = anime.episodes.last;
    var bestServer = latestEpisode.servers.first;

    // إظهار رسالة تفاعلية أسفل الشاشة تخبر المستخدم بنجاح جلب رابط البث
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "🎬 جاري البث المباشر: ${anime.title}\n🌐 السيرفر: ${bestServer.serverName} [${bestServer.quality}]",
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
        duration: Duration(seconds: 4),
      ),
    );
    
    // طباعة تفاصيل الرابط النظيف المستخرج في المطورين (Console)
    print("🔗 رابط الفيديو الممرر للمشغل تلقائياً: ${bestServer.videoUrl}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🍿 منصة البث: Anime HD', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('اختر الأنمي لبدء الجلب والتشغيل المباشر:', style: TextStyle(fontSize: 16, color: Colors.amber, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemCount: animeDatabase.length,
                itemBuilder: (context, index) {
                  var anime = animeDatabase[index];
                  return GestureDetector(
                    onTap: () => playAnimeEpisode(anime), // عند الضغط يتم استخراج وتشغيل الحلقة فوراً
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(anime.coverUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black90],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 10,
                            right: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(anime.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                                Text(anime.genre, style: TextStyle(fontSize: 11, color: Colors.grey[400])),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.between,
                                  children: [
                                    Text("⭐ ${anime.rating}", style: TextStyle(color: Colors.amber, fontSize: 13, fontWeight: FontWeight.bold)),
                                    Icon(Icons.play_circle_filled, color: Colors.redAccent, size: 32),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
