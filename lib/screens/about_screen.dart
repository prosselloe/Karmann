import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// Definim una classe concreta que hereta de MarkdownElementBuilder
class ImgBuilder extends MarkdownElementBuilder {
  
  Widget visit(element, children) {
    final String src = element.attributes['src']!;
    // Afegeix un encoixinat per separar les imatges del text
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: src.startsWith('http')
          ? Image.network(src)
          : Image.asset(src),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<String> _loadReadme() async {
    return await rootBundle.loadString('README.md');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: FutureBuilder<String>(
        future: _loadReadme(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Markdown(
              data: snapshot.data!,
              onTapLink: (text, href, title) {
                if (href != null) {
                  launchUrl(Uri.parse(href));
                }
              },
              builders: {
                // Instanciem la nostra classe personalitzada
                'img': ImgBuilder(),
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading README.md: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
