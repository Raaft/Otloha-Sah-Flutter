//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<audio_session/AudioSessionPlugin.h>)
#import <audio_session/AudioSessionPlugin.h>
#else
@import audio_session;
#endif

#if __has_include(<audioplayers/AudioplayersPlugin.h>)
#import <audioplayers/AudioplayersPlugin.h>
#else
@import audioplayers;
#endif

#if __has_include(<connectivity_plus/ConnectivityPlusPlugin.h>)
#import <connectivity_plus/ConnectivityPlusPlugin.h>
#else
@import connectivity_plus;
#endif

#if __has_include(<file_picker/FilePickerPlugin.h>)
#import <file_picker/FilePickerPlugin.h>
#else
@import file_picker;
#endif

#if __has_include(<flutter_audio_recorder2/FlutterAudioRecorder2Plugin.h>)
#import <flutter_audio_recorder2/FlutterAudioRecorder2Plugin.h>
#else
@import flutter_audio_recorder2;
#endif

#if __has_include(<flutter_downloader/FlutterDownloaderPlugin.h>)
#import <flutter_downloader/FlutterDownloaderPlugin.h>
#else
@import flutter_downloader;
#endif

#if __has_include(<flutter_native_splash/FlutterNativeSplashPlugin.h>)
#import <flutter_native_splash/FlutterNativeSplashPlugin.h>
#else
@import flutter_native_splash;
#endif

#if __has_include(<fluttertoast/FluttertoastPlugin.h>)
#import <fluttertoast/FluttertoastPlugin.h>
#else
@import fluttertoast;
#endif

#if __has_include(<image_picker/FLTImagePickerPlugin.h>)
#import <image_picker/FLTImagePickerPlugin.h>
#else
@import image_picker;
#endif

#if __has_include(<just_audio/JustAudioPlugin.h>)
#import <just_audio/JustAudioPlugin.h>
#else
@import just_audio;
#endif

#if __has_include(<just_waveform/JustWaveformPlugin.h>)
#import <just_waveform/JustWaveformPlugin.h>
#else
@import just_waveform;
#endif

#if __has_include(<network_info_plus/FLTNetworkInfoPlusPlugin.h>)
#import <network_info_plus/FLTNetworkInfoPlusPlugin.h>
#else
@import network_info_plus;
#endif

#if __has_include(<path_provider_ios/FLTPathProviderPlugin.h>)
#import <path_provider_ios/FLTPathProviderPlugin.h>
#else
@import path_provider_ios;
#endif

#if __has_include(<permission_handler_apple/PermissionHandlerPlugin.h>)
#import <permission_handler_apple/PermissionHandlerPlugin.h>
#else
@import permission_handler_apple;
#endif

#if __has_include(<record/RecordPlugin.h>)
#import <record/RecordPlugin.h>
#else
@import record;
#endif

#if __has_include(<shared_preferences_ios/FLTSharedPreferencesPlugin.h>)
#import <shared_preferences_ios/FLTSharedPreferencesPlugin.h>
#else
@import shared_preferences_ios;
#endif

#if __has_include(<sqflite/SqflitePlugin.h>)
#import <sqflite/SqflitePlugin.h>
#else
@import sqflite;
#endif

#if __has_include(<sqlite3_flutter_libs/Sqlite3FlutterLibsPlugin.h>)
#import <sqlite3_flutter_libs/Sqlite3FlutterLibsPlugin.h>
#else
@import sqlite3_flutter_libs;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AudioSessionPlugin registerWithRegistrar:[registry registrarForPlugin:@"AudioSessionPlugin"]];
  [AudioplayersPlugin registerWithRegistrar:[registry registrarForPlugin:@"AudioplayersPlugin"]];
  [ConnectivityPlusPlugin registerWithRegistrar:[registry registrarForPlugin:@"ConnectivityPlusPlugin"]];
  [FilePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FilePickerPlugin"]];
  [FlutterAudioRecorder2Plugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterAudioRecorder2Plugin"]];
  [FlutterDownloaderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterDownloaderPlugin"]];
  [FlutterNativeSplashPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterNativeSplashPlugin"]];
  [FluttertoastPlugin registerWithRegistrar:[registry registrarForPlugin:@"FluttertoastPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [JustAudioPlugin registerWithRegistrar:[registry registrarForPlugin:@"JustAudioPlugin"]];
  [JustWaveformPlugin registerWithRegistrar:[registry registrarForPlugin:@"JustWaveformPlugin"]];
  [FLTNetworkInfoPlusPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTNetworkInfoPlusPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [RecordPlugin registerWithRegistrar:[registry registrarForPlugin:@"RecordPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
  [Sqlite3FlutterLibsPlugin registerWithRegistrar:[registry registrarForPlugin:@"Sqlite3FlutterLibsPlugin"]];
}

@end
