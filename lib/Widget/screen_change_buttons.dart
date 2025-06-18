import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Screens/widget_selection.dart';

class PageChangeButton extends StatelessWidget{
  final String? name;
  final VoidCallback onTap;
  final bool? firstWidget;
  final bool? thirdWidget;
  final bool? secondWidget;

  const PageChangeButton({
    super.key,
    this.name,
    required this.onTap,
    this.firstWidget,
    this.secondWidget,
    this.thirdWidget
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40.h,
          width: 140.w,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green.shade900),
              color: Colors.greenAccent.shade100,
              borderRadius: BorderRadius.circular(20.w)
          ),
          child: Center(
            child: Text(name!,
                style: TextStyle(fontSize: 14.sp)),
          ),
        ),
      ),
    );
  }

}