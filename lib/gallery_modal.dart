import 'package:bhhh_noise/cubit/player_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showGallery(BuildContext context) async {
  return await showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) {
          if (state is PlayerNormalState) {
            final noises = state.savedNoises.toList(growable: false);
            return Container(
              height: 200,
              color: Colors.white,
              child: ListView.builder(
                itemCount: state.savedNoises.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(noises[index]),
                    trailing: IconButton(
                      onPressed: () => {
                        context
                            .read<PlayerCubit>()
                            .deleteSavedNoise(name: noises[index])
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      context
                          .read<PlayerCubit>()
                          .playSavedNoise(name: noises[index]);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            );
          }
          return Container();
        },
      );
    },
  );
}
