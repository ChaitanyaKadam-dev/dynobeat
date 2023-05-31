import 'package:audioplayers/audioplayers.dart';
import 'package:dynobeat/model/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:dynobeat/utils/ai_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:alan_voice/alan_voice.dart';

class HomePage extends StatefulWidget {
  //const HomePage({super.key});
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyPlayer>? players;
  MyPlayer? _selectedPlayer;
  Color? _selectedColor;
  bool _isPlaying = false;
  final sugg = [
    "play",
    "pause",
    "stop",
    "play next",
    "play previous",
    "play pop music",
    "play rock music",
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    fetchPlayers();

    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
      setState(() {});
    });
  }

  setupAlan() {
    AlanVoice.addButton(
        "9b827057b39bdb483fe83099c2c9df9b2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "play":
        _playMusic(_selectedPlayer!.url);
        break;

      case "play_channel":
        final id = response["id"];
        _audioPlayer.pause();
        MyPlayer newPlayer = players!.firstWhere((element) => element.id == id);
        players!.remove(newPlayer);
        players!.insert(0, newPlayer);
        _playMusic(newPlayer.url);
        break;

      case "stop":
        _audioPlayer.stop();
        break;

      case "next":
        final index = _selectedPlayer!.id;
        MyPlayer newPlayer;
        if (index + 1 > players!.length) {
          newPlayer = players!.firstWhere((element) => element.id == 1);
          players!.remove(newPlayer);
          players!.insert(0, newPlayer);
        } else {
          newPlayer = players!.firstWhere((element) => element.id == index + 1);
          players!.remove(newPlayer);
          players!.insert(0, newPlayer);
        }
        _playMusic(newPlayer.url);
        break;
      default:
        print('command was ${(response["command"])}');
        break;
    }
  }

  fetchPlayers() async {
    final playerJson = await rootBundle.loadString("assets/player.json");
    players = MyPlayerList.fromJson(playerJson).players;
    _selectedPlayer = players![0];
    _selectedColor = Color(int.parse(_selectedPlayer!.color));
    //print(players);
    setState(() {});
  }

  _playMusic(String url) {
    _audioPlayer.play(url as Source);
    _selectedPlayer = players?.firstWhere((element) => element.url == url);
    //print(_selectedPlayer.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: _selectedColor ?? AIColors.primaryColor2,
          child: players != null
              ? [
                  100.heightBox,
                  "All Channel".text.white.semiBold.make().px16(),
                  20.heightBox,
                  // ListView(
                  //   padding: Vx.m0,
                  //   shrinkWrap: true,
                  // children: players.map((e) => ListTile(
                  //   leading: CircleAvatar
                  //   backgroundImage: NetworkImage(e.icon),
                  //   subtitle: e.tagline.text.white.make(),
                  //   ))
                  //    .toList(),
                  // ).expand()
                ].vStack(crossAlignment: CrossAxisAlignment.start)
              : const Offstage(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(
                LinearGradient(colors: [
                  AIColors.primaryColor2,
                  AIColors.primaryColor1,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              )
              .make(),
          [
            AppBar(
              title: "DynoBeat".text.xl4.bold.white.make().shimmer(
                  primaryColor: Vx.blue300, secondaryColor: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
            ).h(100).p16(),
            20.heightBox,
            "Start with - Hey Alan 👇".text.italic.semiBold.white.make(),
            10.heightBox,
            VxSwiper.builder(
              itemCount: sugg.length,
              height: 50,
              viewportFraction: 0.35,
              autoPlay: true,
              autoPlayAnimationDuration: 3.seconds,
              autoPlayCurve: Curves.linear,
              enableInfiniteScroll: true,
              itemBuilder: (context, index) {
                final s = sugg[index];
                return Chip(
                  label: s.text.make(),
                  backgroundColor: Vx.randomColor,
                );
              },
            )
          ].vStack(),
          VxSwiper.builder(
            itemCount: players!.length,
            aspectRatio: 1.0,
            enlargeCenterPage: true,
            itemBuilder: (context, index) {
              final rad = players![index];

              return VxBox(
                      child: ZStack(
                [
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: VxBox(
                            child:
                                rad.category.text.uppercase.white.make().px16())
                        .height(40)
                        .black
                        .alignCenter
                        .withRounded(value: 10.0)
                        .make(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VStack(
                      [
                        rad.name.text.xl3.white.bold.make(),
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: [
                        const Icon(
                          CupertinoIcons.play_circle,
                          color: Colors.white,
                        ),
                        10.heightBox,
                        "Double Tap for play".text.gray300.make()
                      ].vStack())
                ],
              ))
                  .clip(Clip.antiAlias)
                  .bgImage(
                    DecorationImage(
                        image: NetworkImage(rad.image),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken)),
                  )
                  .border(color: Colors.black, width: 5.0)
                  .withRounded(value: 60.0)
                  .make()
                  .onInkDoubleTap(() {
                _playMusic(rad.url);
              }).p16();
            },
          ).centered(),
          Align(
            alignment: Alignment.bottomCenter,
            child: [
              // if (_isPlaying)
              //   {"Playing now - ${_selectedPlayer!.name} ".text.white.makeCentered},
              Icon(
                _isPlaying
                    ? CupertinoIcons.stop_circle
                    : CupertinoIcons.play_circle,
                color: Colors.white,
                size: 50.0,
              ).onInkTap(() {
                if (_isPlaying) {
                  _audioPlayer.stop();
                } else {
                  _playMusic(_selectedPlayer!.url);
                }
              }),
            ].vStack(),
          ).pOnly(bottom: context.percentWidth * 12)
        ],
      ),
    );
  }
}
