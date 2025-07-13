import 'package:expense_tracker/constant/extensions.dart' as s;
import 'package:expense_tracker/constant/my_image.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar(
      {super.key,
      required this.title,
      this.drawerOnTap,
      this.hasDrawer = true,
      this.action,
      this.noLeadingIcon = false});
  final Widget title;
  final Function()? drawerOnTap;
  final bool? hasDrawer;
  final Widget? action;
  final bool? noLeadingIcon;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: preferredSize.height,
      color: MyTheme.bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (noLeadingIcon == false) ...[
                if (hasDrawer == true)
                  InkWell(
                    onTap: drawerOnTap,
                    child: Image.asset(
                      MyImage.drawerIcon,
                      height: 20,
                      width: 20,
                    ),
                  )
                else
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios)),
              ],
              20.hGap,
              title
            ],
          ),
          action ?? const SizedBox()
        ],
      ),
    );
  }
}
