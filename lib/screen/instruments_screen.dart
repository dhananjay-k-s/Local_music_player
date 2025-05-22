import 'package:flutter/material.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/bottom_player.dart';
import 'package:tunesync/widgets/neo_button.dart';
import 'package:tunesync/widgets/neo_container.dart';

class InstrumentsScreen extends StatelessWidget {
  const InstrumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Map<String, dynamic>> instruments = [
      {
        'name': 'Piano',
        'color': Colors.grey,
        'icon': Icons.piano,
        'gradient': [Colors.grey, Colors.blueGrey]
      },
      {
        'name': 'Guitar',
        'color': Colors.brown,
        'icon': Icons.music_note,
        'gradient': [Colors.brown, Colors.brown.shade300]
      },
      {
        'name': 'Drums',
        'color': Colors.red,
        'icon': Icons.album,
        'gradient': [Colors.red, Colors.redAccent]
      },
      {
        'name': 'Violin',
        'color': Colors.amber,
        'icon': Icons.music_note,
        'gradient': [Colors.amber, Colors.orange]
      },
      {
        'name': 'Flute',
        'color': Colors.teal,
        'icon': Icons.graphic_eq,
        'gradient': [Colors.teal, Colors.cyan]
      },
      {
        'name': 'Saxophone',
        'color': Colors.purple,
        'icon': Icons.queue_music,
        'gradient': [Colors.purple, Colors.deepPurple]
      },
      {
        'name': 'Trumpet',
        'color': Colors.orange,
        'icon': Icons.music_note,
        'gradient': [Colors.orange, Colors.deepOrange]
      },
      {
        'name': 'Bass',
        'color': Colors.indigo,
        'icon': Icons.music_note,
        'gradient': [Colors.indigo, Colors.blue]
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
          'Instruments',
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
        itemCount: instruments.length,
        itemBuilder: (context, index) {
          final instrument = instruments[index];
          return NeoContainer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    (instrument['gradient'] as List<Color>)[0].withOpacity(0.2),
                    (instrument['gradient'] as List<Color>)[1].withOpacity(0.1),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (instrument['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: (instrument['color'] as Color).withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      instrument['icon'] as IconData,
                      size: 32,
                      color: instrument['color'] as Color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    instrument['name'] as String,
                    style: myTextStyle18(fontColor: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 2,
                    width: 30,
                    decoration: BoxDecoration(
                      color: (instrument['color'] as Color).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(1),
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