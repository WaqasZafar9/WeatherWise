import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../views/gradient_container.dart';
import '/services/climate_news_service.dart';
import '/views/news_web_view.dart';

class ClimateNewsPage extends StatefulWidget {
  const ClimateNewsPage({Key? key}) : super(key: key);

  @override
  _ClimateNewsPageState createState() => _ClimateNewsPageState();
}

class _ClimateNewsPageState extends State<ClimateNewsPage> {
  late Future<List<dynamic>> future;

  @override
  void initState() {
    super.initState();
    future = ClimateNewsService().fetchClimateNews();
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Climate News',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error: ${snapshot.error}');
                      return const Center(child: Text("Error loading climate news"));
                    } else if (snapshot.hasData) {
                      final articles = snapshot.data!;
                      if (articles.isNotEmpty) {
                        return ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8.0),
                                leading: article['urlToImage'] != null
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    article['urlToImage'],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.image_not_supported);
                                    },
                                  ),
                                )
                                    : const Icon(Icons.image_not_supported),
                                title: Text(
                                  article['title'] ?? 'No title',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article['description'] ?? 'No description available',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewsWebView(
                                              url: article['url'] ?? '',
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Read more',
                                        style: GoogleFonts.poppins(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsWebView(
                                        url: article['url'] ?? '',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("No climate news available"));
                      }
                    } else {
                      return const Center(child: Text("No data"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
