import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/play_button_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayPauseTools extends StatefulWidget {
  const PlayPauseTools({Key? key}) : super(key: key);

  @override
  State<PlayPauseTools> createState() => _PlayPauseToolsState();
}

class _PlayPauseToolsState extends State<PlayPauseTools> {
  @override
  void initState() {
    HomeCubit.get(context).initRecitationVerses();
    super.initState();
  }

  @override
  void dispose() {
    HomeCubit.get(context).audioPlayer.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      // TO DO: implement listener
    }, builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return ValueListenableBuilder<ButtonState>(
          valueListenable: cubit.playButtonNotifier,
          builder: (_, value, __) {
            return Positioned(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width / 2,
                      alignment: Alignment.center,
                      height: 45,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0)
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 1.1],
                          colors: [AppColor.lightBlue, AppColor.darkBlue],
                        ),
                        color: Colors.deepPurple.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () => cubit.onPreviousSongButtonPressed(),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AppColor.white,
                                size: 30,
                              )),
                          GestureDetector(
                            onTap: () {
                              if (!cubit.audioPlayer.playing) {
                                cubit.playVerses();
                              } else {
                                cubit.pausePlayer();
                              }
                            },
                            child: !cubit.audioPlayer.playing
                                ? Image.asset(AppIcons.playIcon,
                                    color: AppColor.white, width: 30)
                                : Icon(Icons.pause,
                                    size: 40, color: AppColor.white),
                          ),
                          GestureDetector(
                              onTap: () {
                                cubit.changeIsOnFalsePressed();
                              },
                              child: Icon(
                                Icons.stop,
                                color: AppColor.white,
                                size: 40,
                              )),
                          GestureDetector(
                              onTap: () => cubit.onNextSongButtonPressed(),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppColor.white,
                                size: 30,
                              )),
                        ],
                      ),
                    )));
          });
    });
  }
}
