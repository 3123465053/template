import 'package:get/get.dart';
import '../pages/main/main_view.dart';
import '../pages/main/home/home_binding.dart';
import '../pages/main/home/home_view.dart';
import '../pages/main/result/result_binding.dart';
import '../pages/main/result/result_view.dart';
import '../pages/main/history/history_binding.dart';
import '../pages/main/history/history_view.dart';
import '../pages/main/settings/settings_binding.dart';
import '../pages/main/settings/settings_view.dart';
import '../pages/main/membership/membership_binding.dart';
import '../pages/main/membership/membership_view.dart';
import '../pages/main/editor/editor_binding.dart';
import '../pages/main/editor/editor_view.dart';
import '../bindings/initial_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: Routes.MAIN,
      page: () => const MainView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.RESULT,
      page: () =>  ResultView(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: Routes.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.MEMBERSHIP,
      page: () =>  MembershipView(),
      binding: MembershipBinding(),
    ),
    GetPage(
      name: Routes.EDITOR,
      page: () => const EditorView(),
      binding: EditorBinding(),
    ),
  ];
} 