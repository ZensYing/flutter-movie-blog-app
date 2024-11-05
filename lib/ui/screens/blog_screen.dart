// lib/ui/screens/blog_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/providers/blog_provider.dart';
import 'blog_detail_screen.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BlogProvider>(context, listen: false).fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final articles = blogProvider.filteredArticles;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Blog"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: blogProvider.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.tealAccent))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      blogProvider.searchArticles(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search articles...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      prefixIcon: const Icon(Icons.search, color: Colors.tealAccent),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      final title = article['title'] ?? 'No Title';
                      final category = article['category']['name'] ?? 'No Category';
                      final author =
                          '${article['user_created']['first_name']} ${article['user_created']['last_name']}';
                      final date = article['date_created'] ?? 'No Date';
                      final thumbnail = article['thumbnail'];

                      return Card(
                        color: Colors.grey[900],
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://tech-cambodia.com/cms/assets/$thumbnail',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[700],
                                  child: const Icon(Icons.image, color: Colors.white),
                                );
                              },
                            ),
                          ),
                          title: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category,
                                style: const TextStyle(
                                  color: Colors.tealAccent,
                                ),
                              ),
                              Text(
                                'By $author on $date',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward, color: Colors.tealAccent),
                          onTap: () {
                            // Navigate to detailed article page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogDetailScreen(article: article),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
