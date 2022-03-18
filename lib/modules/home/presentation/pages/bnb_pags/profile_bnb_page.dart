import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/home/presentation/pages/coming_soon/coming_soon_page.dart';

class ProfileBNBPage extends StatelessWidget {
  const ProfileBNBPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ComingSoonPage(),
      /*Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: AppImages.duser1Image,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            buildName(name: 'Raaft Husseny ', potion: ' Student'),
            const SizedBox(height: 50),
            NumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(
              about:
                  'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
            ),
          ],
        ),
      ),*/
    );
  }

  Widget buildName({required String name, required String potion}) => Column(
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            potion,
            style: TextStyle(color: AppColor.darkBlue),
          )
        ],
      );

  Widget buildAbout({required String about}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about,
              style: TextStyle(
                  fontSize: 16, height: 1.4, color: AppColor.txtColor3),
            ),
          ],
        ),
      );
}

class UserPreferences {
  static const myUser = User(
    imagePath:
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Sarah Abs',
    email: 'sarah.abs@gmail.com',
    about:
        'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: false,
  );
}

class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
  });
}
