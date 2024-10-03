enum PermissionOperator {
  // report
  reportNumberOfEmployeesByField, // Báo cáo số lượng lao động theo lĩnh vực
  reportNumberOfEmployeesByIndustry, // Báo cáo số lượng lao động theo ngành nghề
  reportNumberOfEmployeesByLevel, // Báo cáo số lượng lao động theo trình độ
  reportAverageSalary, // Báo cáo tiền lương bình quân
  reportHouseHoldsMergingAndSeparating, // Báo cáo về hộ gia đình Sát Nhập - Tách hộ Tỉnh Phú Thọ
  reportHouseHoldsMergingAndSeparatingInADistrict, // Báo cáo về hộ gia đình Sát Nhập - Tách hộ trong một huyện
  reportNumberHouseHoldsAndPopulation, // Báo cáo về hộ gia đình, số hộ - nhân khẩu trong Tỉnh Phú Thọ
  reportNumberHouseHoldsAndPopulationInADistrict, // Báo cáo về hộ gia đình, số hộ - nhân khẩu trong 1 huyện
  reportLaborMarket, // Báo cáo thị trường lao động Tỉnh Phú Thọ
  reportLaborMarketInADistrict, // Báo cáo thị trường lao động trong một Huyện
  reportLaborRecruitmentNeeds, // Báo cáo nhu cầu tuyển dụng lao động
  reportEmploymentTransactionSession, // Báo cáo về phiên giao dịch việc làm
  reportCommon, //Báo cáo chung
  employmentForEconomicParticipants, //Danh sách việc làm với người tham gia HĐ kinh tế

  // management
  manageGetAllEnterprise, // Quản lý Xem danh sách và tìm kiếm thông tin doanh nghiệp
  manageGetDetailEnterprise, // Quản lý Xem Chi tiết thông tin doanh nghiệp
  manageDeleteEnterprise, // Quản lý Xoá thông tin doanh nghiệp
  manageRecruitmentNeedsOfEnterprise, // Quản lý thông tin nhu cầu tuyển dụng của doanh nghiệp
  manageIndustrialPark, // Quản lý khu công nghiệp

  // explore
  getBanner, // Khai thác banner
  getLaborMarketForecast, // Khai thác dự báo thị trường lao động
  getLaborSupplyActivities, // Khai thác hoạt động cung ứng lao động
  getJobIntroductionActivities, // Khai thác hoạt động giới thiệu việc làm
  getJobSeekerInfoCollectionActivities, // Khai thác hoạt động thu thập thông tin người tìm việc
  getJobEmptyInfoCollectionActivities, // Khai thác hoạt động thu thập thông tin việc làm trống
  getConsultingActivities, // Khai thác hoạt động tư vấn
  getInstruction, // Khai thác thông tin liên hệKhai thác hướng dẫn sử dụng
  getContactInformation, // Khai thác thông tin liên hệ
  getRecruitmentNeedsOfEnterprise, // Khai thác thông tin nhu cầu tuyển dụng của doanh nghiệp
  getCollectAndPayServiceFees, // Khai thác tình hình thu, nộp phí dịch vụ, theo dõi hợp đồng giới thiệu, cung ứng lao động
  getEmploymentStatusOfEmployee, // Khai thác tình trạng việc làm của người lao động
  getEmploymentTransactionSession, // Khai thác tổng hợp tổ chức phiên giao dịch việc làm, hội nghị việc làm
  getJobConsulting, // Khai thác Tư vấn việc làm
  getHousehold, //Lấy danh sách tất cả hộ gia đình
  getQAs, //Lấy danh sách câu hỏi và trả lời
  getWorkerForeignInVn, //Xem và tìm kiếm danh sách thông tin người lao động là công dân nước ngoài
  getWorkerVnInForeign, //Xem và tìm kiếm danh sách thông tin người lao động là công dân Việt Nam làm việc tại nước ngoài
  getWorkerInBusiness, //Xem và tìm kiếm danh sách thông tin người lao động trong doanh nghiệp

  unknown;

  factory PermissionOperator.fromString(String value) {
    switch (value) {
      // report
      case 'SoLuongLaoDongTheoLinhVuc':
        return PermissionOperator.reportNumberOfEmployeesByField;
      case 'SoLuongLaoDongTheoNganhNghe':
        return PermissionOperator.reportNumberOfEmployeesByIndustry;
      case 'SoLuongLaoDongTheoTrinhDo':
        return PermissionOperator.reportNumberOfEmployeesByLevel;
      case 'BaoCao_TienLuongBinhQuan':
        return PermissionOperator.reportAverageSalary;
      case 'BaoCaoSatNhap_TachHo':
        return PermissionOperator.reportHouseHoldsMergingAndSeparating;
      case 'BaoCaoSatNhap_TachHo_Huyen':
        return PermissionOperator
            .reportHouseHoldsMergingAndSeparatingInADistrict;
      case 'BaoCaoHoGiaDinh':
        return PermissionOperator.reportNumberHouseHoldsAndPopulation;
      case 'BaoCaoHoGiaDinh_Huyen':
        return PermissionOperator
            .reportNumberHouseHoldsAndPopulationInADistrict;
      case 'BaoCaoTTLD':
        return PermissionOperator.reportLaborMarket;
      case 'BaoCaoTTLD_Huyen':
        return PermissionOperator.reportLaborMarketInADistrict;
      case 'BaoCaoNhuCauTuyenDung':
        return PermissionOperator.reportLaborRecruitmentNeeds;
      case 'ThongKePGDViecLam':
        return PermissionOperator.reportEmploymentTransactionSession;
      case 'QLBaoCao_mobile':
        return PermissionOperator.reportCommon;
      case 'DanhSachViecLamVoiNguoiThamGiaHDKT':
        return PermissionOperator.employmentForEconomicParticipants;

      // management
      case 'QLThongTinDNGetAllAndSearch':
        return PermissionOperator.manageGetAllEnterprise;
      case 'QLThongTinDNGetDetail':
        return PermissionOperator.manageGetDetailEnterprise;
      case 'QLDoanhNghiep_Delete':
        return PermissionOperator.manageDeleteEnterprise;
      case 'DanhSachNhuCauTuyenDung':
        return PermissionOperator.manageRecruitmentNeedsOfEnterprise;
      case 'QLKhuCongNghiepGetAllAndSearch':
        return PermissionOperator.manageIndustrialPark;

      // explore
      case 'Banner_GetBanner':
        return PermissionOperator.getBanner;
      case 'KhaiThacDuBaoThiTruonglaoDong':
        return PermissionOperator.getLaborMarketForecast;
      case 'HoatDongCungUngLaoDong':
        return PermissionOperator.getLaborSupplyActivities;
      case 'HoatDongGioiThieuViecLam':
        return PermissionOperator.getJobIntroductionActivities;
      case 'KhaiThacHoatDongTTTTNguoiTimViec':
        return PermissionOperator.getJobSeekerInfoCollectionActivities;
      case 'KhaiThacThongTinViecLamTrong':
        return PermissionOperator.getJobEmptyInfoCollectionActivities;
      case 'KhaiThacHoatDongTuVan':
        return PermissionOperator.getConsultingActivities;
      case 'GetHuongDanSuDung':
        return PermissionOperator.getInstruction;
      case 'KhaiThacLienHe':
        return PermissionOperator.getContactInformation;
      case 'KhaiThacNhuCauTuyenDung':
        return PermissionOperator.getRecruitmentNeedsOfEnterprise;
      case 'KhaiThacTinhHinhThuNopPhi':
        return PermissionOperator.getCollectAndPayServiceFees;
      case 'KhaiThacTinhTrangViecLamNguoiLaoDong':
        return PermissionOperator.getEmploymentStatusOfEmployee;
      case 'GetPhienGDViecLam':
        return PermissionOperator.getEmploymentTransactionSession;
      case 'TuVanViecLam':
        return PermissionOperator.getJobConsulting;
      case 'GetHoGiaDinh':
        return PermissionOperator.getHousehold;
      case 'GetAllCauHoi':
        return PermissionOperator.getQAs;
      case 'NguoiLaoDongLaCongDanNuocNgoai_GetAllAndSearch':
        return PermissionOperator.getWorkerForeignInVn;
      case 'NguoiLaoDongLaCongDanVietNam_GetAllAndSearch':
        return PermissionOperator.getWorkerVnInForeign;
      case 'GetAllAndSearchWorkerInTheEnterprise':
        return PermissionOperator.getWorkerInBusiness;
      default:
        return PermissionOperator.unknown;
    }
  }
}
