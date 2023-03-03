import 'package:bhashantram/all_services_pages/conversation/conversation_screen.dart';
import 'package:get/route_manager.dart';

import 'all_services_pages/conversation/conversation_screen_binding.dart';
import 'menu_page/menu_screen_binding.dart';
import 'menu_page/menu_screen_ui.dart';

class AppRoutes {
  static const _menuPageRoute = '/menu';
  static const _textNMTPageRoute = '/TextTranslation';
  static const _stsPageRoute = '/SpeechTranslation';
  static const _coversationPageRoute = '/Coversation';

  static String getMenuPageRoute() => _menuPageRoute;
  static String getTextNMTPageRoute() => _textNMTPageRoute;
  static String getSTSPageRoute() => _stsPageRoute;
  static String getCoversationPageRoute() => _coversationPageRoute;

  static List<GetPage> routes = [
    GetPage(name: getMenuPageRoute(), page: () => const MenuScreen(), binding: MenuScreenBindings()),
    GetPage(name: getCoversationPageRoute(), page: () => const ConversationScreen(), binding: ConversationScreenBindings()),
  ];
}
