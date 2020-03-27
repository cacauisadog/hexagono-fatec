import 'package:bloc/bloc.dart';
import 'package:no_name/screens/homepage.dart';
import 'package:no_name/screens/notifications.dart';
import 'package:no_name/screens/profile.dart';
import 'package:no_name/screens/settings.dart';
import 'package:no_name/screens/logout.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyProfileClickedEvent,
  NotificationsClickedEvent,
  SettingsClickedEvent,
  LogoutClickedEvent
}

abstract class NavigationStates {

}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates>{
  @override
  NavigationStates get initialState => Homepage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event){
      case NavigationEvents.HomePageClickedEvent:
        yield Homepage();
        break;
      case NavigationEvents.MyProfileClickedEvent:
        yield MyProfile();
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