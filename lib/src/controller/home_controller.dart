import 'dart:convert';
import 'dart:io';
import 'package:fashion_ai/src/shared/app_setting.dart';
import 'package:fashion_ai/src/shared/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:http/http.dart' as http;

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

  late RxnString generatedArtResponse;
  late RxnString combineArtResponse;

  @override
  void onInit() {
    super.onInit();

    ///Image selection section
    loading = false.obs;
    functionLoading = false.obs;
    selectedColor = RxnString();
    selectedStyle = RxnString();
    selectedSleeve = RxnString();
    generatedArtResponse = RxnString();
    combineArtResponse = RxnString();
    imagePath = RxnString();
    ///Generate Image section
    promptKey = GlobalKey();
    selectedArtStyle= RxnString();
    prompt = TextEditingController();
    steps = TextEditingController();
    numberOfImage = TextEditingController(text: '1');
    height = TextEditingController(text: '512');
    weight = TextEditingController(text: '512');
    seed = TextEditingController(text: '47');
    ///Position Section
    positionRadioValue = 0.obs;
  }

  void previewTShirtOnChange(){
    if(selectedColor.value!=null && selectedStyle.value!=null && selectedSleeve.value!=null){
      imagePath.value = 'color_${selectedColor.value!.toLowerCase()}_style_${selectedStyle.value!.toLowerCase()}_sleeve_${selectedSleeve.value!.toLowerCase()}.jpg';
    }
  }

  Future<void> generateImage()async{
    if(promptKey.currentState!.validate()){
      if(selectedArtStyle.value!=null){
        if(imagePath.value!=null){
          if(functionLoading.value==false){
            try{
              generatedArtResponse = RxnString();
              functionLoading(true);
              showToast('Generating Art. It will take few minutes');
              var bodyData = jsonEncode({
                "prompt": prompt.text,
                "ddim_steps": 4,
                "H": double.parse(height.text),
                "W": double.parse(weight.text),
                "n_samples": int.parse(numberOfImage.text),
                "seed": int.parse(seed.text),
                "style": "S${AppString.artStyleList.indexOf(selectedArtStyle.value!)+1}"
              });
              http.Response response = await http.post(
                  Uri.parse("${AppString.baseUrl}${AppString.generateArt}"),
                  headers: {
                    'accept': 'application/json',
                    'Content-Type': 'application/json'
                  },
                  body: bodyData
              );
              if(response.statusCode==200){
                generatedArtResponse.value = jsonDecode(response.body).toString();
                print('Generate image response: ${generatedArtResponse.value}');
                functionLoading(false);
              }else{
                functionLoading(false);
                showToast('Art generation failed');
              }
            }on SocketException{
              functionLoading(false);
              showToast("No internet connection");
            }catch(error){
              functionLoading(false);
              showToast(error.toString());
              print(error.toString());
            }
          }else{showToast("Another process is running");}
        } else{showToast("Select T-shirt style first");}
      }else{showToast("Select art style");}
    }
  }

  Future<void> combineImage()async{
    if(functionLoading.value==false){
      if(imagePath.value!=null){
        if(generatedArtResponse.value!=null){
          try{
            combineArtResponse = RxnString();
            functionLoading(true);
            var bodyData = jsonEncode({
              "colorname": "${selectedColor.toLowerCase()}",
              "stylename": "${selectedStyle.toLowerCase()}",
              "sleevestyle": "${selectedSleeve.toLowerCase()}",
              "position": AppString.positionList[positionRadioValue.value].toLowerCase()
            });
            http.Response response = await http.post(
                Uri.parse("${AppString.baseUrl}${AppString.combineArt}"),
                headers: {
                  'accept': 'application/json',
                  'Content-Type': 'application/json'
                },
                body: bodyData
            );
            if(response.statusCode==200){
              combineArtResponse.value = jsonDecode(response.body).toString();
              print('Combine image response: ${combineArtResponse.value}');
              functionLoading(false);
            }else{
              functionLoading(false);
              showToast('Art combine failed');
            }
          }on SocketException{
            functionLoading(false);
            showToast("No internet connection");
          }catch(error){
            functionLoading(false);
            showToast(error.toString());
            print(error.toString());
          }
        }else{showToast('Generate art first');}
      }else{showToast('Select T-shirt style first');}
    }else{showToast('Another process is running');}
  }
}