import 'package:flutter/material.dart';
import 'package:fsauce_vendor_app/app/components/common_image_view.dart';
import 'package:fsauce_vendor_app/app/constants/image_constant.dart';
import 'package:fsauce_vendor_app/app/services/text_style_util.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool isBackable;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.isBackable = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyleUtil.manrope18w600()),
      centerTitle: true,
      leading: isBackable ? (leading ?? _defaultBackButton(context)) : null,
      actions: actions,
      surfaceTintColor: Colors.white,
      foregroundColor: const Color(0xffFAFAFA),
      backgroundColor: const Color(0xffFAFAFA),
    );
  }

  Widget _defaultBackButton(BuildContext context) {
    return IconButton(
      icon: CommonImageView(
        svgPath: ImageConstant.backIcon,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
