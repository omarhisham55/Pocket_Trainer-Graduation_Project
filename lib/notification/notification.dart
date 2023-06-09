import 'package:final_packet_trainer/notification/notification_initialize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../navigation/cubit/cubit.dart';
import '../navigation/cubit/states.dart';

//Done
class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CubitManager(),
        child: BlocConsumer<CubitManager, MainStateManager>(
            listener: (_, state) {},
            builder: (_, state) {
              late bool isNotificationSent = false;
              List<Widget> pages = [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.notifications_none_outlined,
                          size: 400, color: BackgroundColors.whiteBG),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: subTitleText(
                              text:
                                  "We'll notify you when we have news to share about your training",
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Container(
                                color: BackgroundColors.dialogBG,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 15),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  subTitleText(
                                                      text: "Title",
                                                      maxLines: 1,
                                                      textOverflow: TextOverflow
                                                          .ellipsis),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: paragraphText(
                                                              text: "Content",
                                                              textOverflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2)),
                                                      paragraphText(
                                                          text: "02:00 pm")
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                          itemCount: 5),
                    ],
                  ),
                )
              ];
              return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  title: titleText(text: "Notifications"),
                ),
                body: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: BackgroundColors.blackGradient),
                  child: (isNotificationSent) ? pages[1] : pages[0],
                ),
              );
            }));
  }
}
