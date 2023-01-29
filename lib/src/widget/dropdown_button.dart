// ignore_for_file: must_be_immutable
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/Material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  String? selectedValue;
  final Function(String)? onChanged;
  CustomDropdown({Key? key, required this.items, required this.selectedValue,required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: const Text("Select Item", style: TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis),
        items: items
            .map((item) =>
            DropdownMenuItem<String>(
              value: item,
              child: Text(
                  item, overflow: TextOverflow.ellipsis),
            )).toList(),
        value: selectedValue,
        onChanged: (value) {
          if (onChanged != null) {
            selectedValue = value as String;
            onChanged!(selectedValue!);
          }
        },
        icon: const Icon(Icons.keyboard_arrow_down,size: 20),
        iconSize: 14,
        iconEnabledColor: Colors.grey,
        iconDisabledColor: Colors.grey,
        buttonHeight: 40,
        buttonWidth: double.infinity,
        buttonPadding: const EdgeInsets.all(8),
        buttonDecoration: const BoxDecoration(
          // border: Border(left: BorderSide(color: Colors.grey),top: BorderSide(color: Colors.grey),right: BorderSide(color: Colors.grey),bottom: BorderSide(color: Colors.grey)),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        buttonElevation: 0,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 500,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(10),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-10, 0),
      ),
    );
  }
}
