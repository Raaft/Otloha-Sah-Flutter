// import 'package:flutter/material.dart';
// import 'package:flutter_base/core/utils/constant/utils.dart';
// import 'package:flutter_base/core/utils/themes/color.dart';
// import 'package:flutter_base/core/widgets/tool_bar_app.dart';
// import 'package:flutter_base/core/widgets/text_view.dart';
// import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';
// import 'package:flutter_base/modules/messages/presentation/pages/messages_pages/general_box.dart';
// import 'package:flutter_base/modules/messages/presentation/pages/messages_pages/in_box_message_page.dart';
// import 'package:flutter_base/modules/messages/presentation/pages/messages_pages/out_box_message_page.dart';
// import 'package:flutter_base/modules/messages/presentation/pages/messages_pages/private_message_page.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// class MessagesPage1 extends StatelessWidget {
//    const MessagesPage1({Key? key}) : super(key: key);
//
//   static const routeName = '/message';
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<MessageTapCubit>(context).getGeneraBoXMessage();
//     var cubit =MessageTapCubit.get(context);
//     int _selected = cubit.index;
//
//     return Scaffold(
//       body: SafeArea(
//         child: BlocBuilder<MessageTapCubit, MessageTapState>(
//           builder: (context, state) {
//             // if (state is MessageTapChange) {
//             //   _selected = state.index;
//             // }
//
//             return Column(
//               children: [
//                 _topView(context),
//                 _tabsView(context,_selected),
//                 _viewItems(_selected),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _viewItems(_selected) {
//
//
//
//     if (_selected == 0) {
//       return  const GeneralMessagePage();
//     }
//     if (_selected == 1) {
//       return InBoxMessagePage();
//     }
//     if (_selected == 2) {
//       return OutBoxMessagePage();
//     }
//     if (_selected == 3) {
//       return const PrivateMessagePage();
//     }
//     return  const GeneralMessagePage();
//   }
//
//   Row _tabsView(context,_selected) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         _tabItem(context,'General', 0, isSelect: _selected == 0, fetchData: () {
//           BlocProvider.of<MessageTapCubit>(context).getGeneraBoXMessage();
//         }),
//         _divider(),
//         _tabItem(context,'Inbox', 1, isSelect: _selected == 1, fetchData: () {
//           BlocProvider.of<MessageTapCubit>(context).getRecieveMessage();
//         }),
//         _divider(),
//         _tabItem(context,'Outbox', 2, isSelect: _selected == 2, fetchData: () {
//           BlocProvider.of<MessageTapCubit>(context).getSendMessage();
//         }),
//       ],
//     );
//   }
//
//
//
//   SizedBox _divider() {
//     return SizedBox(
//       width: 1.5,
//       child: Divider(
//         thickness: 16,
//         color: AppColor.txtColor4,
//       ),
//     );
//   }
//
//   Widget _tabItem(context,String title, int value,
//       {bool isSelect = false, Function()? fetchData}) {
//     return GestureDetector(
//       onTap: () {
//         BlocProvider.of<MessageTapCubit>(context).changeIndex(value);
//         fetchData!();
//       },
//       child: Container(
//         decoration: isSelect
//             ? BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColor.gradient5, AppColor.gradient6],
//                   begin: Alignment.centerRight,
//                   end: Alignment.centerLeft,
//                 ),
//                 borderRadius: BorderRadius.circular(5),
//               )
//             : null,
//         child: TextView(
//           text: translate(title),
//           colorText: isSelect ? AppColor.txtColor2 : AppColor.txtColor4,
//           padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//           sizeText: 16,
//           weightText: FontWeight.w600,
//         ),
//       ),
//     );
//   }
//
//   Widget _topView(context) {
//     return ToolBarApp(
//       backIcon: IconButton(
//         icon: GestureDetector(
//           child: const Icon(Icons.arrow_back),
//         ),
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//       ),
//       // actionIcon: GestureDetector(
//       //   onTap: () {
//       //     Get.to(() => const MessageDetails());
//       //   },
//       //   child: const Icon(Icons.filter_alt_outlined),
//       // ),
//       title: translate('Messages'),
//     );
//   }
// }
