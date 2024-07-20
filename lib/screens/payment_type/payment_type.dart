import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/controllers/payment_type_controller.dart';
import 'package:route_partners/core/constants/app_colors.dart';
import 'package:route_partners/core/utils/snackbars.dart';
import 'package:route_partners/screens/widget/my_button_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/simple_app_bar_widget.dart';

class PaymentTypeScreen extends StatelessWidget {
  const PaymentTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cont = Get.put<PaymentTypeController>(PaymentTypeController());
    return Scaffold(
      appBar: simpleAppBar(title: "Select Payment Type"),
      body: GetBuilder<PaymentTypeController>(builder: (cont) {
        return Column(
          children: [
            ListView.builder(
              itemCount: cont.paymentTypes.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RadioListTile<String>(
                  title: MyText(text: cont.paymentTypes[index]),
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: cont.paymentTypes[index],
                  groupValue: cont.selectPayment,
                  onChanged: (value) {
                    cont.updateSelectedPayment(value.toString());
                  },
                );
              },
            ),
           const  Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyButton(
                
                  bgColor: kPrimaryColor,
                  textColor: Colors.white,
                  onTap: () {
                    CustomSnackBars.instance.showFailureSnackbar(
                        title: "Coming Soon",
                        message: "Online Payment will be added Soon");
                  }),
            )
          ],
        );
      }),
    );
  }
}
