import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/quran/business_logic/cubit/quran_cubit.dart';
import 'package:flutter_base/modules/quran/business_logic/cubit/recitation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordTool extends StatelessWidget {
  const RecordTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranViewCubit, QuranViewState>(
      listener: (context, state) {
        // TO DO: implement listener
      },
      builder: (context, state) {
        var cubit = QuranViewCubit.get(context);
        var cubitAdd = RecitationAddCubit.get(context);
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
                      Text(
                        '${cubitAdd.current!.duration!.inMinutes.remainder(60)}:${cubitAdd.current!.duration!.inSeconds.remainder(60)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.lightYellow, fontSize: 20),
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.mic_none,
                            color: AppColor.lightYellow,
                            //   size: 40,
                          )),
                      GestureDetector(
                          onTap: () {
                            cubitAdd.stop();
                            cubit.changeIsRecordedFile();
                          },
                          child: Icon(
                            Icons.pause_circle_outline,
                            color: AppColor.white,
                            //    size: 40,
                          )),
                      GestureDetector(
                          onTap: () {
                            cubitAdd.stop();
                            cubit.changeIsOnTruePressed();
                            Future.delayed(const Duration(seconds: 5), () {
                              cubit.changeIsOnFalsePressed();
                            });
                          },
                          child: Icon(
                            Icons.cancel_presentation,
                            color: AppColor.white,
                            //    size: 40,
                          )),
                    ],
                  ),
                )));
      },
    );
  }
}
