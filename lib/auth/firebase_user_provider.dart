import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ApayoFirebaseUser {
  ApayoFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

ApayoFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ApayoFirebaseUser> apayoFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<ApayoFirebaseUser>((user) => currentUser = ApayoFirebaseUser(user));
