import 'package:flutter/material.dart';
import 'package:tunesync/model/lyric_model.dart';
import 'package:tunesync/service/audio_controller.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/neo_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LyricsScreen extends StatefulWidget {
  final String title;
  final String artist;
  final AudioController audioController;

  const LyricsScreen({
    super.key,
    required this.title,
    required this.artist,
    required this.audioController,
  });

  @override
  State<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  List<LyricModel>? lyrics;

  @override
  void initState() {
    super.initState();
    fetchLyrics();
  }

  Future<void> fetchLyrics() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.lyrics.ovh/v1/${widget.artist}/${widget.title}'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final lyricsText = data['lyrics'] as String;
        
        final lines = lyricsText.split('\n');
        lyrics = lines.map((line) {
          return LyricModel(
            text: line.trim(),
            timestamp: Duration.zero,
          );
        }).toList();

        setState(() {});
      }
    } catch (e) {
      print('Error fetching lyrics: $e');
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
        leading: NeoButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
        title: Text(
          'Lyrics',
          style: myTextStyle24(fontColor: theme.colorScheme.primary),
        ),
      ),
      body: lyrics == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: theme.colorScheme.primary,
                    strokeWidth: 3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading lyrics...',
                    style: myTextStyle15(fontColor: theme.colorScheme.primary),
                  ),
                ],
              ),
            )
          : lyrics!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lyrics_outlined,
                        size: 64,
                        color: theme.colorScheme.primary.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No lyrics found',
                        style: myTextStyle18(
                          fontColor: theme.colorScheme.primary.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.title,
                          style: myTextStyle24(
                            fontColor: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'by ${widget.artist}',
                          style: myTextStyle15(
                            fontColor: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ...lyrics!.map((lyric) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              lyric.text,
                              style: myTextStyle18(
                                fontColor: lyric.text.trim().isEmpty
                                    ? Colors.transparent
                                    : Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
    );
  }
}