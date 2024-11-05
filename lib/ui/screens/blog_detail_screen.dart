// lib/ui/screens/blog_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class BlogDetailScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  const BlogDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final title = article['title'] ?? 'No Title';
    final content = article['body'] ?? 'No Content';
    final date = article['date_created'] ?? 'No Date';
    final category = article['category']['name'] ?? 'No Category';
    final authorFirstName = article['user_created']['first_name'] ?? '';
    final authorLastName = article['user_created']['last_name'] ?? '';
    final views = article['views']?.toString() ?? '0';
    final thumbnail = article['thumbnail'];
    final authorAvatar = article['user_created']['avatar'];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Blog Detail"),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (thumbnail != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://tech-cambodia.com/cms/assets/$thumbnail',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[700],
                    child: const Center(
                      child: Icon(Icons.image, color: Colors.white),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.tealAccent,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                if (authorAvatar != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://tech-cambodia.com/cms/assets/$authorAvatar',
                    ),
                    radius: 20,
                  ),
                const SizedBox(width: 10),
                Text(
                  "$authorFirstName $authorLastName",
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                const SizedBox(width: 10),
                Text(
                  "• $date",
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Category: $category",
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.remove_red_eye, color: Colors.tealAccent, size: 16),
                const SizedBox(width: 5),
                Text(
                  views,
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Render HTML content using flutter_widget_from_html
            HtmlWidget(
              content,
              textStyle: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
