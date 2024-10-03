import 'package:dio/dio.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/advise/advise_request.dart';
import 'package:phu_tho_mobile/domain/models/request/business/business_request.dart';
import 'package:phu_tho_mobile/domain/models/request/candidate_profile_request/candidate_profile_request.dart';
import 'package:phu_tho_mobile/domain/models/request/change_password/change_password_request.dart';
import 'package:phu_tho_mobile/domain/models/request/edit_information/edit_information_request.dart';
import 'package:phu_tho_mobile/domain/models/request/forgot_password/forgot_password_request.dart';
import 'package:phu_tho_mobile/domain/models/request/economic_activity/economic_activity_request.dart';
import 'package:phu_tho_mobile/domain/models/request/household/household_request.dart';
import 'package:phu_tho_mobile/domain/models/request/industrial_park/industrial_park_request.dart';
import 'package:phu_tho_mobile/domain/models/request/job_request/job_request.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';
import 'package:phu_tho_mobile/domain/models/request/login_request/login_request.dart';
import 'package:phu_tho_mobile/domain/models/request/member_household/member_household_request.dart';
import 'package:phu_tho_mobile/domain/models/request/news/news_request.dart';
import 'package:phu_tho_mobile/domain/models/request/notification/notification_request.dart';
import 'package:phu_tho_mobile/domain/models/request/register_request/register_request.dart';
import 'package:phu_tho_mobile/domain/models/request/service/service_request.dart';
import 'package:phu_tho_mobile/domain/models/request/trading_job/trading_job_request.dart';
import 'package:phu_tho_mobile/domain/models/request/validate_account_by_qr/validate_account_by_qr_request.dart';
import 'package:phu_tho_mobile/domain/models/request/worker/worker_request.dart';
import 'package:phu_tho_mobile/domain/models/response/advise/advise_response.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';
import 'package:phu_tho_mobile/domain/models/response/cadidate/candidate_response.dart';
import 'package:phu_tho_mobile/domain/models/response/ecocomic_activity/economic_activity_response.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/domain/models/response/household/household_response.dart';
import 'package:phu_tho_mobile/domain/models/response/industrial_park/industrial_park_response.dart';
import 'package:phu_tho_mobile/domain/models/response/info_contact/info_contact_response.dart';
import 'package:phu_tho_mobile/domain/models/response/job/job_response.dart';
import 'package:phu_tho_mobile/domain/models/response/banner/banner_response.dart';
import 'package:phu_tho_mobile/domain/models/response/login/login_response.dart';
import 'package:phu_tho_mobile/domain/models/response/member_household/member_household_response.dart';
import 'package:phu_tho_mobile/domain/models/response/news/news_response.dart';
import 'package:phu_tho_mobile/domain/models/response/notification/notification_response.dart';
import 'package:phu_tho_mobile/domain/models/response/question/question_response.dart';
import 'package:phu_tho_mobile/domain/models/response/terms_of_use/terms_of_use_response.dart';
import 'package:phu_tho_mobile/domain/models/response/trading_job_response/trading_job_response.dart';
import 'package:phu_tho_mobile/domain/models/response/user/user_profile_response.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/detail_worker_response.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/worker_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/response/service/business_service.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST('/api/ct/acc/post/login')
  Future<ApiResponse<LoginResponse>> login(@Body() LoginRequest request);

  @GET('/api/HoSoUngVien/GetHoSoUngVien')
  Future<ApiResponse<ListDataResponse<CandidateResponse>>> getCandidateProfile(
      @Queries() CandidateProFileRequest request);

  @GET("/api/KhaiThacBanner/GetBannerPublic")
  Future<ApiResponse<List<BannerResponse>>> getBannerPublic(
      @Queries() BaseRequest request);

  @POST('/api/QLNhuCauTuyenDung/KhaiThacNhuCauTuyenDung')
  Future<ApiResponse<ListDataResponse<JobResponse>>> getJobs(
      @Body() JobRequest request);

  @GET("/api/DanhMuc/GetDropdownTinh")
  Future<ApiResponse<List<FilterResponse>>> getProvince();

  @GET("/api/DanhMuc/GetDropdownHuyen")
  Future<ApiResponse<List<FilterResponse>>> getDistrict(
      @Query("MaTinh") String? idProvince);

  @GET("/api/DanhMuc/GetDropdownXa")
  Future<ApiResponse<List<FilterResponse>>> getCommune(
      @Query("MaHuyen") String? idProvince);

  @GET("/api/DanhMuc/GetDropdownGioiTinh")
  Future<ApiResponse<List<FilterResponse>>> getGender();

  @GET("/api/DanhMuc/GetDropdownKinhNghiem")
  Future<ApiResponse<List<FilterResponse>>> getExp();

  @GET("/api/DanhMuc/GetDropdownTrinhDo")
  Future<ApiResponse<List<FilterResponse>>> getLevel();

  @GET("/api/DanhMuc/GetDropdownMucLuong")
  Future<ApiResponse<List<FilterResponse>>> getSalary();

  @GET("/api/DanhMuc/GetDropdownNganhNghe")
  Future<ApiResponse<List<FilterResponse>>> getJob();

  @GET("/api/DanhMuc/GetDropdownViTri")
  Future<ApiResponse<List<FilterResponse>>> getPosition();

  @GET('/api/KhaiThacThongTinDoanhNghiep/GetAllAndSearch')
  Future<ApiResponse<ListDataResponse<BusinessResponse>>> getBusiness(
      @Queries() BusinessRequest request);

  @GET("/api/KhaiThacThongTinDoanhNghiep/GetDetail")
  Future<ApiResponse<BusinessResponse>> getDetailBusiness(@Query("id") int id);

  @GET('/api/KhaiThacThongTinDoanhNghiep/DoanhNghiepNoiBat')
  Future<ApiResponse<List<BusinessResponse>>> getHotBusiness();

  @GET('/api/ct/acc/GetThongTinCaNhan')
  Future<ApiResponse<UserProfileResponse>> getUserProfile(
      @Query('id') int accountId);

  @GET('/api/KhaiThacThongTinKhuCN/GetAllAndSearch')
  Future<ApiResponse<ListDataResponse<IndustrialParkResponse>>>
      getIndustrialPark(@Queries() IndustrialParkRequest request);

  @GET(
      '/api/KhaiThacThongTinNguoiLaoDongVietNam/NguoiLaoDongLaCongDanVietNam/GetAllAndSearch')
  Future<ApiResponse<ListDataResponse<WorkerResponse>>>
      getExtractWorkerVnCitizen(@Queries() WorkerRequest request);

  @GET('/api/TuVanGiaoLuuTrucTuyen/TuVanGiaoLuuTrucTuyen')
  Future<ApiResponse<ListDataResponse<NewsResponse>>> getNewsCommunication(
      @Queries() NewsRequest request);

  @GET("/api/KhaiThacThongTinNguoiLaoDongVietNam/GetDetail")
  Future<ApiResponse<DetailWorkerResponse>> getExtractDetailWorkerVnCitizen(
      @Query("id") int id);

  @GET('/api/Workers/WorkerInTheEnterprise/GetAllAndSearch')
  Future<ApiResponse<ListDataResponse<WorkerResponse>>> getManageWorkers(
      @Queries() WorkerRequest request);

  @GET(
      '/api/KhaiThacThongTinNguoiLaoDongNuocNgoai/NguoiLaoDongLaCongDanNuocNgoai/GetAllAndSearch')
  Future<ApiResponse<ListDataResponse<WorkerResponse>>>
      getExtractWorkerForeignCitizenInVn(@Queries() WorkerRequest request);

  @GET("/api/KhaiThacThongTinNguoiLaoDongNuocNgoai/GetDetail")
  Future<ApiResponse<DetailWorkerResponse>>
      getExtractDetailWorkerForeignCitizenInVn(@Query("id") int id);

  @GET('/api/KhaiThacThongTinNguoiLaoDongTrongDN/GetAllAndSearch')
  Future<ApiResponse<ListDataResponse<WorkerResponse>>>
      getExtractWorkersInBusiness(@Queries() WorkerRequest request);

  @GET("/api/KhaiThacThongTinNguoiLaoDongTrongDN/GetDetail")
  Future<ApiResponse<DetailWorkerResponse>> getExtractDetailWorkerInBusiness(
      @Query("id") int id);

  @GET("/api/KhaiThacTin/GetTopCungChuyenMuc")
  Future<ApiResponse<List<NewsResponse>>> getNewsSame(
      @Query("Id") int id, @Query("soLuongTin") int quantity);

  @GET('/api/KhaiThacHDTuVan/HoatDongTuVan') // khai thac hoat dong tu van
  Future<ApiResponse<ListDataResponse<NewsResponse>>> getNewsAdvise(
      @Queries() NewsRequest request);

  // kt gioi thieu viec lam
  @GET('/api/KhaiThacHDGTViecLam/HoatDongGioiThieuViecLam')
  Future<ApiResponse<ListDataResponse<NewsResponse>>> getNewsIntroduction(
      @Queries() NewsRequest request);

  // kt hoat dong cung ung
  @GET('/api/KhaiThacHDCungUngLaoDong/HDCungUngLaoDong')
  Future<ApiResponse<ListDataResponse<NewsResponse>>> getNewsSupply(
      @Queries() NewsRequest request);

  // kt hoat dong nguoi tim viec
  @GET('/api//HoatDongNguoiTimViec/HoatDongNguoiTimViec')
  Future<ApiResponse<ListDataResponse<NewsResponse>>> getNewsJobSeekers(
      @Queries() NewsRequest request);

  // kt hoat dong viec lam trong
  @GET('/api/ThongTinViecLamTrong/ThongTinViecLamTrong')
  Future<ApiResponse<ListDataResponse<NewsResponse>>> getNewsFindingPeople(
      @Queries() NewsRequest request);

  // kt tinh trang viec lam
  @GET('/api/TinhTrangViecLamNguoiLaoDong/TinhTrangViecLamNguoiLaoDong')
  Future<ApiResponse<ListDataResponse<NewsResponse>>> getNewsEmploymentStatus(
      @Queries() NewsRequest request);

  // kt du bao thi truong lao dong
  @GET('/api/KhaiThacTin/DuBaoThiTruonglaoDong')
  Future<ApiResponse<ListDataResponse<NewsResponse>>> getForecast(
      @Queries() NewsRequest request);

  @GET("/api/Workers/GetDetail")
  Future<ApiResponse<DetailWorkerResponse>> getDetailManageWorker(
      @Query("id") int id);

  @DELETE("/api/Workers/Delete")
  Future<ApiResponse> deleteManageWorker(@Query("id") int id);

  @GET('/api/Workers/ForeignersWorkingInVietnam/GetAllAndSearch')
  Future<ApiResponse<ListDataResponse<WorkerResponse>>>
      getManageWorkersForeignInVN(@Queries() WorkerRequest request);

  @GET('/api/Workers/VietnameseWorkersWorkingAbroad/GetAllAndSearch')
  Future<ApiResponse<ListDataResponse<WorkerResponse>>>
      getManageWorkersVnInForeign(@Queries() WorkerRequest request);

  @GET('/api/DoanhNghiep/GetAllAndSearch')
  Future<ApiResponse<ListDataResponse<BusinessResponse>>> getMangeBusiness(
      @Queries() BusinessRequest request);

  @GET("/api/DoanhNghiep/GetDetail")
  Future<ApiResponse<BusinessResponse>> getDetailMangeBusiness(
      @Query("id") int id);

  @DELETE("/api/DoanhNghiep/Delete")
  Future<ApiResponse<BusinessResponse>> deleteMangeBusiness(
      @Query("id") int id);

  @GET("/api/HuongDanSuDung/GetHuongDanSuDung")
  Future<ApiResponse<ListDataResponse<TermsOfUseResponse>>> getTermOfUse(
      @Query("tenFilter") String? title);

  @GET('/api/QLKhuCongNghiep/GetAllAndSearch')
  Future<ApiResponse<ListDataResponse<IndustrialParkResponse>>>
      getManageIndustrialPark(@Queries() IndustrialParkRequest request);

  @DELETE("/api/QLKhuCongNghiep/Delete")
  Future<ApiResponse> deleteIndustrialPark(@Query("id") int id);

  @GET("/api/ThongTinLienHe/GetThongTinLienHe")
  Future<ApiResponse<InfoContactResponse>> getInfoContact();

  @GET("/api/Notification/GetAllNotification")
  Future<ApiResponse<ListDataResponse<NotificationResponse>>>
      getAllNotification(@Queries() NotificationRequest request);

  @GET("/api/Notification/GetAllByUserIdUnRead")
  Future<ApiResponse<List<NotificationResponse>>> getUnReadNotification();

  @GET("/api/Notification/GetDetailNotification")
  Future<ApiResponse<NotificationResponse>> getDetailNotification(
      @Query("idNotification") int idNotification);

  @GET("/api/DanhMuc/GetDropdownTinhTrangHoatDong_DoanhNghiep")
  Future<ApiResponse<List<FilterResponse>>> getStatusBusiness();

  @GET("/api/HoGiaDinh/GetHoGiaDinh")
  Future<ApiResponse<ListDataResponse<HouseholdResponse>>> getHouseholds(
      @Queries() HouseholdRequest request);

  @GET("/api/HoiDap/GetAllCauHoi")
  Future<ApiResponse<ListDataResponse<QuestionResponse>>> getAllQuestion(
      @Query("titleFilter") String? title);

  @GET("/api/KhaiThacPGDViecLam/GetPhienGDViecLam")
  Future<ApiResponse<ListDataResponse<TradingJobResponse>>> getTradingJobs(
      @Queries() TradingJobRequest request);

  @GET("/api/DanhMuc/GetDropdown_KhuVuc")
  Future<ApiResponse<List<FilterResponse>>> getArea();

  @GET('/api/KhaiThacThongTinKhuCN/GetListEnterprise')
  Future<ApiResponse<ListDataResponse<BusinessResponse>>>
      getBusinessByIdIndustrialPark(@Queries() BusinessRequest request);

  @POST('/api/QLNhuCauTuyenDung/DanhSachNhuCauTuyenDung')
  Future<ApiResponse<ListDataResponse<JobResponse>>> getManageJobs(
      @Body() JobRequest request);

  @GET('/api/TuVanViecLam/TuVanViecLam')
  Future<ApiResponse<ListDataResponse<AdviseResponse>>> getAllAdvise(
      @Queries() AdviseRequest request);

  @POST("/api/ct/acc/ForgotPassword")
  Future<ApiResponse> forgotPassword(@Body() ForgotPasswordRequest request);

  @DELETE("/api/QLNhuCauTuyenDung/XoaTinTuyenDung")
  Future<ApiResponse> deleteJob(@Query("id") int id);

  @GET("/api/TinhHinhThuNopPhi/KhaiThacTinhHinhThuNopPhi")
  Future<ApiResponse<ListDataResponse<BusinessServiceResponse>>> getCostService(
      @Queries() ServiceRequest request);

  @GET('/api/KhaiThacHoatDongKinhTe/DanhSachViecLamVoiNguoiThamGiaHDKT')
  Future<ApiResponse<ListDataResponse<EconomicActivityResponse>>>
      getEconomicActivity(@Queries() EconomicActivityRequest request);

  @GET('/api/ThanhVienHo/GetThanhVienHo')
  Future<ApiResponse<ListDataResponse<MemberHouseholdResponse>>>
      getMemberHouseholds(@Queries() MemberHouseholdRequest request);

  @GET('/api/ThanhVienHo/DetailThanhVienHo')
  Future<ApiResponse<MemberHouseholdResponse>> getDetailMemberHousehold(
      @Query("id") int id);

  @POST('/api/ct/acc/ChangePassword')
  Future<ApiResponse> changePassword(@Body() ChangePasswordRequest request);

  @POST('/api/ct/acc/DangKyTaiKhoan')
  Future<ApiResponse> createAccount(@Body() RegisterRequest request);

  @POST('/api/ct/acc/ValidQR')
  Future<ApiResponse> validateAccountByQr(
      @Queries() ValidateAccountByQrRequest request);

  @POST("/api/ct/acc/CapNhatThongTinCaNhan")
  Future<ApiResponse> updateInformationUser(
      @Body() EditInformationRequest request);

  @GET('/api/DanhMuc/GetDropdown_TypeAccount')
  Future<ApiResponse<List<FilterResponse>>> getTypeAccount();

  @GET("/api/DanhMuc/GetDropdown_LoaiHinhKinhTe")
  Future<ApiResponse<List<FilterResponse>>> getTypeEconomic();

  @GET("/api/DanhMuc/GetDropdown_TuLamLamCong")
  Future<ApiResponse<List<FilterResponse>>> getTypeWork();


  @POST("/api/QLNhuCauTuyenDung/UngTuyenCongViec")
  Future<ApiResponse> applyJob(@Query("IdTinTuyenDung") int id);

  @GET("/api/DanhMuc/GetDropdownQuanHeChuHo")
  Future<ApiResponse<List<FilterResponse>>> relationShipWithHeader();

  @GET("/api/DanhMuc/GetDropdownQuanHeChuHo")
  Future<ApiResponse<List<FilterResponse>>> getRelationShipWithHeader();

  @GET("/api/DanhMuc/GetDropdown_DanToc")
  Future<ApiResponse<List<FilterResponse>>> getEthnicities();

  @POST("/api/ct/acc/XoaThongTinNguoiDung")
  Future<ApiResponse> deleteAccount(@Query("Id") int id);

  @GET("/api/DanhMuc/GetDropdown_GioiTinh_ThanhVienHo")
  Future<ApiResponse<List<FilterResponse>>> getGenderInMember();
}
