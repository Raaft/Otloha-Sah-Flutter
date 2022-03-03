import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';

class ItemDownload extends StatelessWidget {
  const ItemDownload({
    Key? key,
    required this.name,
    this.description,
    required this.isDownloaded,
    required this.isSelect,
    this.onLongPress,
    this.onDownload,
    this.action,
  }) : super(key: key);

  final String name;
  final String? description;
  final bool isDownloaded;
  final bool isSelect;
  final Function()? onLongPress;
  final Function()? onDownload;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: action,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelect ? AppColor.borderColor : AppColor.transparent,
            width: 2,
          ),
          color: isDownloaded ? AppColor.backItem2 : AppColor.backItem,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [AppColor.conColor1, AppColor.gradient2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Image.asset(
                    AppIcons.helalIcon,
                    width: 24,
                    height: 24,
                    color: AppColor.txtColor2,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextView(
                        text: name,
                        colorText: AppColor.txtColor3,
                        sizeText: 16,
                        weightText: FontWeight.bold,
                        textAlign: TextAlign.start,
                        padding: const EdgeInsets.all(0),
                      ),
                      if (description != null)
                        TextView(
                          text: description ?? '',
                          colorText: AppColor.txtColor4,
                          sizeText: 12,
                          padding: const EdgeInsets.all(0),
                          textAlign: TextAlign.start,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            isDownloaded
                ? Container()
                : GestureDetector(
                    onTap: onDownload,
                    child: Icon(
                      Icons.cloud_download_outlined,
                      color: AppColor.conColor1,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
