import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/images.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'AddExercise.dart';
import 'colors.dart';
import 'components.dart';



class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  State<Exercise> createState() => _Exercise();
}



class _Exercise extends State<Exercise> {

  final panelController = PanelController();
  final foodPanelController = PanelController();
  bool listOpen = false;

  // DateTime selectedDate = DateTime.now();
  // DateTime startDate = DateTime.now().subtract(Duration(days: 10));
  // DateTime endDate = DateTime.now().add(Duration(days: 10));
  // Map<String, Widget> widgets = Map();
  // String widgetKeyFormat = "yyyy-MM-dd";
  List<String> titles = ["warmUp", "Exercises", "Stretches"];
  List gymI = GymImages().gym();
  int indexA = 0;
  @override
  Widget build(BuildContext context) {
    final closePanel = MediaQuery.of(context).size.height*0;
    final openPanel = MediaQuery.of(context).size.height*.4;
    return Scaffold(
      backgroundColor: BackgroundColors.background,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: const Icon(Icons.menu, color: Colors.transparent,),
        title: const Center(
          child: Text('Exercise',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          QudsPopupButton(tooltip: 'T',
              items: getMenuItems(),
              child: const Icon(Icons.more_vert, color: Colors.white, size: 30))
        ],
      ),


      body: Stack(
        children:[
          SlidingUpPanel(
            controller: panelController,
            minHeight: closePanel,
            maxHeight: openPanel,
            defaultPanelState: PanelState.CLOSED,
            body: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
             itemBuilder: (context, index) {
               return Column(
                   children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         children: [
                           const CircleAvatar(
                             radius: 5,
                             backgroundColor: Colors.green,
                           ),
                           const SizedBox(width: 7),
                           paragraphText(text: titles[index])
                         ],
                       ),
                     ),
                     ListView.builder(itemBuilder: (context, index) {
                       return Row(
                         children: [
                           defaultInkWell(
                               width: MediaQuery.of(context).size.width*0.96,
                               title: "title",
                               subtitle: Text("subtitle"),
                               child: Text("X sets.X reps"),
                               function: (){
                                 setState(() {
                                   indexA = index;
                                   (panelController.isPanelClosed) ? panelController.open() : panelController.close();

                                 });
                               },
                             image: gymI[index]
                           ),
                         ],
                       );
                     },
                       itemCount: 2,
                       physics: const NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                     ),
                   ]
               );
             },
             itemCount: 3,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            panelBuilder: (panelBuilder) => Container(
              width: 400,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //Icon(Icons.calendar_month , color: Colors.black,),
                        Text(
                          titles[indexA],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const Spacer(),
                        DefaultButton(
                          function: (){},
                          text: "Start",
                          borderRadius: 30,
                          width: MediaQuery.of(context).size.width*.3,
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'X sets . X reps',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(gymI[indexA],
                      height: 180,
                      width: 420,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
          ],
      ),

      bottomNavigationBar: BottomNavigationBar(

          items: const[
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box),
                label: 'profile',
                backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_bar),
              label: 'gym',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank_outlined),
                backgroundColor: Colors.black,
                label: 'food'
            )
          ]
      ),
    );
  }

  List<QudsPopupMenuBase> getMenuItems() {
    List<Widget> gymTraining = [];
    return [
      QudsPopupMenuItem(
        leading: const Icon(Icons.add),
        title: const Text('Add Exercise'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExercise()),
          );
        },
      ),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
          leading: const Icon(Icons.delete_outline),
          title: const Text('Delete training'),
          onPressed: () {
            // showToast('Feedback Pressed!');
          }
      ),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
          leading: const Icon(Icons.info_outline),
          title: const Text('Training info'),
          onPressed: () {
            // showToast('Feedback Pressed!');
          }
      ),
      // QudsPopupMenuSection(
      //     backgroundColor: Colors.yellow.shade200,
      //     titleText: 'أبو أسعد الأمير',
      //     subTitle: const Text('See your profile'),
      //     leading: const Icon(
      //       Icons.redeem,
      //       size: 40,
      //     ),
      //     subItems: [
      //       QudsPopupMenuSection(
      //           titleText: 'Settings',
      //           leading: const Icon(Icons.settings),
      //           subItems: [
      //             QudsPopupMenuItem(
      //                 leading: const Icon(Icons.logout),
      //                 title: const Text('Logout'),
      //                 onPressed: () {
      //                   // showToast('Logout Pressed!');
      //                 })
      //           ]),
      //     ]),
      // QudsPopupMenuDivider(),
      // QudsPopupMenuSection(
      //     leading: const Icon(Icons.place),
      //     titleText: 'Settings & Privacy',
      //     subItems: [
      //       QudsPopupMenuItem(
      //           leading: const Icon(Icons.settings),
      //           title: const Text('Settings'),
      //           onPressed: () {
      //             // showToast('Settings Pressed!');
      //           }),
      //       QudsPopupMenuItem(
      //           leading: const Icon(Icons.lock),
      //           title: const Text('Privacy Checkup'),
      //           onPressed: () {
      //             // showToast('Privacy Checkup Pressed!');
      //           }),
      //       QudsPopupMenuItem(
      //           leading: const Icon(Icons.lock_clock),
      //           title: const Text('Privacy Shortcuts'),
      //           onPressed: () {
      //             // showToast('Privacy Shourtcuts Pressed!');
      //           }),
      //       QudsPopupMenuItem(
      //           leading: const Icon(Icons.list),
      //           title: const Text('Activity Log'),
      //           onPressed: () {
      //             // showToast('Activity Log Pressed!');
      //           }),
      //       QudsPopupMenuItem(
      //           leading: const Icon(Icons.card_membership),
      //           title: const Text('News Feed Preferences'),
      //           onPressed: () {
      //             // showToast('News Feed Preferences Pressed!');
      //           }),
      //       QudsPopupMenuItem(
      //           leading: const Icon(Icons.language),
      //           title: const Text('Language'),
      //           onPressed: () {
      //             // showToast('Language Pressed!');
      //           }),
      //     ]),
      // QudsPopupMenuDivider(),
      // QudsPopupMenuWidget(
      //     builder: (c) => Container(
      //         padding: const EdgeInsets.all(10),
      //         child: IntrinsicHeight(
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               IconButton(
      //                   onPressed: () {
      //                     // showToast('Favourite Pressed!');
      //                   },
      //                   icon: const Icon(
      //                     Icons.favorite,
      //                     color: Colors.red,
      //                   )),
      //               const VerticalDivider(),
      //               IconButton(
      //                   onPressed: () {},
      //                   icon: const Icon(
      //                     Icons.music_note,
      //                     color: Colors.blue,
      //                   )),
      //               const VerticalDivider(),
      //               IconButton(
      //                   onPressed: () {},
      //                   icon: const Icon(
      //                     Icons.umbrella,
      //                     color: Colors.green,
      //                   ))
      //             ],
      //           ),
      //         )))
    ];
  }
}

