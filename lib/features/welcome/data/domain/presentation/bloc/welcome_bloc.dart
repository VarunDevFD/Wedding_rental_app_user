import 'package:bloc/bloc.dart';
import 'package:vr_wedding_rental/features/welcome/data/domain/presentation/bloc/welcome_satate.dart';

import 'welcome_event.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial());

  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
    if (event is NavigateToSignIn) {
      // Handle navigation to sign-in page
      yield WelcomeSignInNavigation();
    } else if (event is NavigateToSignUp) {
      // Handle navigation to sign-up page
      yield WelcomeSignUpNavigation();
    }
  }
}
