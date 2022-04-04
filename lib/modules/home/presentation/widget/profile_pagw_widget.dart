import 'package:flutter/material.dart';

import '../../../../core/utils/themes/color.dart';

profilePageBody( cubit) {
  return Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CircleAvatar(
          backgroundColor: AppColor.lightBlue,
          radius: 100,
        ),
        const SizedBox(height: 20),
        Text(
          cubit.currentUserProfile!.username ?? 'name'  ,
          style: const TextStyle(fontSize: 24),
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

                children:  [
                  const Icon(Icons.person),
                  const SizedBox(width: 20),
                  Text('${cubit.currentUserProfile!.firstName} ${cubit.currentUserProfile!.lastName}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  const Icon(Icons.phone),
                  const SizedBox(width: 20),
                  Text('${cubit.currentUserProfile!.phone}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  const Icon(Icons.accessibility),
                  const SizedBox(width: 20),
                  Text('${cubit.currentUserProfile!.gender}'),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}