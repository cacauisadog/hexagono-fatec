import 'package:bloc/bloc.dart';
import 'package:app/screens/homepage.dart';
import 'package:app/screens/notifications.dart';
import 'package:app/screens/account.dart';
import 'package:app/screens/settings.dart';
import 'package:app/screens/logout.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  AccountClickedEvent,
  NotificationsClickedEvent,
  SettingsClickedEvent,
  LogoutClickedEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates>{
  @override
  NavigationStates get initialState => Homepage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event){
      case NavigationEvents.HomePageClickedEvent:
        yield Homepage();
        break;
      case NavigationEvents.AccountClickedEvent:
        yield MyAccount();
        break;
      case NavigationEvents.SettingsClickedEvent:
        yield Settings();
        break;
      case NavigationEvents.NotificationsClickedEvent:
        yield Notifications();
        break;
      case NavigationEvents.LogoutClickedEvent:
        yield Logout();
        break;
    }
  }
}