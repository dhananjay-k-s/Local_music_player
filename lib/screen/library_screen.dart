import 'package:flutter/material.dart';
import 'package:tunesync/service/audio_controller.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/screen/search_screen.dart';
import 'package:tunesync/screen/recent_screen.dart';
import 'package:tunesync/screen/genre_screen.dart';
import 'package:tunesync/screen/language_screen.dart';
import 'package:tunesync/screen/instruments_screen.dart';
import 'package:tunesync/widgets/bottom_player.dart';
import 'package:tunesync/widgets/neo_button.dart';
import 'package:tunesync/widgets/neo_container.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final audioController = AudioController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          'Library',
          style: myTextStyle24(fontColor: theme.colorScheme.primary),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                child: NeoContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Search songs...',
                        style: myTextStyle15(fontColor: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(16),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildCategoryTile(
                    'Recent',
                    Icons.history,
                    theme.colorScheme.primary,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecentScreen()),
                    ),
                  ),
                  _buildCategoryTile(
                    'Genre',
                    Icons.category,
                    Colors.deepPurple,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GenreScreen()),
                    ),
                  ),
                  _buildCategoryTile(
                    'Language',
                    Icons.language,
                    Colors.teal,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LanguageScreen()),
                    ),
                  ),
                  _buildCategoryTile(
                    'Instruments',
                    Icons.piano,
                    Colors.amber,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InstrumentsScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: const BottomPlayer(),
    );
  }

  Widget _buildCategoryTile(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: NeoContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: myTextStyle18(fontColor: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}