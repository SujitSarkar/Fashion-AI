import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomeController extends GetxController{

  late RxBool loading;
  late RxBool functionLoading;
  Socket? socket;

  ///Image selection section
  late RxnString selectedColor;
  late RxnString selectedStyle;
  late RxnString selectedSleeve;
  late RxnString imagePath;

  ///Generate Image section
  late GlobalKey<FormState> promptKey;
  late RxnString selectedArtStyle;
  late TextEditingController prompt;
  late TextEditingController steps;
  late TextEditingController numberOfImage;
  late TextEditingController height;
  late TextEditingController weight;
  late TextEditingController seed;

  ///Position section
  late RxInt positionRadioValue;

  @override
  void onInit() {
    super.onInit();

    ///Image selection section
    loading = false.obs;
    functionLoading = false.obs;
    selectedColor = RxnString();
    selectedStyle = RxnString();
    selectedSleeve = RxnString();
    imagePath = RxnString();
    ///Generate Image section
    promptKey = GlobalKey();
    selectedArtStyle= RxnString();
    prompt = TextEditingController();
    steps = TextEditingController();
    numberOfImage = TextEditingController();
    height = TextEditingController();
    weight = TextEditingController();
    seed = TextEditingController();
    ///Position Section
    positionRadioValue = 0.obs;
  }

  void previewTShirtOnChange(){
    if(selectedColor.value!=null && selectedStyle.value!=null && selectedSleeve.value!=null){
      imagePath.value = 'color_${selectedColor.value!.toLowerCase()}_style_${selectedStyle.value!.toLowerCase()}_sleeve_${selectedSleeve.value!.toLowerCase()}.jpg';
    }
  }

  Future<void> promptSubmitButtonOnTap()async{
    if(promptKey.currentState!.validate()){}
  }
}