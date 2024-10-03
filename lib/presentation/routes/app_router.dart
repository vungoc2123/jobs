import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/application/enums/path_news.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/application/enums/type_industrial_park.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_business_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_extract_worker_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_job_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/detail_household_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/in_app_web_view_argument.dart';
import 'package:phu_tho_mobile/domain/models/argument/list_job_argument.dart';
import 'package:phu_tho_mobile/domain/models/response/cadidate/candidate_response.dart';
import 'package:phu_tho_mobile/domain/models/response/industrial_park/industrial_park_response.dart';
import 'package:phu_tho_mobile/domain/models/response/news/news_response.dart';
import 'package:phu_tho_mobile/domain/models/response/question/question_response.dart';
import 'package:phu_tho_mobile/domain/models/response/service/business_service.dart';
import 'package:phu_tho_mobile/domain/models/response/terms_of_use/terms_of_use_response.dart';
import 'package:phu_tho_mobile/domain/models/response/user/user_profile_response.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:phu_tho_mobile/presentation/screens/account/change_password/change_password_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/account/change_password/change_password_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/account/edit_information/edit_infomation_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/account/edit_information/edit_information_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/account/infomation_account/infomation_account_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/account/infomation_account/information_account_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/account/qr_scanner/qr_scanner_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/account/qr_scanner/qr_scanner_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/business/detail_business/detail_business.dart';
import 'package:phu_tho_mobile/presentation/screens/business/detail_business/detail_business_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/business/list_business/business_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/business/list_business/business_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/candidate/detail_candidate/detail_candidate_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/candidate/list_candidate/candidate_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/candidate/list_candidate/list_candidate_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/consulting_job/consulting_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/consulting_job/consulting_job_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/detail_news/bloc/detail_news_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/detail_news/detail_news_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/detail_question/detail_question_screem.dart';
import 'package:phu_tho_mobile/presentation/screens/detail_terms/detail_terms_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/economic_activity/bloc/economic_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/economic_activity/economic_activity_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/extract_worker/detail_worker/detail_extract_worker_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/extract_worker/detail_worker/detail_extract_worker_sceen.dart';
import 'package:phu_tho_mobile/presentation/screens/extract_worker/list_worker/worker_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/extract_worker/list_worker/workers_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/favorite/favorite_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/detail_job/detail_job_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/forgot_password/forgot_password_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/household/list_household/house_hold_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/household/list_household/households_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/in_app_web_view/in_app_web_view_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/industria_park/detail/bloc/detail_industrial_park_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/industria_park/detail/detail_industrial_park_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/industria_park/list/bloc/industrial_park_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/industria_park/list/industrial_park_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/info_contact/info_contact_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/info_contact/info_contact_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/list_employers/list_employers_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/home_tab/home_tab.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/bloc/list_job_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/login/login_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/manage_worker/bloc/manage_worker_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/manage_worker/manage_worker.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/detail_member_household/detail_member_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/detail_member_household/detail_member_household_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/members/members_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/members/members_household_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/news/bloc/news_common_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/news/news_common_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/news_communication/communication_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/news_communication/news_communication_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/notification/notification_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/notification/notification_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/login/authen_login.dart';
import 'package:phu_tho_mobile/presentation/screens/question/question_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/question/question_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/register/register_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/register/register_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/situation/detail/detail_situation.dart';
import 'package:phu_tho_mobile/presentation/screens/situation/situation_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/situation/situation_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/splash/splash_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/splash/splash_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/terms_of_use/terms_of_use_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/terms_of_use/terms_of_use_screen.dart';
import 'package:phu_tho_mobile/presentation/screens/trading_job/bloc/trading_job_cubit.dart';
import 'package:phu_tho_mobile/presentation/screens/trading_job/trading_job_screen.dart';
import '../screens/list_job/list_job_screen.dart';
import '../screens/search/search_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final initialWidget = BlocProvider(
      create: (context) => SplashCubit(),
      child: const SplashScreen(),
    );

    Widget routeWidget = initialWidget;
    final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case RouteName.root:
        break;
      case RouteName.listEmployers:
        routeWidget = const ListEmployerScreen();
        break;
      case RouteName.register:
        routeWidget = BlocProvider(
          create: (context) => RegisterCubit(),
          child: const RegisterScreen(),
        );
        break;
      case RouteName.detailBusiness:
        routeWidget = BlocProvider(
          create: (context) => DetailBusinessCubit(),
          child: DetailBusinessScreen(
            argument: arguments as DetailBusinessArgument,
          ),
        );
        break;
      case RouteName.situationDetail:
        routeWidget =
            DetailSituation(business: arguments as BusinessServiceResponse);
        break;
      case RouteName.consulting:
        routeWidget = BlocProvider(
          create: (context) => ConsultingCubit(),
          child: const ConsultingJobScreen(),
        );
        break;
      case RouteName.situation:
        routeWidget = BlocProvider(
          create: (context) => SituationCubit(),
          child: const SituationScreen(),
        );
        break;
      case RouteName.detailJob:
        routeWidget = BlocProvider(
          create: (_) => ListJobCubit(),
          child: DetailJobScreen(
            argument: arguments as DetailJobArgument,
          ),
        );
        break;
      case RouteName.listJob:
        routeWidget = BlocProvider(
            create: (BuildContext context) => ListJobCubit(),
            child: ListJobScreen(
              argument: arguments as ListJobArgument,
            ));
        break;
      case RouteName.homeTab:
        routeWidget = HomeTab(arguments: arguments as HomeTabArguments);
        break;
      case RouteName.listCandidate:
        routeWidget = BlocProvider(
          create: (context) => CandidateCubit(),
          child: const ListCandidateScreen(),
        );
        break;
      case RouteName.detailCandidate:
        routeWidget =
            DetailCandidateScreen(profile: arguments as CandidateResponse);
        break;
      case RouteName.notification:
        routeWidget = BlocProvider(
            create: (context) => NotificationCubit(),
            child: const NotificationScreen());
        break;
      case RouteName.search:
        routeWidget = const SearchScreen();
        break;
      case RouteName.favourite:
        routeWidget = const FavoriteScreen();
        break;
      case RouteName.detailTermOfUse:
        routeWidget = DetailTermsScreen(terms: arguments as TermsOfUseResponse);
        break;
      case RouteName.communication:
        routeWidget = BlocProvider(
          create: (context) => CommunicationCubit(),
          child: const NewsCommunicationScreen(),
        );
        break;
      case RouteName.news:
        routeWidget = BlocProvider(
          create: (context) => NewsCommonCubit(),
          child: NewsCommonScreen(nameScreen: arguments as NewsPath),
        );
        break;
      case RouteName.termOfUse:
        routeWidget = BlocProvider(
          create: (context) => TermsOfUseCubit(),
          child: const TermsOfUseScreen(),
        );
        break;
      case RouteName.question:
        routeWidget = BlocProvider(
          create: (context) => QuestionCubit(),
          child: const QuestionsScreen(),
        );
        break;
      case RouteName.detailQuestion:
        routeWidget = DetailQuestionScreen(
          question: arguments as QuestionResponse,
        );
        break;
      case RouteName.detailNewsCommon:
        routeWidget = BlocProvider(
            create: (context) => DetailNewsCubit(),
            child: NewsDetailScreen(news: arguments as NewsResponse));
        break;
      case RouteName.login:
        routeWidget = BlocProvider(
            create: (context) => LoginCubit(), child: const LoginScreen());
        break;
      case RouteName.industrialPark:
        routeWidget = BlocProvider(
          create: (context) => IndustrialParkCubit(),
          child: IndustrialPark(
            type: arguments as TypeIndustrialPark,
          ),
        );
        break;

      case RouteName.detailIndustrialPark:
        routeWidget = BlocProvider(
          create: (context) => DetailIndustrialParkCubit(),
          child: DetailIndustrialParkScreen(
            industrialPark: arguments as IndustrialParkResponse,
          ),
        );
        break;
      case RouteName.listWorkers:
        routeWidget = BlocProvider(
            create: (context) => WorkerCubit(),
            child: WorkersScreen(
              type: arguments as TypeExtractWorker,
            ));
        break;
      case RouteName.detailExtractWorker:
        routeWidget = BlocProvider(
            create: (context) => DetailExtractWorkerCubit(),
            child: DetailExtractWorkerScreen(
                argument: arguments as DetailWorkerExtractArgument));
        break;
      case RouteName.manageWorker:
        routeWidget = BlocProvider(
            create: (context) => ManageWorkerCubit(),
            child: ManageWorkerScreen(
              type: arguments as TypeExtractWorker,
            ));
      case RouteName.listBusiness:
        routeWidget = BlocProvider(
            create: (context) => BusinessCubit(),
            child: BusinessScreen(type: arguments as TypeAction));
      case RouteName.informationContact:
        routeWidget = BlocProvider(
            create: (context) => InfoContactCubit(),
            child: const InfoContactScreen());
        break;
      case RouteName.inAppWebView:
        routeWidget = InAppWebViewScreen(
          argument: arguments as InAppWebViewArgument,
        );
        break;
      case RouteName.houseHold:
        routeWidget = BlocProvider(
            create: (context) => HouseholdsCubit(),
            child: const HouseholdScreen());
        break;
      case RouteName.tradingJob:
        routeWidget = BlocProvider(
            create: (BuildContext context) => TradingJobCubit(),
            child: const TradingJobScreen());
        break;
      case RouteName.forgotPassword:
        routeWidget = BlocProvider(
            create: (context) => ForgotPasswordCubit(),
            child: const ForgotPasswordScreen());
        break;
      case RouteName.economic:
        routeWidget = BlocProvider(
            create: (BuildContext context) => EconomicCubit(),
            child: const EconomicActivityScreen());
        break;
      case RouteName.membersHousehold:
        routeWidget = BlocProvider(
          create: (context) => MembersCubit(),
          child: MemberHouseHoldScreen(
            argument: arguments as DetailHouseholdArgument,
          ),
        );
        break;
      case RouteName.detailMemberHousehold:
        routeWidget = BlocProvider(
          create: (context) => DetailMemberCubit(),
          child: DetailMemberHouseholdScreen(
            idMember: arguments as int,
          ),
        );
        break;
      case RouteName.changePassword:
        routeWidget = BlocProvider(
            create: (context) => ChangePasswordCubit(),
            child: const ChangePasswordScreen());
        break;
      case RouteName.informationAccount:
        routeWidget = BlocProvider(
            create: (context) => InformationAccountCubit(),
            child: const InformationAccountScreen());
        break;
      case RouteName.editInformation:
        routeWidget = BlocProvider(
          create: (context) => EditInformationCubit(),
          child: EditInformationScreen(
            user: arguments as UserProfileResponse,
          ),
        );
        break;
      case RouteName.qrScanner:
        routeWidget = BlocProvider(
          create: (context) => QrScannerCubit(),
          child: const QrScannerScreen(),
        );
        break;
      default:
        routeWidget = initialWidget;
        break;
    }

    return MaterialPageRoute(
        builder: (_) => routeWidget, settings: routeSettings);
  }
}
