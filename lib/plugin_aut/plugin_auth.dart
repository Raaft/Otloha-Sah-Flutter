import 'package:flutter_base/plugin_aut/AuthPluginModel.dart';

import 'plugin_web_servise.dart';

class PluginAuth {
  pluginAuth({required String url}) {
    DioHelper.postData(url: url).then((value) {
      var val = AuthPluginModel.fromJson(value.data);
      print('accessToken = ' + val.accessToken.toString());
    }).catchError((e) {
      print('error = $e');
    });
  }
}
