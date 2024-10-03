import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/list_employers/widgtes/item_employer_widget.dart';

class ListEmployerWidget extends StatelessWidget {
  final String nameList;
  final List<Employer> listEmp;

  const ListEmployerWidget(
      {super.key, required this.nameList, required this.listEmp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nameList,
            style: AppTextStyle.textLg.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  listEmp.length,
                      (index) =>
                      Row(children: [
                        GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(
                              //     context, RouteName.detailEmployer,
                              //     arguments: listEmp[index]);
                            },
                            child: ItemEmployerWidget(item: listEmp[index])),
                        SizedBox(
                          width: 10.w,
                        )
                      ])),
            ),
          )
        ],
      ),
    );
  }
}
