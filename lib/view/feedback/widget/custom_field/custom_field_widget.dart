import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';

class CustomFieldWidget extends StatefulWidget {
  double height;
  String label;

  CustomFieldWidget({
    @required this.height,
    @required this.label
  });

  @override
  _CustomFieldWidgetState createState() => _CustomFieldWidgetState();
}

class _CustomFieldWidgetState extends State<CustomFieldWidget> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: ContainerDecoration(radius: 15),
      child: TextField(
          controller: _controller,
          decoration: _searchDecoration(widget.label),
          onSubmitted: (text) {}
      ),
    );
  }
}

InputDecoration _searchDecoration(String text) =>
    InputDecoration(
        hintText: text,
        hintStyle: AppFonts.montserratLight(fontSize: 13, color: AppColors.mediumGrey),
        border: _border(),
        focusedBorder: _border(),
        enabledBorder: _border(),
        disabledBorder: _border(),
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.only(left: 20, right: 50)
    );

OutlineInputBorder _border() =>
    OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(style: BorderStyle.none,)
    );
