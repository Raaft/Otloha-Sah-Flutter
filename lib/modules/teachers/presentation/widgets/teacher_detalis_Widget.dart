import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/utils/constant/constants.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../data_source/models/database_model/teacher_response_entity.dart';




teacherDetailsBody(TeacherResponse results) {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CachedImage(url: '$baseUrl${results.image}', raduis: 100),
          // CircleAvatar(
          //   backgroundColor: AppColor.lightBlue,
          //   radius: 100,
          // ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: AppColor.lightBlue,
              ),
              const SizedBox(width: 8),
              Text(
                results.username ?? tr('empty'),
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            results.bio ?? tr('empty'),
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          RatingBar.builder(
            initialRating: results.rate!.toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.lightBlue, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(width: 20),
                      Text(
                          '${results.firstName ?? tr('empty')} ${results.lastName ?? tr('empty')}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 20),
                      Text(results.phone ?? tr('empty')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.accessibility),
                      const SizedBox(width: 20),
                      Text(results.gender ?? tr('empty')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.bar_chart),
                      const SizedBox(width: 20),
                      Text(results.level ?? tr('empty')),
                    ],
                  ),
                ]),
          )
        ],
      ),
    ),
  );
}
