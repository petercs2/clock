import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multicolour_clock/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'clock_main_logic.dart';

class ClockMainPage extends StatefulWidget {
  const ClockMainPage({Key? key}) : super(key: key);

  @override
  State<ClockMainPage> createState() => _ClockMainPageState();
}

class _ClockMainPageState extends State<ClockMainPage> {
  ClockMainLogic controller = Get.find();

  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLandscape = true;

  bool _isControlsVisible = true;
  Timer? _hideTimer;
  final Duration _hideDelay = const Duration(seconds: 3);

  double _controlsPosition = 0;
  final double _hiddenPosition = -100;
  final double _visiblePosition = 0;
  final Duration _animationDuration = const Duration(milliseconds: 300);

  void checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.toNamed('/reload');
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    checkNetwork();
    _startHideTimer();
  }

  void _toggleControls() {
    setState(() {
      _isControlsVisible = !_isControlsVisible;
      _controlsPosition =
          _isControlsVisible ? _visiblePosition : _hiddenPosition;
    });

    if (_isControlsVisible) {
      _startHideTimer();
    } else {
      _cancelHideTimer();
    }
  }

  void _startHideTimer() {
    _cancelHideTimer();
    _hideTimer = Timer(_hideDelay, () {
      if (_isControlsVisible) {
        _toggleControls();
      }
    });
  }

  void _cancelHideTimer() {
    if (_hideTimer != null && _hideTimer!.isActive) {
      _hideTimer!.cancel();
    }
  }

  void _toggleOrientation() {
    setState(() {
      _isLandscape = !_isLandscape;
    });

    if (_isLandscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      //!!!TODO
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: bgColors.map((v) {
        int index = bgColors.indexOf(v);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Colors.white
                : Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildControls() {
    return Visibility(
        visible: _isControlsVisible,
        child: Container(
          width: double.infinity,
          height: 375,
          child: SafeArea(
              child: <Widget>[
            Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: <Widget>[
                Image.asset(
                  'assets/icon0.webp',
                  width: 21,
                  height: 18,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Rotate',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ].toRow(),
            )
                .decorated(
                    color: Colors.white.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(23))
                .gestures(onTap: () {
              _toggleOrientation();
            }),
            const SizedBox(
              width: 30,
            ),
            Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: <Widget>[
                Image.asset(
                  'assets/icon1.webp',
                  width: 22,
                  height: 21,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Setting',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ].toRow(),
            )
                .decorated(
                    color: Colors.white.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(23))
                .gestures(onTap: () {
              Get.toNamed('/clockSetting');
            })
          ]
                  .toRow(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start)
                  .marginOnly(top: 30)),
        ).decorated(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.black.withOpacity(0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<ClockMainLogic>(builder: (_) {
          return <Widget>[
            const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
            SafeArea(
              child: <Widget>[
                Expanded(
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: bgColors.length,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemBuilder: (_, idx) {
                          return GridView.builder(
                              padding: const EdgeInsets.all(30),
                              scrollDirection: _isLandscape
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1, mainAxisSpacing: 32),
                              itemCount: 2,
                              itemBuilder: (_, index) {
                                return <Widget>[
                                  Container().decorated(
                                      color: bgColors[_currentPage][index],
                                      borderRadius: BorderRadius.circular(22)),
                                  Positioned(
                                      top: 0,
                                      width: 200,
                                      child: Container(
                                        width: 200,
                                        height: 47,
                                        alignment: Alignment.center,
                                        child: Obx(() {
                                          return Text(
                                            index == 0
                                                ? controller.ymdStr.value
                                                : controller.weekDayStr.value,
                                            style: const TextStyle(
                                                fontSize: 24,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          );
                                        }),
                                      ).decorated(
                                          color: Colors.black.withOpacity(0.31),
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(22),
                                              bottomRight:
                                                  Radius.circular(22)))),
                                  Obx(() {
                                    return Text(
                                      index == 0
                                          ? controller.hourStr.value
                                          : controller.minuteStr.value,
                                      style: const TextStyle(
                                          fontSize: 200,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }),
                                  Container(
                                    width: double.infinity,
                                    height: 2,
                                    color: Colors.black,
                                  )
                                ].toStack(
                                  alignment: Alignment.center,
                                );
                              });
                        })),
                const SizedBox(
                  height: 10,
                ),
                _buildIndicator()
              ].toColumn(),
            ),
            AnimatedPositioned(
              duration: _animationDuration,
              curve: Curves.easeInOut,
              top: _controlsPosition,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: _animationDuration,
                opacity: _isControlsVisible ? 1 : 0,
                child: _buildControls(),
              ),
            ),
          ].toStack();
        }),
      )
          .decorated(
              image: DecorationImage(
                  image: AssetImage('assets/bg$_currentPage.webp'),
                  fit: BoxFit.fill))
          .gestures(onTap: () {
        setState(() {
          _toggleControls();
        });
      }),
    );
  }
}
