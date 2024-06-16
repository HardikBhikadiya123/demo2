import 'package:demo2/theme/Appcolors.dart';
import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatefulWidget {
  final TextEditingController titalTextController;
  final bool readOnly;
  final FocusNode titalFocusNode;
  final String hintText;
  final Function(String) validator;
  final Function(String) onSubmit;
  const InputTextFieldWidget({super.key, required this.titalTextController, required this.readOnly, required this.titalFocusNode, required this.hintText, required this.validator, required this.onSubmit});

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 1, 0),
      child: TextFormField(
        controller: widget.titalTextController,
        focusNode: widget.titalFocusNode,
        autofocus: false,
        readOnly: widget.readOnly,
        obscureText: false,
        decoration: InputDecoration(
          hintText: "Enter ${widget.hintText}",
          hintStyle: TextStyle(
            fontFamily: 'Readex Pro',
            fontSize: 14,
            color: AppColors.SecondaryText,
            letterSpacing: 0,
          ),
          errorStyle: TextStyle(
            fontFamily: 'Readex Pro',
            fontSize: 12,
            color: AppColors.Error,
            letterSpacing: 0.3,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.SecondaryText,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.Primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.Error,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.Error,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),

        style: TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 14,
          color: AppColors.white,
          letterSpacing: 0,
        ),
        cursorColor: Colors.transparent,
        validator:(value) => widget.validator(value!),
        onChanged: (value) {
          widget.onSubmit(value!);
        },
      ),
    );
  }
}