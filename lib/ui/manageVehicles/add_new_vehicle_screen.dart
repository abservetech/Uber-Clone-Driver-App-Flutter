import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';

import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

@RoutePage()
class AddNewVehiclesPage extends StatefulWidget {
  const AddNewVehiclesPage({super.key, this.isEditPage = false, this.dateYear, this.model, this.licenceNo, this.color});
  final bool? isEditPage;
  final String? dateYear;
  final String? model;
  final String? licenceNo;
  final String? color;

  @override
  State<AddNewVehiclesPage> createState() => _AddNewVehiclesPageState();
}

class _AddNewVehiclesPageState extends State<AddNewVehiclesPage> {
  int selectedTextField = -1;
  TextEditingController modelInput = TextEditingController();
  TextEditingController yearInput =  MaskedTextController(mask: '00-00-0000');
  TextEditingController licenceInput = TextEditingController();
  TextEditingController colorInput = TextEditingController();
  String? modelErrorMessage;
  String? yearErrorMessage;
  String? licenceErrorMessage;
  String? colorErrorMessage;
  String? dropdown1ErrorMessage;
  String? dropdown2ErrorMessage;
  AppValidators validators = AppValidators();

  List<Option> options1 = [
    Option(id: 1, fieldId: "st01", value: "TVS", parentId: "d1", lft: "dd"),
    Option(id: 2, fieldId: "st01", value: "YAMAHA", parentId: "d1", lft: "dd"),
    Option(id: 3, fieldId: "st01", value: "suzuki", parentId: "d1", lft: "dd"),
    Option(id: 4, fieldId: "st01", value: "Honda", parentId: "d1", lft: "dd"),
    Option(id: 5, fieldId: "st01", value: "Bajaj", parentId: "d1", lft: "dd"),
  ];
  List<Option> options2 = [
    Option(id: 1, fieldId: "st02", value: "Mini", parentId: "d2", lft: "dd1"),
    Option(id: 2, fieldId: "st02", value: "Sedan", parentId: "d2", lft: "dd1"),
    Option(id: 3, fieldId: "st02", value: "SUV", parentId: "d2", lft: "dd1"),
  ];
  Option? selectedOption1;
  Option? selectedOption2;
  @override
  void initState() {
    super.initState();
    if(widget.isEditPage == true){
      setState(() {
        modelInput.text = widget.model ?? '';
        yearInput.text = widget.dateYear ?? '';
        licenceInput.text = widget.licenceNo ?? '';
        colorInput.text = widget.color ?? '';
        selectedOption1 = options1[1];
        selectedOption2 = options2.last;
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorData.appSecondaryColor,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          foregroundColor: AppColorData.appSecondaryColor,
          elevation: 0.9,
          pinned: true,
          floating: true,
          expandedHeight: 100,
          backgroundColor: AppColorData.appSecondaryColor,
          flexibleSpace: CommonSliverAppBar(
            title:(widget.isEditPage == true)? Strings.vehicleDetailsTitle:Strings.addVehicleTitle,
          ),
          centerTitle: false,
        ),
        SliverList(
            delegate: SliverChildListDelegate(
              [
                customDropDownButton(
                  labelText: "Make",
                  errorText: dropdown1ErrorMessage,
                  optionList: options1,
                  value: selectedOption1,
                  onChanged: (Option? newValue) {
                    setState(() {
                      selectedOption1 = newValue;
                    });
                  },
                ),
                const SizedBox(height: 8.0,),
                textFromField(
                    controller: modelInput,
                    labelText: "Model",
                    hintText: "Model",
                    errorText: modelErrorMessage,
                  keyboardType: TextInputType.text
                ),
                textFromField(
                    controller: yearInput,
                    labelText: "year",
                    hintText: "year",
                    errorText: yearErrorMessage,
                    keyboardType: TextInputType.number
                ),
                textFromField(
                    controller: licenceInput,
                    labelText: "Licence Plate",
                    hintText: "Licence Plate",
                    errorText: licenceErrorMessage,
                    keyboardType: TextInputType.text
                ),
                textFromField(
                    controller: colorInput,
                    labelText: "Color",
                    hintText: "Color",
                    errorText: colorErrorMessage,
                    keyboardType: TextInputType.text
                ),
                customDropDownButton(
                  labelText: "Service Type",
                  errorText: dropdown2ErrorMessage,
                  optionList: options2,
                  value: selectedOption2,
                  onChanged: (Option? newValue) {
                    setState(() {
                      selectedOption2 = newValue;
                    });
                  },
                ),
                const SizedBox(height: 8.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 14.0),
                  child: CommonElevatedButton(
                    height: 60,
                    elevatedButtonName: Strings.save,
                    onTap: () {
                      print("AppConstant.isPermissionGranted :11: ${AppConstant.isPermissionGranted}");
                      setState(() {
                        modelErrorMessage = validators.commonValidate(modelInput.text,"model");
                        yearErrorMessage = validators.commonValidate(yearInput.text, "year");
                        licenceErrorMessage = validators.commonValidate(licenceInput.text, "Licence No");
                        colorErrorMessage = validators.commonValidate(colorInput.text, "Color of your vehicle");
                        dropdown1ErrorMessage = validators.validateDropDown(selectedOption1);
                        dropdown2ErrorMessage = validators.validateDropDown(selectedOption2);
                      });
                      print("selectedOption1 :: $selectedOption1 \n selectedOption2 :: $selectedOption2");
                      FocusManager.instance.primaryFocus?.unfocus();
                        if (modelErrorMessage == null && yearErrorMessage == null &&
                            licenceErrorMessage == null && colorErrorMessage == null && selectedOption1 != null && selectedOption2 != null) {
                          print("all items are validate yearInput:: ${yearInput.text}");
                          //context.router.pop();
                          context.router.push(AddVehicleAndDriverDocumentsRoute());
                        }
                       else {
                        print("object else");
                      }
                    },
                  ),
                ),
              ]
            ))
      ]),
    );
  }

  Widget textFromField({
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    TextInputType? keyboardType,
    String? errorText,}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          const SizedBox(
            height: 14,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              labelText ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColorData.appPrimaryColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CommonTextFromField(
            hintText: hintText ?? '',
            border: Border.all(color: (errorText == null) ? AppColorData.appPrimaryColor: AppColorData.errorColor,),
            keyboardType: keyboardType,
            controller:controller,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          const SizedBox(height: 4.0,),
          (errorText != null)?
          Row(
            children: [
              SvgPicture.asset(SVGAssets.error_icon),
              const SizedBox(width: 10,),
              Text(errorText,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColorData.errorColor
                ),),
            ],
          ):const SizedBox.shrink()
        ],
      ),
    );
  }

 Widget customDropDownButton({
   String? errorText,
   String? labelText,
   Option? value,
   Function(Option?)? onChanged,
   required List<Option> optionList
  }){
    return Center(
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 14,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                labelText ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColorData.appPrimaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: AppColorData.appSecondaryColor,
                border: Border.all(color: (errorText == null) ? AppColorData.appPrimaryColor : AppColorData.errorColor,),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2<Option>(
                    value: value,//selectedOption,
                    barrierDismissible: true,
                    isExpanded: true,
                    hint: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColorData.grey03,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColorData.appSecondaryColor,
                      ),
                      //offset: const Offset(-10, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),

                    iconStyleData: IconStyleData(
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                        ),
                      ),
                      iconSize: 14,
                      iconEnabledColor:AppColorData.appPrimaryColor,
                      iconDisabledColor: AppColorData.grey03,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                    items: optionList.map((Option option) {
                      return DropdownMenuItem<Option>(
                        value: option,
                        child: Text(option.value ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColorData.grey03,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4.0,),
            (errorText != null)?
            Row(
              children: [
                SvgPicture.asset(SVGAssets.error_icon),
                const SizedBox(width: 10,),
                Text(errorText,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColorData.errorColor
                  ),),
              ],
            ):const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class Option {
  int? id;
  String? fieldId;
  String? value;
  dynamic parentId;
  String? lft;
  String? rgt;
  dynamic depth;
  String? status;

  Option({
    this.id,
    this.fieldId,
    this.value,
    this.parentId,
    this.lft,
    this.rgt,
    this.depth,
    this.status,
  });
}