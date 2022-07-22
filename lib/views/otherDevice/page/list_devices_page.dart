import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_assets.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button_long.dart';
import 'package:smart_home_iot/widgets/modal/list_tile__modal_delete_bottom.dart';
import 'package:smart_home_iot/widgets/modal/list_tile_modal_text_input.dart';
import 'package:smart_home_iot/widgets/text_field_widgets.dart';

class ListDevicesPage extends StatelessWidget {
  const ListDevicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 53),
      child: RefreshIndicator(
        onRefresh: _future,
        child: ListView.builder(
            shrinkWrap: false,
            itemCount: 1,
            itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildCardDevice(context),
                )),
      ),
    );
  }

  Future<void> _future() async {
    try {} catch (err) {
      print("object");
      throw err;
    }
  }

  _buildCardDevice(BuildContext context) {
    return Card(
      // color: AppColors.huyColor,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: AppColors.inputColor, width: 1)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onLongPress: () {
          _showModalOptionCard(context);
        },
        child: Container(
          padding: const EdgeInsets.only(bottom: 5),
          height: 180,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          title: Text(
                            "Chỉ số bụi",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 19),
                          ),
                        ),
                        Image.asset(
                          AppAssets.manface,
                          width: 50,
                          height: 50,
                          // color: Colors.red,
                        ),
                        Text(
                          "89",
                          style: AppStyles.h3,
                        ),
                        Text(
                          "Tình trạng ô nhiễm",
                          style: AppStyles.text9,
                        ),
                        Text(
                          "Rất cao",
                          style: AppStyles.textMedium
                              .copyWith(color: AppColors.redColor),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: AppColors.buttonColor, width: 2))),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            "ff",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 19),
                          ),
                          subtitle: const Text(
                            "lamphuchai",
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: Text(
                                      "Temperature",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "Humidity",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "Co2",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "46",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      TextSpan(
                                        text: " %",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      )
                                    ]),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "46",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      TextSpan(
                                        text: " %",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      )
                                    ]),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "46",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      TextSpan(
                                        text: " %",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      )
                                    ]),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _showModalOptionCard(BuildContext context) {
    TextEditingController texController = TextEditingController();
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.only(top: 4),
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTileModalTextInput(
                      subtitle: Text("lamphcuhai"),
                      title: "Thay đổi  tên node",
                      onSubmit: () {},
                      textEditingController: texController),
                  listTitleModelDelete(
                      buttonDelete: () {}, context: context, label: "ff")
                ],
              ),
            ));
  }
}
