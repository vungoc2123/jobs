class AppDeepLink {
  //Quản lý thông tin người lao động là công dân nước ngoài làm việc tại Việt Nam trên app mobile
  static String manageNewWorkerForeignInVn =
      "/QLTTNguoiLaoDongArea/QLTTNguoiLaoDongNuocNgoai/CreateAPI";

  // Quản lý thông tin người lao động Việt Nam đi làm việc ở nước ngoài theo hợp đồng trên app mobile
  static String manageNewWorkerVnInForeign =
      "/QLTTNguoiLaoDongArea/QLTTNguoiLaoDongVietNam/CreateAPI";

  //Quản lý thông tin khu công nghiệp trên app mobile
  static String manageCreateIndustrialPark = "/QLKhuCNArea/QLKhuCN/CreateAPI";
  static String manageEditIndustrialPark = "/QLKhuCNArea/QLKhuCN/EditAPI";

  //Quản lý thông tin doanh nghiệp trên app mobile, thê,/idBusiness là edit
  static String manageCreateBusiness =
      "/QLDoanhNghieparea/QLDoanhNghiep/CreateAPI";
  static String manageEditBusiness =
      "/QLDoanhNghiepArea/QLDoanhNghiep/CreateAPI";

  //Quản lý thông tin lao động đang làm việc trong doanh nghiệp trên app mobile
  static String manageNewWorkerVnInBusiness =
      "/QLTTNguoiLaoDongArea/QLTTNguoiLaoDong/CreateAPI";

  //Quản lý thông tin nhu cầu tuyển dụng của doanh nghiệp trên app mobile
  static String manageRecruitmentNeeds =
      "/QLTintuyendungarea/QLTintuyendung/CreateAPI";

  //Khảo sát
  static String survey = "/Survey/Index";

  //Thay ảnh đại diện
  static String changeAvatarUser = "/UserArea/UserAPI/EditAvatarAPI";

  //Tư vấn việc làm
  static String consultationJob = "/hoi-dap";

  //Báo cáo
  static String report ='/qlbaocaoarea/qlbaocao/baocaomobile';
}
