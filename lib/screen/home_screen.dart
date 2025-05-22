import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tunesync/screen/library_screen.dart';
import 'package:tunesync/screen/settings_screen.dart';
import 'package:tunesync/service/audio_controller.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/bottom_player.dart';
import 'package:tunesync/widgets/neo_button.dart';
import 'package:tunesync/widgets/song_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final audioController = AudioController();
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.audio.status;
    setState(() => _hasPermission = status.isGranted);
    if (status.isGranted) {
      await audioController.loadSongs();
    } else {
      final result = await Permission.audio.request();
      setState(() => _hasPermission = result.isGranted);
      if (result.isGranted) {
        await audioController.loadSongs();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Local ",
                style: myTextStyle24(
                  fontWeight: FontWeight.bold,
                  fontColor: Colors.white,
                ),
              ),
              TextSpan(
                text: "MusicPlayer",
                style: myTextStyle24(
                  fontWeight: FontWeight.w900,
                  fontColor: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeoButton(
            child: const Icon(Icons.person),
            onPressed: () {},
          ),
        ),
        actions: [
          NeoButton(
            child: const Icon(Icons.library_music_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LibraryScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          NeoButton(
            child: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: audioController.songs,
        builder: (context, songs, child) {
          if (songs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: theme.colorScheme.primary,
                    strokeWidth: 6,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Loading your music...',
                    style: myTextStyle15(fontColor: theme.colorScheme.primary),
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
              return SongListItem(song: songs[index], index: index);
            },
          );
        },
      ),
      bottomSheet: const BottomPlayer(),
    );
  }
}
