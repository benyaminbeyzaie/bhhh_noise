import 'package:bhhh_noise/widget/bhhh_drawer.dart';
import 'package:bhhh_noise/widget/text_input_modal.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/bhhh_app_bar.dart';
import '../cubit/player_cubit.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  int _columnCount = 1;
  final double _cardHeight = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BhhhDrawer(),
      appBar: const BhhhAppBar(),
      body: ListView(
        children: [
          ..._buildTitles(),
          _buildActionButtons(),
          _buildPlayer(),
          _buildInfo(),
        ],
      ),
    );
  }

  BlocConsumer<PlayerCubit, PlayerState> _buildPlayer() {
    if (MediaQuery.of(context).size.width < 500) {
      _columnCount = 1;
    } else if (MediaQuery.of(context).size.width < 1000) {
      _columnCount = 2;
    } else {
      _columnCount = 3;
    }
    return BlocConsumer<PlayerCubit, PlayerState>(
      listener: (context, state) {
        if (state is NoiseSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Noise Saved!"),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PlayerLoading) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
            ],
          );
        }
        if (state is PlayerNormalState) {
          return Center(
            child: SizedBox(
              height: (state.noisePlayers.length / _columnCount).ceil() *
                  (_cardHeight),
              child: _buildGridOfPlayers(state),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: _columnCount == 3
            ? 120
            : _columnCount == 2
                ? 40
                : 20,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ElevatedButton(
              onPressed: () async {
                final bloc = context.read<PlayerCubit>();
                final name = await showTextInputModal(context);
                if (name == null) {
                  return;
                }

                bloc.saveNoise(name: name);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Save noise"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ElevatedButton(
              onPressed: () {
                context.read<PlayerCubit>().randomizePlay();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Randomize play"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ElevatedButton(
              onPressed: () {
                context.read<PlayerCubit>().stopAll();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Stop all"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildTitles() {
    return [
      Padding(
        padding: const EdgeInsets.only(
          top: 42,
          left: 12,
          right: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Expanded(
              child: Text(
                "Create the perfect environment to work and relax",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Expanded(
              child: Text(
                "~ Mix and match soundscapes, and share your creation with others ~",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildInfo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 5,
            left: 5,
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: "Made with 💙 by ",
                ),
                TextSpan(
                  style: const TextStyle(color: Colors.blueAccent),
                  text: "@benyaminbeyzaie.",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      const url = 'https://github.com/benyaminbeyzaie/';
                      if (!await launchUrl(Uri.parse(url))) {
                        throw 'Could not launch $url';
                      }
                    },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: "This project is a clone of ",
                ),
                TextSpan(
                  style: const TextStyle(color: Colors.blueAccent),
                  text: "shhh noise",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      const url = 'https://www.shhhnoise.com/';
                      if (!await launchUrl(Uri.parse(url))) {
                        throw 'Could not launch $url';
                      }
                    },
                ),
                const TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: " in flutter",
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }

  GridView _buildGridOfPlayers(PlayerNormalState state) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: _columnCount == 3
            ? 120
            : _columnCount == 2
                ? 40
                : 20,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _columnCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: _cardHeight - 20,
      ),
      itemCount: state.noisePlayers.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            state.noisePlayers[index]!.playing
                ? BoxShadow(
                    color: Colors.amber.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: -4,
                    blurStyle: BlurStyle.normal,
                  )
                : BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                    blurRadius: 20.0,
                    spreadRadius: 0.0,
                  ),
          ],
        ),
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.white,
          child: InkWell(
            onTap: () {
              context.read<PlayerCubit>().toggleNoise(id: index);
            },
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.noisePlayers[index]!.icon,
                    style: const TextStyle(fontSize: 50),
                  ),
                  Text(
                    state.noisePlayers[index]!.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Slider(
                    value: state.noisePlayers[index]!.volume,
                    onChanged: (value) => context
                        .read<PlayerCubit>()
                        .setVolume(id: index, volume: value),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
