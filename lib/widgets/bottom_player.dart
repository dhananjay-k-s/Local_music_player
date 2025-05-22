import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/neo_button.dart';
import '../screen/player_screen.dart';
import '../service/audio_controller.dart';

class BottomPlayer extends StatefulWidget {
  const BottomPlayer({super.key});

  @override
  State<BottomPlayer> createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer> with SingleTickerProviderStateMixin {
  final audioController = AudioController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ValueListenableBuilder(
      valueListenable: audioController.currentIndex,
      builder: (context, currentIndex, _) {
        final currentSong = audioController.currentSong;
        if (currentSong == null) return const SizedBox.shrink();
        
        return GestureDetector(
          onTapDown: (_) => _animationController.forward(),
          onTapUp: (_) {
            _animationController.reverse();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayerScreen(index: currentIndex),
              ),
            );
          },
          onTapCancel: () => _animationController.reverse(),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, -3),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.05),
                    offset: const Offset(0, -1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                    child: SizedBox(
                      height: 20,
                      child: Marquee(
                        blankSpace: 50,
                        startPadding: 30,
                        velocity: 30,
                        text: currentSong.title,
                        style: myTextStyle15(fontColor: theme.colorScheme.primary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: StreamBuilder<Duration>(
                      stream: audioController.audioPlayer.positionStream,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;
                        final duration = audioController.audioPlayer.duration ?? Duration.zero;
                        return ProgressBar(
                          progress: position,
                          total: duration,
                          progressBarColor: theme.colorScheme.primary,
                          baseBarColor: theme.colorScheme.surface,
                          bufferedBarColor: theme.colorScheme.primary.withOpacity(0.2),
                          thumbColor: theme.colorScheme.primary,
                          timeLabelTextStyle: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 12,
                          ),
                          timeLabelPadding: 4,
                          onSeek: (duration) {
                            audioController.audioPlayer.seek(duration);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NeoButton(
                          onPressed: () => audioController.previousSong(),
                          child: const Icon(Icons.skip_previous_rounded, size: 24),
                        ),
                        ValueListenableBuilder(
                          valueListenable: audioController.isPlaying,
                          builder: (context, isPlaying, _) {
                            return NeoButton(
                              btnBackGroundColor: theme.colorScheme.primary,
                              onPressed: () => audioController.togglePlayPause(),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (child, animation) {
                                  return RotationTransition(
                                    turns: animation,
                                    child: ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Icon(
                                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                  key: ValueKey<bool>(isPlaying),
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            );
                          },
                        ),
                        NeoButton(
                          onPressed: () => audioController.nextSong(),
                          child: const Icon(Icons.skip_next_rounded, size: 24),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
