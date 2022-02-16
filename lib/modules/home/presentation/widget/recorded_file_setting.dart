import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordedFileTool extends StatelessWidget {
  const RecordedFileTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return Positioned(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                width: MediaQuery.of(context).size.width / 1.3,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          cubit.onPlayAudio();
                        },
                        child: Icon(
                          Icons.play_arrow_outlined,
                          color: AppColor.white,
                          //  size: 40,
                        )),
                    GestureDetector(
                        onTap: () {
                          cubit.init().then((value) {
                            cubit.start();
                            cubit.changeIsRecorded();
                          });
                        },
                        child: Icon(
                          Icons.mic_none,
                          color: AppColor.white,
                          //  size: 40,
                        )),
                    GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.save_alt,
                          color: AppColor.white,
                          //size: 40,
                        )),
                    GestureDetector(
                        onTap: () {
                          cubit.stop();

                          cubit.changeIsOnTruePressed();
                          Future.delayed(const Duration(seconds: 5), () {
                            cubit.changeIsOnFalsePressed();
                          });
                        },
                        child: Icon(
                          Icons.cancel_presentation,
                          color: AppColor.white,
                          //  size: 40,
                        )),
                  ],
                ),
              )));
    });
  }
}
