import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_label_text_field.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/appbar_gradient_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/list_employers/widgtes/item_employer_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/list_employers/widgtes/list_employer_widget.dart';

class ListEmployerScreen extends StatefulWidget {
  final bool? isBottomTab;

  const ListEmployerScreen({super.key, this.isBottomTab = false});

  @override
  State<ListEmployerScreen> createState() => _ListEmployerScreenState();
}

class _ListEmployerScreenState extends State<ListEmployerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: tr("employer"),
          leading: widget.isBottomTab!
              ? null
              : const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
          leadingAction: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  tr("exploreCompanyCulture"),
                  style: AppTextStyle.textBase
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomLabelTextField(
                  radius: 30.r,
                  maxLine: 1,
                  hintText: tr("typeNameEmployer"),
                  textStyleHint: AppTextStyle.textSm,
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.grey,
                    size: 30.r,
                  ),
                  backgroundColor: AppColors.white,
                  colorBorder: Colors.grey,
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListEmployerWidget(
                      nameList: tr("hotEmployer"), listEmp: Data.listEmployers),
                  Container(
                    color: AppColors.greyE5,
                    height: 20.h,
                  ),
                  ListEmployerWidget(
                      nameList: tr("highestFollowEmployer"),
                      listEmp: Data.listEmployers),
                  Container(
                    color: AppColors.greyE5,
                    height: 20.h,
                  ),
                  ListEmployerWidget(
                      nameList: tr("employerDoing"),
                      listEmp: Data.listEmployers),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Data {
  static Employer employer1 = Employer(
      nameEmployer: "Công ty Cổ Phần Chứng khoán KBS Việt nam",
      numberFollow: 209,
      numberJobs: 9,
      field: 'Chứng khoán',
      avatar:
          "https://images02.vietnamworks.com//companyprofile/kb-securities-viet-nam-join-stock-company/en/MicrosoftTeams-image_4_.png?v=1716348563",
      headQuarters:
          "Tầng 16 và 17, Tháp 02 tòa nhà Captial Place,Số 29 Liễu Giai, phường Ngọc Khánh, quận Ba Đình, Hà Nội.",
      scale: "100-499 nhân viên",
      introduce:
          "Công ty Cổ phần Chứng khoán KB Việt Nam (KBSV), một thành viên của KB Securities và Tập đoàn Tài chính KB (Hàn Quốc), là một công ty chứng khoán chuyên nghiệp tại Việt Nam, có năng lực chuyên môn và kinh nghiệm đa dạng trong lĩnh vực chứng khoán. Chúng tôi cung cấp Dịch vụ Chứng khoán và Dịch vụ Ngân hàng đầu tư chuyên nghiệp cho các Khách hàng gồm các doanh nghiệp, nhà đầu tư tổ chức và các nhà đầu tư cá nhân"
          "Được thành lập vào năm 2008, KBSV có Trụ sở chính tại Hà Nội và hai chi nhánh tại Hà Nội và TP Hồ Chí Minh. Với đội ngũ gồm trên 400 nhân sự được đào tạo bài bản, thương hiệu Chứng khoán KBSV ngày càng được khẳng định."
          "Danh sách chuyên viên đã được cấp Chứng chỉ Hành nghề của Uỷ Ban Chứng Khoán Nhà nước được cập nhật tại đây.",
      images:
          "https://thoibaotaichinhvietnam.vn/stores/news_dataimages/thoibaotaichinhvietnamvn/082020/28/14/cong-ty-chung-khoan-kb-viet-nam-tu-tin-vuot-kho-tu-nhung-uu-the-rieng-co-12-.0644.jpg;https://www.kbsec.com.vn/pic/News/images/kb-20-15450360559441667709928-crop-1545036068848942262717.jpg;https://cdn24hmoney.24hstatic.com/upload/images_cr/2022-06-28/stores/news_dataimages/thanhhuong/062022/28/19/in_article/1e3205e1634e2ded6da258874efd896d.jpg",
      welfare: List.of({
        "Theo quy định của công ty",
        "Bảo hểm theo quy định của nhà nước",
        "Môi trường lam việc chuyên nghiệp, cơ hội thăng tiến",
        "Du lịch, hoạt động ngoài trời cùng công ty",
        "Cơ hội tiếp xúc với dữ liệu lớn"
      }));
  static Employer employer2 = Employer(
      nameEmployer: "Spin Master (VietNam) Company Limited",
      numberFollow: 277,
      numberJobs: 1,
      field: "Nghệ thuật/Giải trí",
      avatar:
          "https://upload.wikimedia.org/wikipedia/en/thumb/4/46/Spin_Master_logo.png/220px-Spin_Master_logo.png",
      headQuarters:
          "Tầng 16 và 17, Tháp 02 tòa nhà Captial Place,Số 29 Liễu Giai, phường Ngọc Khánh, quận Ba Đình, Hà Nội.",
      scale: "1000-4.999 nhân viên",
      introduce:
          "Công ty Cổ phần Chứng khoán KB Việt Nam (KBSV), một thành viên của KB Securities và Tập đoàn Tài chính KB (Hàn Quốc), là một công ty chứng khoán chuyên nghiệp tại Việt Nam, có năng lực chuyên môn và kinh nghiệm đa dạng trong lĩnh vực chứng khoán. Chúng tôi cung cấp Dịch vụ Chứng khoán và Dịch vụ Ngân hàng đầu tư chuyên nghiệp cho các Khách hàng gồm các doanh nghiệp, nhà đầu tư tổ chức và các nhà đầu tư cá nhân"
          "Được thành lập vào năm 2008, KBSV có Trụ sở chính tại Hà Nội và hai chi nhánh tại Hà Nội và TP Hồ Chí Minh. Với đội ngũ gồm trên 400 nhân sự được đào tạo bài bản, thương hiệu Chứng khoán KBSV ngày càng được khẳng định."
          "Danh sách chuyên viên đã được cấp Chứng chỉ Hành nghề của Uỷ Ban Chứng Khoán Nhà nước được cập nhật tại đây.",
      images:
          "https://media.licdn.com/dms/image/D5622AQHQPaeZNqur0A/feedshare-shrink_800/0/1697849749998?e=2147483647&v=beta&t=AkNvArE8IOzITwJ6yxphj6zT1vGHBFz-i1KjSvVN73E",
      welfare: List.of({
        "Theo quy định của công ty;Bảo hiểm",
        "Bảo hểm theo quy định của nhà nước",
        "Môi trường lam việc chuyên nghiệp, cơ hội thăng tiến"
      }));
  static Employer employer3 = Employer(
      nameEmployer: "VinGroup",
      numberFollow: 5142,
      numberJobs: 9,
      field: 'Kỹ thuật xây dựng/Cơ sở hạ tầng',
      avatar:
          "https://upload.wikimedia.org/wikipedia/vi/thumb/9/98/Vingroup_logo.svg/150px-Vingroup_logo.svg.png",
      headQuarters: "7 Bằng Lăng 1 Vinhomes Riverside,Long Biên, Hà Nội",
      scale: "100-499 nhân viên",
      introduce:
          "Tiền thân của Vingroup là Tập đoàn Technocom, thành lập năm 1993 tại Ucraina. Đầu những năm 2000, Technocom trở về Việt Nam, tập trung đầu tư vào lĩnh vực du lịch và bất động sản với hai thương hiệu chiến lược ban đầu là Vinpearl và Vincom. Đến tháng 1/2012, công ty CP Vincom và Công ty CP Vinpearl sáp nhập, chính thức hoạt động dưới mô hình Tập đoàn với tên gọi Tập đoàn Vingroup – Công ty CP.",
      images:
          "https://maisonoffice.vn/wp-content/uploads/2023/12/2-vingroup-la-tap-doan-kinh-te-co-von-dieu-le-lon-nhat-thi-truong-viet-nam.jpg;https://maisonoffice.vn/wp-content/uploads/2023/12/5-tru-so-vingrouo-tai-tphcm.jpg;https://ircdn.vingroup.net/storage/public/2019/07/DJI_0030-fixed2-mini-20190727T100030844048.jpg",
      welfare: List.of({
        "Theo quy định của công ty;Bảo hiểm",
        "Bảo hểm theo quy định của nhà nước",
        "Môi trường lam việc chuyên nghiệp, cơ hội thăng tiến"
      }));

  static List<Employer> listEmployers =
      List.of({employer1, employer2, employer3});
}
