import 'package:flutter/material.dart';

void main() => runApp(AnimeHDApp());

class AnimeHDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // الثيم المظلم المميز لتطبيقات الأنمي
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  // محاكاة قائمة الأنميات بالصور والبوسترات
  final List<Map<String, String>> animes = [
    {"title": "One Piece", "image": "https://images.unsplash.com/photo-1578632767115-351597cf2477?w=500", "rating": "⭐ 9.2"},
    {"title": "Attack on Titan", "image": "https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?w=500", "rating": "⭐ 9.5"},
    {"title": "Demon Slayer", "image": "https://images.unsplash.com/photo-1560169897-fc0cdbdfa4d5?w=500", "rating": "⭐ 8.7"},
    {"title": "Naruto Shippuden", "image": "https://images.unsplash.com/photo-1541562232579-512a21360020?w=500", "rating": "⭐ 8.6"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🍿 المنصة العملاقة: Anime HD', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('آخر الأنميات المحدثة تلقائياً:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عرض أنميين في كل سطر
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: animes.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      children: [
                        // بوستر الأنمي
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(animes[index]['image']!, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                        ),
                        // طبقة مظلمة خفيفة لقراءة النص بوضوح
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black87],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        // تفاصيل الأنمي (الاسم والتقييم وزر التشغيل)
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(animes[index]['title']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.between,
                                children: [
                                  Text(animes[index]['rating']!, style: TextStyle(color: Colors.amberAccent, fontSize: 12)),
                                  Icon(Icons.play_circle_fill, color: Colors.redAccent, size: 30), // زر التشغيل السريع
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
