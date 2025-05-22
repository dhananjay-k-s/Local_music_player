# Local MusicPlayer 🎵

Local music player is a modern Flutter music player app that provides a seamless audio experience with beautiful UI animations and effects.
It has audio search function, genre classification, language classification and much more.


## Screenshort 
<div>
  <img  src = "https://github.com/dhananjay-k-s/Local_music_player/blob/main/Screenshots/photo_2025-05-22_19-40-16.jpg" height = 600 />
<img  src = "https://github.com/dhananjay-k-s/Local_music_player/blob/main/Screenshots/photo_2025-05-22_19-40-57.jpg" height = 600 />
<img  src = "https://github.com/dhananjay-k-s/Local_music_player/blob/main/Screenshots/photo_2025-05-22_19-41-01.jpg" height = 600 />
</div>

## 🚀 Features
- 🎶 Play audio files from the device
- 🔍 Fetch songs using **on_audio_query**
- 🎛️ Interactive **progress bar**
- ✨ Smooth text scrolling with **marquee**
- 🎧 Beautiful **glowing effect** using AvatarGlow
- 🎨 Animated UI elements with **Lottie**
- 📱 Cross-platform support (Android, iOS, Windows, Linux, macOS, Web)
- 🎵 Lyrics support with scrollable view
- 🔄 Background playback support
- 🌙 Modern neumorphic UI design
- 🎯 State management with Provider
- 🔒 Secure permission handling

## 🛠️ Technologies & Dependencies

| Package                  | Version  | Purpose                 |
|-------------------------|----------|-------------------------|
| permission_handler      | ^11.4.0  | Handle audio permissions |
| just_audio             | ^0.9.46  | Audio playback          |
| on_audio_query         | ^2.9.0   | Fetch local music files |
| marquee               | ^2.3.0   | Text scrolling effect   |
| audio_video_progress_bar | ^2.0.3 | Custom progress bar     |
| avatar_glow           | ^3.0.1   | Glowing animation       |
| lottie                | ^3.3.1   | Lottie animations       |
| scrollable_positioned_list | ^0.3.8 | Lyrics scrolling       |
| http                  | ^1.2.0   | Network requests        |
| provider              | ^6.1.2   | State management        |

## 📲 Installation
1. Clone the repository:
   ```sh
   git clone 
   ```
2. Navigate to the project directory:
   ```sh
   cd tunesync
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## 🔒 Permissions
Make sure to request the following permissions in `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.INTERNET"/>
```

For **Android 13+**, use the latest permission handling from `permission_handler`.

## 📱 Platform Support
- Android
- iOS
- Windows
- Linux
- macOS
- Web

## 🎨 UI/UX Features
- Neumorphic design elements
- Smooth animations and transitions
- Responsive layout
- Dark/Light theme support
- Custom progress bar with seek functionality
- Beautiful glowing effects
- Scrollable lyrics view
- Bottom player with mini controls




