import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/model/evaluation.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';

class CommentWidget extends StatefulWidget {
  String label;
  Evaluation evaluation;

  CommentWidget({
    @required this.label,
    @required this.evaluation
  });

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
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
      height: 200,
      width: double.maxFinite,
      decoration: ContainerDecoration(radius: 15),
      child: TextField(
        controller: _controller,
        decoration: _searchDecoration(widget.label),
        onSubmitted: (text) {
          widget.evaluation.comment = text;
        },
        onChanged: (text) {
          widget.evaluation.comment = text;
        },
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
