import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông báo",
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.remove))],
      ),
      body: ListView(
        shrinkWrap: false,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 20, right: 10),
            leading: const CircleAvatar(
              backgroundImage:
                  NetworkImage("https://s3.o7planning.com/images/boy-128.png"),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.more_horiz,
                size: 20,
              ),
              onPressed: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    context: context,
                    builder: (context) => Container(
                          height: 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://s3.o7planning.com/images/boy-128.png"),
                                    ),
                                    Text(
                                      "noi dung thong bao fff",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  print("delete thongbao");
                                },
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.inputColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Icon(
                                    Icons.clear,
                                    color: AppColors.black,
                                  ),
                                ),
                                title: Text("Xóa thông báo này"),
                              )
                            ],
                          ),
                        ));
              },
            ),
            title: Text(
              "Lam phuc hai",
              style: AppStyles.textSubtitle,
            ),
            subtitle: Text("lamphcuhalamphcmphcuh"),
          )
        ],
      ),
    );
  }
}
