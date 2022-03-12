import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

class ItemDownload extends StatefulWidget {
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
  State<ItemDownload> createState() => _ItemDownloadState();
}

class _ItemDownloadState extends State<ItemDownload> {
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.onLongPress,
      onTap: widget.action,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                widget.isSelect ? AppColor.borderColor : AppColor.transparent,
            width: 2,
          ),
          color: widget.isDownloaded ? AppColor.backItem2 : AppColor.backItem,
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
                        text: widget.name,
                        colorText: AppColor.txtColor3,
                        sizeText: 16,
                        weightText: FontWeight.bold,
                        textAlign: TextAlign.start,
                        padding: const EdgeInsets.all(0),
                      ),
                      if (widget.description != null)
                        TextView(
                          text: widget.description ?? '',
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
            widget.isDownloaded ? Container() : _downloadView(),
          ],
        ),
      ),
    );
  }

  Widget _downloadView() {
    return (_progress > 0)
        ? CircularProgressIndicator(
            value: _progress,
          )
        : GestureDetector(
            onTap: _startDownload,
            child: Icon(
              Icons.cloud_download_outlined,
              color: AppColor.conColor1,
            ),
          );
  }

  void _startDownload() {
    DataSource.instance.downloadBook(
        bookId: 1,
        narrationId: 1,
        retunProgress: (val) {
          print('StartDownload ' + val.toString());
          setState(() {
            _progress = val;
          });
          if (val >= 1.0) {
            print('Download Done');
            widget.onDownload!();
          }
        });
  }
}
