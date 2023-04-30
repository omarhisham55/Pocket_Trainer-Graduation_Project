import 'package:final_packet_trainer/navigation/cubit/cubit.dart';
import 'package:final_packet_trainer/navigation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

//Done


class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CubitManager(),
      child: BlocConsumer<CubitManager, MainStateManager>(
        listener: (_, state) {
          if(state is GetPaymentMethod){
            print(state);
          }
        },
        builder: (_, state){
          List<String> payment = CubitManager.get(_).paymentMethod();
          CubitManager radioButton = CubitManager.get(_);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.black,
              leading: IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ),
            body: Column(
              children: [
                //Plan info
                Container(
                  padding: const EdgeInsets.all(20),
                  color: BackgroundColors.blackBG,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText(text: 'Your plan'),
                      //your plan in container
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: BackgroundColors.whiteBG,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //colored section in container
                              Container(
                                decoration: BoxDecoration(
                                  color: (payment[0] == "Silver Plan") ? Colors.grey : Colors.yellow,
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      subTitleText(text: payment[0]),
                                      const Spacer(),
                                      subTitleText(text: "${payment[1]} EGP")
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    paragraphText(text: 'Starting today for ${payment[2]} months', fontWeight: FontWeight.w500, color: BackgroundColors.blackBG),
                                    const SizedBox(height: 5),
                                    paragraphText(text: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} until DD/MM/YYYY', color: BackgroundColors.blackBG)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //Payment
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1)
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: radioButton.paymentGroupRadio,
                                activeColor: BackgroundColors.blackBG,
                                onChanged: (value) {
                                  radioButton.changeRadioButton(value);
                                },
                              ),
                              subTitleText(text: "Vodafone Cash", color: TextColors.blackText, fontWeight: FontWeight.w400)
                            ],
                          ),
                        ),
                        const Divider(thickness: 1, color: BackgroundColors.blackBG),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: radioButton.paymentGroupRadio,
                              activeColor: BackgroundColors.blackBG,
                              onChanged: (value) {
                                radioButton.changeRadioButton(value);
                              },
                            ),
                            subTitleText(text: "Fawry", color: TextColors.blackText, fontWeight: FontWeight.w400)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                //submit button
                Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: DefaultButton(
                        width: MediaQuery.of(context).size.width*.5,
                        function: (){
                        },
                        backgroundColor: BackgroundColors.button,
                        borderRadius: 30,
                        text: "Submit"
                    )
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}