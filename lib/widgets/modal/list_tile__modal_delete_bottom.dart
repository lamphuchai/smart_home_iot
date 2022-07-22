import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button.dart';

Widget listTitleModelDelete(
    {required BuildContext context,
    required VoidCallback buttonDelete,
    required String label}) {
  return ListTile(
    contentPadding: const EdgeInsets.only(left: 20, right: 12),
    onTap: () {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          context: context,
          builder: (context) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      label,
                      style: AppStyles.h4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppButton(
                            lable: "OK",
                            onPressed: buttonDelete,
                            color: AppColors.redColor),
                        AppButton(
                            lable: AppLocalizations.of(context)
                                .translate("cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: AppColors.buttonColor)
                      ],
                    )
                  ],
                ),
              ));
    },
    title: Text(
      AppLocalizations.of(context).translate("delete"),
      style: AppStyles.textLarge,
    ),
    trailing: const Icon(
      Icons.delete,
      color: AppColors.redColor,
    ),
  );
}
