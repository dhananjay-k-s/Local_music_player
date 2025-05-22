import 'package:flutter/material.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/neo_button.dart';
import 'package:tunesync/widgets/neo_container.dart';
import '../model/local_song_model.dart';
import '../screen/player_screen.dart';
import '../service/audio_controller.dart';

class SongListItem extends StatefulWidget {
  final LocalSongModel song;
  final int index;

  const SongListItem({super.key, required this.song, required this.index});

  @override
  State<SongListItem> createState() => _SongListItemState();
}

class _SongListItemState extends State<SongListItem> {
  String _formatDuration(int milliseconds) {
    final minutes = (milliseconds / 60000).floor();
    final seconds = ((milliseconds % 60000) / 1000).floor();
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final audioController = AudioController();
    final theme = Theme.of(context);
    
    return ValueListenableBuilder(
      valueListenable: audioController.currentIndex,
      builder: (context, currentIndex, child) {
        return ValueListenableBuilder(
          valueListenable: audioController.isPlaying,
          builder: (context, isPlaying, child) {
            final isCurrentSong = currentIndex == widget.index;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6,
              ),
              child: NeoContainer(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isCurrentSong 
                        ? theme.colorScheme.primary.withOpacity(0.2)
                        : theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.music_note,
                      color: isCurrentSong
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primary.withOpacity(0.5),
                    ),
                  ),
                  title: Text(
                    widget.song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: myTextStyle15(
                      fontColor: isCurrentSong
                          ? theme.colorScheme.primary
                          : Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    widget.song.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: myTextStyle12(
                      fontColor: isCurrentSong
                          ? theme.colorScheme.primary.withOpacity(0.7)
                          : Colors.white70,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatDuration(widget.song.duration),
                        style: myTextStyle12(
                          fontColor: isCurrentSong
                              ? theme.colorScheme.primary
                              : Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 8),
                      NeoButton(
                        onPressed: () {
                          audioController.playSong(widget.index);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerScreen(index: widget.index),
                            ),
                          );
                        },
                        btnBackGroundColor: isCurrentSong
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surface,
                        child: Icon(
                          isCurrentSong && isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: isCurrentSong
                              ? Colors.white
                              : theme.colorScheme.primary,
                          size: 27,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    audioController.playSong(widget.index);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerScreen(index: widget.index),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
