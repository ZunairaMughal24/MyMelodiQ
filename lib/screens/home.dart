import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melodiq/controller/playController.dart';
import 'package:melodiq/screens/play.dart';

import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> musicList = [];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Playcontroller());
    return Scaffold(
        appBar: AppBar(
          title: const Text('melodiQ',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
          backgroundColor: const Color.fromARGB(255, 145, 23, 53),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const Drawer(),
        body: Container(
          color: const Color.fromARGB(221, 29, 28, 28),
          child: FutureBuilder<List<SongModel>>(
              future: controller.audioQuery.querySongs(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: null,
                uriType: UriType.EXTERNAL,
              ),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the data is being loaded
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If an error occurred while fetching the data
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  // If data is fetched but it's empty
                  return const Center(child: Text("No songs Found"));
                } else if (snapshot.hasData) {
                  // If data is fetched and it's not empty
                  final musicList = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final music = musicList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18.0),
                              border: Border.all(color: const Color.fromARGB(255, 224, 224, 224)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 201, 201, 201),
                                    offset: Offset(02, 03),
                                    blurRadius: 0.6,
                                    spreadRadius: 0.3),
                              ],
                            ),
                            child: Center(
                              child: Obx(
                                () => ListTile(
                                  leading: QueryArtworkWidget(
                                    id: snapshot.data![index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: const Icon(
                                      Icons.music_note,
                                      color: Color.fromARGB(255, 145, 23, 53),
                                      size: 36.0,
                                    ),
                                  ),
                                  title: Text(
                                    snapshot.data![index].displayNameWOExt,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "${snapshot.data![index].artist}",
                                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                  ),
                                  trailing: controller.playerIndex.value == index && controller.isPlaying.value
                                      ? const Icon(Icons.play_arrow,
                                          color: Color.fromARGB(255, 145, 23, 53), size: 30.0)
                                      : null,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  onTap: () {
                                    controller.playSong(snapshot.data![index].uri, index);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlaySongScreen(
                                          data: snapshot.data!,
                                          //  title: snapshot.data![index].displayNameWOExt,
                                          //   artist: '${snapshot.data![index].artist}',
                                        ),
                                      ),
                                    );

                                    // Handle play button press
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  // If snapshot is in some unexpected state
                  return const Center(child: Text("Something went wrong"));
                }
              }),
        ));
  }
}
