import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunesync/utils/custom_text_style.dart';
import 'package:tunesync/widgets/neo_button.dart';
import 'package:tunesync/widgets/neo_container.dart';
import 'package:tunesync/widgets/bottom_player.dart';
import 'package:tunesync/service/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = Provider.of<SettingsProvider>(context);

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
          'Settings',
          style: myTextStyle24(fontColor: theme.colorScheme.primary),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            theme,
            'Appearance',
            [
              _buildSettingTile(
                theme,
                'Theme',
                settings.isDarkMode ? 'Dark' : 'Light',
                settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                onTap: () {
                  settings.toggleTheme();
                },
              ),
              _buildSettingTile(
                theme,
                'Accent Color',
                'Custom',
                Icons.color_lens,
                onTap: () {
                  _showColorPicker(context, settings);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSection(
            theme,
            'Playback',
            [
              _buildSettingTile(
                theme,
                'Crossfade',
                settings.crossfadeEnabled ? 'On' : 'Off',
                Icons.compare_arrows,
                onTap: () {
                  settings.toggleCrossfade();
                  if (settings.crossfadeEnabled) {
                    _showCrossfadeDialog(context, settings);
                  }
                },
              ),
              _buildSettingTile(
                theme,
                'Equalizer',
                'Custom',
                Icons.equalizer,
                onTap: () {
                  _showEqualizerDialog(context, settings);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSection(
            theme,
            'About',
            [
              _buildSettingTile(
                theme,
                'Version',
                '1.0.0',
                Icons.info_outline,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
      bottomSheet: const BottomPlayer(),
    );
  }

  Widget _buildSection(ThemeData theme, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: myTextStyle18(
              fontColor: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        NeoContainer(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    ThemeData theme,
    String title,
    String subtitle,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: myTextStyle15(fontColor: Colors.white),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: myTextStyle12(fontColor: Colors.white70),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showColorPicker(BuildContext context, SettingsProvider settings) {
    final List<Color> colors = [
      const Color(0xFF1DB954), // Spotify Green
      Colors.blue,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.amber,
      Colors.indigo,
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return NeoContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Choose Accent Color',
                  style: myTextStyle18(fontColor: Colors.white),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      settings.setAccentColor(colors[index]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors[index],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white24,
                          width: 2,
                        ),
                      ),
                      child: settings.accentColor == colors[index]
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showCrossfadeDialog(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Crossfade Duration',
            style: myTextStyle18(fontColor: Colors.white),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${settings.crossfadeDuration.toStringAsFixed(1)} seconds',
                    style: myTextStyle15(fontColor: Colors.white70),
                  ),
                  Slider(
                    value: settings.crossfadeDuration,
                    min: 0,
                    max: 12,
                    divisions: 24,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (value) {
                      settings.setCrossfadeDuration(value);
                      setState(() {});
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Done',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEqualizerDialog(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Row(
            children: [
              Text(
                'Equalizer',
                style: myTextStyle18(fontColor: Colors.white),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  settings.resetEqualizer();
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: settings.equalizerSettings.entries.map((entry) {
                    return Column(
                      children: [
                        Text(
                          entry.key,
                          style: myTextStyle12(fontColor: Colors.white70),
                        ),
                        Slider(
                          value: entry.value,
                          min: -12,
                          max: 12,
                          divisions: 48,
                          activeColor: Theme.of(context).colorScheme.primary,
                          onChanged: (value) {
                            settings.setEqualizerBand(entry.key, value);
                            setState(() {});
                          },
                        ),
                        Text(
                          '${entry.value.toStringAsFixed(1)} dB',
                          style: myTextStyle12(fontColor: Colors.white54),
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Done',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}