import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/climate_news_service.dart';
import '../views/news_web_view.dart';
import '../constants/app_colors.dart';

class ClimateNewsPage extends StatefulWidget {
  const ClimateNewsPage({Key? key}) : super(key: key);

  @override
  _ClimateNewsPageState createState() => _ClimateNewsPageState();
}

class _ClimateNewsPageState extends State<ClimateNewsPage> with TickerProviderStateMixin {
  late Future<List<dynamic>> future;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    future = ClimateNewsService().fetchClimateNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Climate News",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.darkBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppColors.black,
              AppColors.secondaryBlack,
              AppColors.secondaryBlack.withOpacity(.99),
              AppColors.secondaryBlack.withOpacity(.98),
              AppColors.secondaryBlack.withOpacity(.97),
              AppColors.secondaryBlack.withOpacity(.96),
              AppColors.secondaryBlack.withOpacity(.95),
              AppColors.secondaryBlack.withOpacity(.94),
              AppColors.secondaryBlack.withOpacity(.93),
              AppColors.secondaryBlack.withOpacity(.92),
              AppColors.secondaryBlack.withOpacity(.91),
              AppColors.secondaryBlack.withOpacity(.90),
              AppColors.darkBlue,
              AppColors.accentBlue,
              AppColors.lightBlue,
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                    final AnimationController animationController = AnimationController(
                      duration: const Duration(milliseconds: 800),
                      vsync: this,
                    );

                    final Animation<double> fadeAnimation = CurvedAnimation(
                      parent: animationController,
                      curve: Curves.easeIn,
                    );

                    animationController.forward();

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: FadeTransition(
                        opacity: fadeAnimation,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Material(
                            color: _selectedIndex == index
                                ? AppColors.lightBlue.withOpacity(0.7)
                                : (index == 0 ? AppColors.lightBlue : AppColors.accentBlue),
                            elevation: index == 0 ? 12 : 0,
                            borderRadius: BorderRadius.circular(25.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (article['urlToImage'] != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.network(
                                        article['urlToImage'],
                                        width: double.infinity,
                                        height: 180,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(Icons.image_not_supported);
                                        },
                                      ),
                                    ),
                                  const SizedBox(height: 12),
                                  Text(
                                    article['title'] ?? 'No title',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    article['description'] ?? 'No description available',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () {
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
                                        'Read More',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
    );
  }
}
