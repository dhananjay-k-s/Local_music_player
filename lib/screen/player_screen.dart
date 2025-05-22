import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:tunesync/service/audio_controller.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import '../screen/lyrics_screen.dart';
import '../widgets/neo_button.dart';

class PlayerScreen extends StatefulWidget {
  final int index;
  const PlayerScreen({super.key, required this.index});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final audioController = AudioController();
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ValueListenableBuilder(
              valueListenable: audioController.currentIndex,
              builder: (context, currentIndex, _) {
                final currentSong = audioController.currentSong;
                if (currentSong == null) return const SizedBox.shrink();
                
                return Column(
                  children: [
                    Row(
                      children: [
                        NeoButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                        ),
                        const Spacer(),
                        Text('Now Playing', 
                          style: myTextStyle24(fontColor: theme.colorScheme.primary)
                        ),
                        const Spacer(),
                        NeoButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LyricsScreen(
                                  title: currentSong.title,
                                  artist: currentSong.artist,
                                  audioController: audioController,
                                ),
                              ),
                            );
                          },
                          child: const Icon(Icons.lyrics, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: size.width * 0.8,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colorScheme.primary.withOpacity(0.15),
                            theme.colorScheme.primary.withOpacity(0.05),
                          ],
                          stops: const [0.2, 0.8],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(8, 8),
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.15),
                            blurRadius: 16,
                            offset: const Offset(-4, -4),
                            spreadRadius: 1,
                          ),
                        ],
                        border: Border.all(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Lottie.asset(
                        "lib/assets/animation/music-new.json",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 30,
                      child: Marquee(
                        blankSpace: 50,
                        startPadding: 10,
                        velocity: 30,
                        style: myTextStyle18(fontColor: theme.colorScheme.primary),
                        text: currentSong.title.toString().split('/').last,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      currentSong.artist,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: myTextStyle15(fontColor: Colors.white70),
                    ),
                    const SizedBox(height: 20),
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
                              fontWeight: FontWeight.w600
                            ),
                            onSeek: (duration) {
                              audioController.audioPlayer.seek(duration);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NeoButton(
                          onPressed: () {
                            audioController.previousSong();
                          },
                          child: const Icon(Icons.skip_previous_rounded, size: 30),
                        ),
                        ValueListenableBuilder(
                          valueListenable: audioController.isPlaying,
                          builder: (context, isPlaying, _) {
                            return NeoButton(
                              btnBackGroundColor: theme.colorScheme.primary,
                              blureSecondColor: theme.colorScheme.primary.withOpacity(0.5),
                              onPressed: () {
                                audioController.togglePlayPause();
                                setState(() {
                                  _isPlaying = !_isPlaying;
                                });
                              },
                              padding: const EdgeInsets.all(20),
                              isPressed: isPlaying,
                              child: Icon(
                                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                size: 40,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        NeoButton(
                          onPressed: () {
                            audioController.nextSong();
                          },
                          child: const Icon(Icons.skip_next_rounded, size: 30),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}



