import 'package:fashion_ai/src/shared/app_string.dart';
import 'package:fashion_ai/src/controller/home_controller.dart';
import 'package:fashion_ai/src/widget/card_widget.dart';
import 'package:fashion_ai/src/widget/dropdown_button.dart';
import 'package:fashion_ai/src/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Obx(() => Stack(
                children: [
                  Scaffold(
                    body: _bodyUI(controller, context, size),
                    backgroundColor: Colors.blueGrey.withOpacity(.2),
                  ),
                  if (controller.loading.value) const LoadingWidget()
                ],
              ));
        });
  }

  Widget _bodyUI(HomeController controller, BuildContext context, Size size) =>
      SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * .1, vertical: size.width * .01),
          child: Column(children: [
            ///Select T-Shirt Section
            tShirtWidget(controller, context, size),
            SizedBox(height: size.width*.03),

            ///Generate Image Section
            generateImageWidget(controller, context, size),
            SizedBox(height: size.width*.03),

            ///Final Section
            positionWidget(controller, context, size)

          ]));

  CardWidget tShirtWidget(HomeController controller, BuildContext context, Size size)=>CardWidget(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Left Section
            Expanded(
              flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(right: size.width*.03),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///Color Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Row(
                            children: [
                              Text("Color: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                      Theme.of(context).primaryColor)),
                              Expanded(
                                  child: CustomDropdown(
                                      items: AppString.colorList,
                                      selectedValue:
                                      controller.selectedColor.value,
                                      onChanged: (value) {
                                        controller.selectedColor.value =
                                            value;
                                        controller.previewTShirtOnChange();
                                      }))
                            ],
                          ),
                        ),
                        SizedBox(height: size.width * .02),

                        ///Style Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(5))),
                          child: Row(
                            children: [
                              Text("Style: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                      Theme.of(context).primaryColor)),
                              Expanded(
                                  child: CustomDropdown(
                                      items: AppString.styleList,
                                      selectedValue:
                                      controller.selectedStyle.value,
                                      onChanged: (value) {
                                        controller.selectedStyle.value =
                                            value;
                                        controller.previewTShirtOnChange();
                                      }))
                            ],
                          ),
                        ),
                        SizedBox(height: size.width * .02),

                        ///Sleeve Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(5))),
                          child: Row(
                            children: [
                              Text("Sleeve: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                      Theme.of(context).primaryColor)),
                              Expanded(
                                  child: CustomDropdown(
                                      items: AppString.sleeveList,
                                      selectedValue:
                                      controller.selectedSleeve.value,
                                      onChanged: (value) {
                                        controller.selectedSleeve.value =
                                            value;
                                        controller.previewTShirtOnChange();
                                      }))
                            ],
                          ),
                        ),
                        SizedBox(height: size.width * .04),

                        ///Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: (){},
                            child: const Text('Submit',style: TextStyle(fontSize: 16)),
                          ),
                        )
                      ]),
                )),

            ///Right Section
            Expanded(
              flex: 3,
                child: controller.imagePath.value!=null?
                Image.asset('assets/static_tshirt/${controller.imagePath}',
                  height: size.width * .25,
                  width: size.width * .25,
                  fit: BoxFit.fitHeight,
                )
                    :Icon(Icons.image,
                    color: Colors.grey.shade400, size: size.width * .25))
          ]));

  CardWidget generateImageWidget(HomeController controller, BuildContext context, Size size)=>CardWidget(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Left Section
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(right: size.width*.03),
                  child: Form(
                    key: controller.promptKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ///Art Style Dropdown
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Row(
                              children: [
                                Text("Art Style: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                        Theme.of(context).primaryColor)),
                                Expanded(
                                    child: CustomDropdown(
                                        items: AppString.artStyleList,
                                        selectedValue:
                                        controller.selectedArtStyle.value,
                                        onChanged: (value) {
                                          controller.selectedArtStyle.value =
                                              value;
                                          controller.previewTShirtOnChange();
                                        }))
                              ],
                            ),
                          ),
                          SizedBox(height: size.width * .02),

                          ///Prompt
                          TextFormField(
                            controller: controller.prompt,
                            validator: (val) =>
                            val != null && val.isNotEmpty
                                ? null
                                : "Field can't be empty",
                            minLines: 3,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(),
                              label: Text('Prompt'),
                            ),
                          ),
                          SizedBox(height: size.width * .02),

                          ///Number of image & Seed
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.numberOfImage,
                                  validator: (val) =>
                                  val != null && val.isNotEmpty
                                      ? null
                                      : "Field can't be empty",
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text('Number of image')
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width*.01),

                              Expanded(child: TextFormField(
                                controller: controller.seed,
                                validator: (val) =>
                                val != null && val.isNotEmpty
                                    ? null
                                    : "Field can't be empty",
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text('Seed')
                                ),
                              ),)
                            ],
                          ),
                          SizedBox(height: size.width * .02),

                          ///Image height
                          TextFormField(
                            controller: controller.height,
                            validator: (val) =>
                            val != null && val.isNotEmpty
                                ? null
                                : "Field can't be empty",
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Image height')
                            ),
                          ),
                          SizedBox(height: size.width * .02),

                          ///Image width
                          TextFormField(
                            controller: controller.weight,
                            validator: (val) =>
                            val != null && val.isNotEmpty
                                ? null
                                : "Field can't be empty",
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Image width')
                            ),
                          ),
                          SizedBox(height: size.width * .04),

                          ///Submit Button
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: ()async{
                                await controller.promptSubmitButtonOnTap();
                              },
                              child: const Text('Submit',style: TextStyle(fontSize: 16)),
                            ),
                          )
                        ]),
                  ),
                )),

            ///Right Section
            Expanded(
                flex: 3,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.width<1200?2:3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10
                  ),
                  itemCount: 9,
                  itemBuilder: (context,index)=> InkWell(
                    onTap: (){},borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: const BorderRadius.all(Radius.circular(8))
                      ),
                    ),
                  ),
                )
            )
          ]));

  CardWidget positionWidget(HomeController controller, BuildContext context, Size size)=>CardWidget(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Left Section
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(right: size.width*.03),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Image Position on T-Shirt: ',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16)),
                            Expanded(
                              child: Row(
                                children: AppString.positionList.map((item) => Expanded(
                                  child: RadioListTile(
                                      title: Text(item),
                                      contentPadding: EdgeInsets.zero,
                                      value: AppString.positionList.indexOf(item),
                                      groupValue: controller.positionRadioValue.value,
                                      onChanged: (val){
                                        controller.positionRadioValue.value = int.parse(val.toString());
                                      }
                                  ),
                                )).toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.width*.02),

                        ///Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: (){},
                            child: const Text('Submit',style: TextStyle(fontSize: 16)),
                          ),
                        )
                      ]),
                )),

            ///Right Section
            Expanded(
                flex: 3,
                child: Icon(Icons.image,
                    color: Colors.grey.shade400, size: size.width * .25))
          ]));

}
