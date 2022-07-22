import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button_long.dart';
import 'package:smart_home_iot/widgets/text_field_widgets.dart';

class ListTileModalTextInput extends StatelessWidget {
  final VoidCallback onSubmit;
  final String title;
  final Widget? subtitle;
  final TextEditingController textEditingController;
  final String? titleModal;
  const ListTileModalTextInput(
      {Key? key,
      this.titleModal,
      required this.title,
      required this.onSubmit,
      this.subtitle,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 20, right: 12),
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            context: context,
            builder: (context) => Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          titleModal ?? "Thay đổi tên gọi",
                          style: AppStyles.h4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFieldWidgets(
                            textController: textEditingController,
                            autofocus: true,
                          ),
                        ),
                        AppButtonLong(
                            label: "Lưu lại",
                            onPressed: onSubmit,
                            color: AppColors.buttonColor)
                      ],
                    ),
                  ),
                ));
      },
      title: Text(
        title,
        style: AppStyles.textLarge,
      ),
      subtitle: subtitle,
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
