import 'package:flutter/material.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/bottom_player.dart';
import 'package:tunesync/widgets/neo_button.dart';
import 'package:tunesync/widgets/neo_container.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Map<String, dynamic>> genres = [
      {
        'name': 'Pop',
        'color': Colors.pink,
        'icon': Icons.music_note,
        'gradient': [Colors.pink, Colors.purple]
      },
      {
        'name': 'Rock',
        'color': Colors.red,
        'icon': Icons.music_note_outlined,
        'gradient': [Colors.red, Colors.deepOrange]
      },
      {
        'name': 'Hip Hop',
        'color': Colors.purple,
        'icon': Icons.mic,
        'gradient': [Colors.purple, Colors.deepPurple]
      },
      {
        'name': 'Jazz',
        'color': Colors.blue,
        'icon': Icons.piano,
        'gradient': [Colors.blue, Colors.indigo]
      },
      {
        'name': 'Classical',
        'color': Colors.amber,
        'icon': Icons.music_note,
        'gradient': [Colors.amber, Colors.orange]
      },
      {
        'name': 'Electronic',
        'color': Colors.green,
        'icon': Icons.electric_bolt,
        'gradient': [Colors.green, Colors.teal]
      },
      {
        'name': 'R&B',
        'color': Colors.deepOrange,
        'icon': Icons.queue_music,
        'gradient': [Colors.deepOrange, Colors.orange]
      },
      {
        'name': 'Country',
        'color': Colors.brown,
        'icon': Icons.audiotrack,
        'gradient': [Colors.brown, Colors.amber]
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
          'Genres',
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
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return NeoContainer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    (genre['gradient'] as List<Color>)[0].withOpacity(0.2),
                    (genre['gradient'] as List<Color>)[1].withOpacity(0.1),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (genre['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      genre['icon'] as IconData,
                      size: 32,
                      color: genre['color'] as Color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    genre['name'] as String,
                    style: myTextStyle18(fontColor: Colors.white),
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