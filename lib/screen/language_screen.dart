import 'package:flutter/material.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/bottom_player.dart';
import 'package:tunesync/widgets/neo_button.dart';
import 'package:tunesync/widgets/neo_container.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Map<String, dynamic>> languages = [
      {
        'name': 'English',
        'color': Colors.blue,
        'flag': '🇺🇸',
        'gradient': [Colors.blue, Colors.lightBlue]
      },
      {
        'name': 'Hindi',
        'color': Colors.orange,
        'flag': '🇮🇳',
        'gradient': [Colors.orange, Colors.deepOrange]
      },
      {
        'name': 'Telugu',
        'color': Colors.purple,
        'flag': '🇮🇳',
        'gradient': [Colors.purple, Colors.deepPurple]
      },
      {
        'name': 'Malayalam',
        'color': Colors.green,
        'flag': '🇮🇳',
        'gradient': [Colors.green, Colors.teal]
      },
      {
        'name': 'Tamil',
        'color': Colors.red,
        'flag': '🇮🇳',
        'gradient': [Colors.red, Colors.redAccent]
      },
      {
        'name': 'Kannada',
        'color': Colors.amber,
        'flag': '🇮🇳',
        'gradient': [Colors.amber, Colors.orange]
      },
      {
        'name': 'Korean',
        'color': Colors.indigo,
        'flag': '🇰🇷',
        'gradient': [Colors.indigo, Colors.blue]
      },
      {
        'name': 'Spanish',
        'color': Colors.deepOrange,
        'flag': '🇪🇸',
        'gradient': [Colors.deepOrange, Colors.orange]
      },
    ];

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: NeoButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
        title: Text(
          'Languages',
          style: myTextStyle24(fontColor: theme.colorScheme.primary),
        ),
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          return NeoContainer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    (language['gradient'] as List<Color>)[0].withOpacity(0.2),
                    (language['gradient'] as List<Color>)[1].withOpacity(0.1),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    language['flag'] as String,
                    style: const TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    language['name'] as String,
                    style: myTextStyle18(fontColor: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 3,
                    width: 40,
                    decoration: BoxDecoration(
                      color: (language['color'] as Color).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: const BottomPlayer(),
    );
  }
}