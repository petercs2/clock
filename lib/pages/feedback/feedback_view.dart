
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';
import 'clock_text_field.dart';
import 'feedback_logic.dart';

class FeedbackPage extends GetView<FeedbackLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<FeedbackLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 90,
                        height: 90,
                        child: controller.image == null
                            ? Icon(
                                Icons.camera_alt_outlined,
                                size: 40,
                                color: primaryColor,
                              )
                            : Image.memory(
                                controller.image!,
                                fit: BoxFit.cover,
                              ).decorated(color: Colors.grey[200]),
                      ).decorated(color: Colors.grey[200]).gestures(onTap: () {
                        controller.imageSelected();
                      })),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Feedback words',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: ClockTextField(
                        maxLength: 200,
                        maxLines: 8,
                        value: controller.content,
                        onChange: (value) {
                          controller.content = value;
                        }),
                  ).decorated(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ).decorated(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12)).marginSymmetric(vertical: 20).gestures(onTap: (){
                        controller.submit();
                  })
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(12))
            ].toColumn(),
          );
        }).marginAll(15)),
      ),
    );
  }
}
