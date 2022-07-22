import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_styles.dart';

class ListTileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Widget? subtitle;
  const ListTileWidget(
      {Key? key, required this.onTap, required this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 20, right: 12),
      onTap: onTap,
      title: Text(
        title,
        style: AppStyles.textLarge,
      ),
      trailing: const Icon(
        Icons.chevron_right,
      ),
      subtitle: subtitle,
    );
  }
}
