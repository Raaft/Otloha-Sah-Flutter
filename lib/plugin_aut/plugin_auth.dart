import 'plugin_web_servise.dart';

class PluginAuth{

  pluginAuth({required String url, required Map<String, dynamic> query}){
    DioHelper.postData(url: url, query: query);
  }
  
}