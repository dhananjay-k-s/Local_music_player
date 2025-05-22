import 'package:flutter/material.dart';
import 'package:tunesync/service/audio_controller.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/song_list_item.dart';
import 'package:tunesync/widgets/bottom_player.dart';
import 'package:tunesync/widgets/neo_button.dart';

class RecentScreen extends StatelessWidget {
  final audioController = AudioController();

  RecentScreen({super.key});

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
          'Recent Songs',
          style: myTextStyle24(fontColor: theme.colorScheme.primary),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: audioController.songs,
        builder: (context, songs, _) {
          if (songs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: theme.colorScheme.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No recent songs',
                    style: myTextStyle18(
                      fontColor: theme.colorScheme.primary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 140),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return SongListItem(
                song: songs[index],
                index: index,
              );
            },
          );
        },
      ),
      bottomSheet: const BottomPlayer(),
    );
  }
}