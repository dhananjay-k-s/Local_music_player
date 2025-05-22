import 'package:flutter/material.dart';
import 'package:tunesync/service/audio_controller.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/bottom_player.dart';
import 'package:tunesync/widgets/neo_button.dart';
import 'package:tunesync/widgets/song_list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  final audioController = AudioController();
  final _searchController = TextEditingController();
  List<dynamic> _filteredSongs = [];
  late AnimationController _animationController;
  late Animation<double> _searchBarAnimation;
  late Animation<double> _resultsAnimation;

  @override
  void initState() {
    super.initState();
    _filteredSongs = audioController.songs.value;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _searchBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _resultsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  void _filterSongs(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSongs = audioController.songs.value;
      } else {
        _filteredSongs = audioController.songs.value
            .where((song) =>
                song.title.toLowerCase().contains(query.toLowerCase()) ||
                song.artist.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

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
          'Search',
          style: myTextStyle24(fontColor: theme.colorScheme.primary),
        ),
      ),
      body: Column(
        children: [
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.5),
              end: Offset.zero,
            ).animate(_searchBarAnimation),
            child: FadeTransition(
              opacity: _searchBarAnimation,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterSongs,
                    autofocus: true,
                    style: myTextStyle15(fontColor: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search songs or artists...',
                      hintStyle: myTextStyle15(fontColor: Colors.white54),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: theme.colorScheme.primary,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: theme.colorScheme.primary,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                _filterSongs('');
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: audioController.songs,
              builder: (context, songs, child) {
                if (_filteredSongs.isEmpty) {
                  return FadeTransition(
                    opacity: _resultsAnimation,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 64,
                            color: theme.colorScheme.primary.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No songs found',
                            style: myTextStyle18(
                              fontColor: theme.colorScheme.primary.withOpacity(0.7),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Try a different search term',
                              style: myTextStyle15(fontColor: Colors.white54),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }
                return FadeTransition(
                  opacity: _resultsAnimation,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 140),
                    itemCount: _filteredSongs.length,
                    itemBuilder: (context, index) {
                      final songIndex = songs.indexOf(_filteredSongs[index]);
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.5, 0),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Interval(
                              0.4 + (index * 0.1).clamp(0.0, 0.6),
                              1.0,
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                        child: SongListItem(
                          song: _filteredSongs[index],
                          index: songIndex,
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
      bottomSheet: const BottomPlayer(),
    );
  }
}