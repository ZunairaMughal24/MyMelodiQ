import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:melodiq/controller/playController.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaySongScreen extends StatelessWidget {
  final List<SongModel> data;
  // final String title;
  // final String artist;

  const PlaySongScreen({
    super.key,
    // required this.title,
    // required this.artist,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Playcontroller>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 145, 23, 53),
        title: const Text(
          'Now Playing',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color.fromARGB(221, 29, 28, 28),
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: QueryArtworkWidget(
                        id: data[controller.playerIndex.value].id,
                        type: ArtworkType.AUDIO,
                        artworkHeight: double.infinity,
                        artworkWidth: double.infinity,
                        nullArtworkWidget: Icon(
                          Icons.music_note,
                          size: MediaQuery.of(context).size.width * 0.3,
                          color: Colors.black87,
                        ),
                        artworkFit: BoxFit.cover, // Ensures the image covers the entire area of the container
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      data[controller.playerIndex.value].displayNameWOExt,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data[controller.playerIndex.value].artist.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous, size: 36, color: Colors.white),
                    onPressed: () {
                      controller.playSong(data[controller.playerIndex.value - 1].uri, controller.playerIndex.value - 1);
                      // Handle back button press
                    },
                  ),
                  InkWell(
                    onTap: () {
                      // Handle play/pause action
                    },
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 145, 23, 53),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: controller.isPlaying.value
                            ? GestureDetector(
                                onTap: () {
                                  if (controller.isPlaying.value) {
                                    controller.audioPlayer.pause();
                                    controller.isPlaying(false);
                                  } else {
                                    controller.audioPlayer.play();
                                    controller.isPlaying(true);
                                  }
                                  controller.isPlaying.value = controller.audioPlayer.playing;
                                },
                                child: const Icon(
                                  Icons.pause,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(
                                Icons.play_arrow,
                                size: 50,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next, size: 36, color: Colors.white),
                    onPressed: () {
                      controller.playSong(data[controller.playerIndex.value + 1].uri, controller.playerIndex.value + 1);
                      // Handle forward button press
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      controller.position.value,
                      style: TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: Slider(
                        min: Duration(seconds: 0).inSeconds.toDouble(),
                        max: controller.max.value.toDouble(),
                        value: controller.value.value,
                        // Current position of the song
                        onChanged: (newValue) {
                          controller.changeDurationToSeconds(newValue.toInt());
                          newValue = controller.value.value;
                          // Handle slider value change
                        },
                        activeColor: const Color.fromARGB(255, 145, 23, 53),
                        inactiveColor: Colors.grey[600],
                      ),
                    ),
                    Text(
                      controller.duration.value,
                      style: TextStyle(color: Colors.amber),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
