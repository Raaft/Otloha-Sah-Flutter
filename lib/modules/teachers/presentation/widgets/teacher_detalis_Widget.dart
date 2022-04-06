import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/utils/constant/constants.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../data_source/models/database_model/teacher_response_entity.dart';






teacherDetailsBody(TeacherResponse results) {
  TeacherResponse? profile = results;
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CachedImage(
            url: '$baseUrl${profile.image}', raduis: 100),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            const SizedBox(
              width: 8,
            ),
            if (profile.rate != null)
              Text(
                '${profile.rate!}',
                style: const TextStyle(fontSize: 24),
              ),
            const SizedBox(
              width: 8,
            ),
            if (profile.isCertified ?? false)
              Icon(
                Icons.check_circle,
                color: AppColor.lightBlue,
              ),
            const SizedBox(width: 8),
            Text(
              profile.username ?? tr('empty'),
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          //margin: const EdgeInsets.all(20),
          width: double.infinity,
          //height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightBlue, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 8,
                ),
                ListTile(
                  leading: Text(tr('First Name')),
                  title: Text(
                      '${profile.firstName ?? tr('empty')} '),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     // const Icon(Icons.person),
                //     Text(tr('First Name')),
                //     const SizedBox(width: 20),
                //     Text(
                //         '${cubit.currentUserProfile!.firstName ?? tr('empty')} ${cubit.currentUserProfile!.lastName ?? tr('empty')}'),
                //   ],
                // ),
                const SizedBox(
                  height: 4,
                ),

                ListTile(
                  leading: Text(tr('Last Name')),
                  title:
                  Text(profile.lastName ?? tr('empty')),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Text(tr('Last Name')),
                //     const SizedBox(width: 20),
                //     Text(cubit.currentUserProfile!.phone ?? tr('empty')),
                //   ],
                // ),
                const SizedBox(
                  height: 4,
                ),
                ListTile(
                  leading: Text(tr('Type')),
                  title:
                  Text(profile.gender ?? tr('empty')),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     const Icon(Icons.accessibility),
                //     const SizedBox(width: 20),
                //     Text(cubit.currentUserProfile!.gender ?? tr('empty')),
                //   ],
                // ),
                const SizedBox(
                  height: 8,
                ),
                ListTile(
                  leading: Text(tr('Level')),
                  title:
                  Text(profile.level ?? tr('empty')),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     const Icon(Icons.bar_chart),
                //     const SizedBox(width: 20),
                //     Text(cubit.currentUserProfile!.level ?? tr('empty')),
                //   ],
                // ),
                const SizedBox(
                  height: 4,
                ),
                ListTile(
                  leading: Text(tr('Bio')),
                  title: Text(profile.bio ?? tr('empty')),
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     const Icon(Icons.settings_accessibility),
                //     const SizedBox(width: 20),
                //     Text(
                //       cubit.currentUserProfile!.bio ?? tr('empty'),
                //       style: const TextStyle(fontSize: 24),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 4,
                ),
              ]),
        )
      ],
    ),
  );
}

