import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/data/repositories/advise_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/authentication_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/business_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/dict_item_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/economic_activity_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/household_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/industrial_park_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/job_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/candidate_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/banner_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/notitfication_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/service_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/trading_job_repository_impl.dart';
import 'package:phu_tho_mobile/data/repositories/user_repository_impl.dart';
import 'package:phu_tho_mobile/domain/repositories/advise_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/authentication_repository.dart';
import 'package:phu_tho_mobile/data/repositories/worker_repository_impl.dart';
import 'package:phu_tho_mobile/domain/repositories/business_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/dict_item_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/economic_activity_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/household_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/industrial_park_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/job_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/candidate_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/banner_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/notification_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/service_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/trading_job_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/user_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/utilities_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/worker_repository.dart';

import 'data/repositories/news_repository_impl.dart';
import 'data/repositories/utilities_repository_impl.dart';
import 'di.config.dart';
import 'domain/repositories/news_repository.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() {
  getIt.init();
  //repository
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
  getIt.registerLazySingleton<CandidateRepository>(
      () => CandidateRepositoryImpl());
  getIt.registerLazySingleton<JobRepository>(() => JobRepositoryImpl());
  getIt.registerLazySingleton<BannerRepository>(() => BannerRepositoryImpl());
  getIt.registerLazySingleton<DictItemRepository>(
      () => DictItemRepositoryImpl());
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  getIt.registerLazySingleton<IndustrialParkRepository>(
      () => IndustrialParkRepositoryImpl());
  getIt.registerLazySingleton<BusinessRepository>(
      () => BusinessRepositoryImpl());
  getIt.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl());
  getIt.registerLazySingleton<WorkerRepository>(() => WorkerRepositoryImpl());
  getIt.registerLazySingleton<UtilitiesRepository>(
      () => UtilitiesRepositoryImpl());
  getIt.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl());
  getIt.registerLazySingleton<HouseholdRepository>(
      () => HouseHoldRepositoryImpl());
  getIt.registerLazySingleton<TradingJobRepository>(
      () => TradingJobRepositoryImpl());
  getIt.registerLazySingleton<EconomicActivityRepository>(
      () => EconomicActivityRepositoryImpl());

  getIt.registerLazySingleton<AdviseRepository>(() => AdviseRepositoryImpl());
  getIt.registerLazySingleton<ServiceRepository>(
          () => ServiceRepositoryImpl());

  // shared preferences
  getIt.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper());
}
