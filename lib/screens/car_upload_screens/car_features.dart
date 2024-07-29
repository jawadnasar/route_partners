import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_partners/screens/widget/drop_down_data_widget.dart';
import 'package:route_partners/screens/widget/my_text_widget.dart';
import 'package:route_partners/screens/widget/my_textfield_widget.dart';

class AddCarFeatures extends StatefulWidget {
  const AddCarFeatures({
    super.key,
  });

  @override
  State<AddCarFeatures> createState() => _AddCarFeaturesState();
}

class _AddCarFeaturesState extends State<AddCarFeatures> {
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var contr = Get.put<CarUploadController>(CarUploadController());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: "Car Features",
          ),
          Row(
            children: [
              Expanded(
                  child: MyTextField(
                // validation: (value) {
                //   if (value!.isEmpty) {
                //     return 'Enter Capacity';
                //   }
                //   return null;
                // },
                // keyBoardType: TextInputType.number,
                // controller: contr.mileage,
                // borderRadius: 10,
                hintText: 'Mileage (km)',
              )),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: DropdownDataWidget<String>(
                  items: const ['Engine Type 1', 'Engine Type 2'],
                  selectedValue: 'Engine Type 1',
                  onChanged: (String? e) {},
                  hint: 'Engine Type',
                  itemTextExtractor: (city) =>
                      'Engine Type 1', // Specify how to extract display text
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: MyTextField(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return 'Capacity is Empty';
                  }
                  return null;
                },
                // keyBoardType: TextInputType.number,
                // controller: contr.capacity,
                radius: 10,
                hintText: 'Capacity',
              )),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: DropdownDataWidget<String>(
                items: const [],
                selectedValue: '',
                onChanged: (String? e) {},
                itemTextExtractor: (city) => '',
                hint: 'Select Transmission',
              )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownDataWidget<String>(
            items: const [],
            selectedValue: '',
            onChanged: (String? e) {},
            hint: 'Select Assembly',
            itemTextExtractor: (city) => ''!,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            // controller: contr.description,
            maxLines: 3,
            radius: 10,
            hintText: 'Ad Description',
          ),
          const SizedBox(
            height: 30,
          ),
          MyText(
            text: 'Car Features',
            size: 20,
          ),

          SizedBox(
            height: Get.height * 0.02,
          ),

          // GridView.builder(
          //       physics: const NeverScrollableScrollPhysics(),
          //       itemCount: carFeatures.length,
          //       shrinkWrap: true,
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           crossAxisSpacing: 10,
          //           mainAxisSpacing: 10,
          //           childAspectRatio: 4.5),
          //       itemBuilder: (context, index) {
          //         return CheckboxListTile(
          //           splashRadius: 20,
          //           title: Text(
          //             carFeatures[index].feature!,
          //             style: Theme.of(context).textTheme.bodyMedium,
          //           ),
          //           activeColor: ColorManager.kprimary,
          //           value: carFeatures[index].isSelected,
          //           onChanged: (value) {
          //             setState(() {
          //               carFeatures[index].isSelected = value;
          //             });

          //             if (value!) {
          //               CarUploadController.i.features.add(index.toString());
          //             } else {
          //               CarUploadController.i.features.removeAt(index);
          //             }
          //             log('Selected Features: ${CarUploadController.i.features}');
          //           },
          //         );
          //       }),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
