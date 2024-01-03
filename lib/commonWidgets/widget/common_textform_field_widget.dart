import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';

class CommonTextFromField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enabled;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final bool? obscureText;

  final int? maxLines;
  final int? maxLength;
  final double? height;
  final double? width;
  final bool? autofocus;
  final Function()? onTap;
  final bool? filled;
  final BoxBorder? border;

  const CommonTextFromField(
      {super.key,
      this.controller,
      this.hintText,
      this.labelText,
      this.onChanged,
      this.validator,
      this.inputFormatters,
      this.prefixIcon,
      this.suffixIcon,
      this.enabled,
      this.fillColor,
      this.contentPadding,
      this.keyboardType,
      this.obscureText = false,
      Function(dynamic newValue)? onSaved,
      this.maxLines = 1,
      this.maxLength,
      this.height,
      this.width,
      this.onFieldSubmitted,
      this.autofocus = false,
      this.onTap,
      this.filled,
      this.border});

  @override
  State<CommonTextFromField> createState() => _CommonTextFromFieldState();
}

final List<String> errors = [];

class _CommonTextFromFieldState extends State<CommonTextFromField> {
  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: widget.height ?? 60,
      //MediaQuery.of(context).size.height * 0.09,
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.fillColor,
          border: widget.border,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: TextFormField(
            onTap: widget.onTap,
            autofocus: widget.autofocus ?? false,
            cursorColor: AppColorData.appPrimaryColor,
            enabled: widget.enabled,
            controller: widget.controller,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText!,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            style: TextStyle(
              fontSize: 16,
              color: AppColorData.grey03,
              fontWeight: FontWeight.normal,
            ),
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onFieldSubmitted,

            /*validator: (value) {
              return widget.validator!(value);
              },*/
            validator: widget.validator,
            decoration: InputDecoration(
              filled: widget.filled,
              fillColor: widget.fillColor,
              focusColor: AppColorData.appSecondaryColor,
              prefixIcon: widget.prefixIcon,
              isDense: true,
              prefixIconConstraints: BoxConstraints(
                minWidth: 35,
              ),
              // prefix: widget.prefixIcon,
              prefixIconColor: AppColorData.white01,
              suffixIcon: widget.suffixIcon,
              suffixIconColor: AppColorData.white01,
              contentPadding: widget.contentPadding,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              /*border: OutlineInputBorder(
             borderSide:
             BorderSide(color: AppColorData.grey, width: 1),
             borderRadius: BorderRadius.circular(10),
           ),
           enabledBorder: OutlineInputBorder(
             borderSide:
             BorderSide(color: AppColorData.appPrimaryColor, width: 1),
             borderRadius: BorderRadius.circular(10),
           ),
           focusedBorder: OutlineInputBorder(
             borderSide:
             BorderSide(color: AppColorData.appPrimaryColor, width: 1),
             borderRadius: BorderRadius.circular(10),
           ),*/
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: AppColorData.grey03,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color: AppColorData.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )),
      ),
    );
  }
}
class MaskedTextController extends TextEditingController {
  MaskedTextController({String? text, this.mask, Map<String, RegExp>? translator})
      : super(text: text) {
    this.translator = translator ?? MaskedTextController.getDefaultTranslator();

    addListener(() {
      final String previous = _lastUpdatedText;
      if (this.beforeChange(previous, this.text)) {
        updateText(this.text);
        this.afterChange(previous, this.text);
      } else {
        updateText(_lastUpdatedText);
      }
    });

    updateText(this.text);
  }

  String? mask;

  late Map<String, RegExp> translator;

  Function afterChange = (String previous, String next) {};
  Function beforeChange = (String previous, String next) {
    return true;
  };

  String _lastUpdatedText = '';

  void updateText(String text) {
    if (text != null) {
      this.text = _applyMask(mask, text);
    } else {
      this.text = '';
    }

    _lastUpdatedText = this.text;
  }

  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    updateText(text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    final String text = _lastUpdatedText;
    selection =
        TextSelection.fromPosition(TextPosition(offset: (text ?? '').length));
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return <String, RegExp>{
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*')
    };
  }

  String _applyMask(String? mask, String value) {
    String result = '';

    int maskCharIndex = 0;
    int valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask!.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      final String maskChar = mask[maskCharIndex];
      final String valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (translator.containsKey(maskChar)) {
        if (translator[maskChar]!.hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}