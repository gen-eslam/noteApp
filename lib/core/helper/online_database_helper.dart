import 'package:notes/core/utils/constance.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnlineDataBase {
  OnlineDataBase._init();

  static final OnlineDataBase _onlineDataBase = OnlineDataBase._init();

  factory OnlineDataBase() {
    return _onlineDataBase;
  }

  final supabase = Supabase.instance.client;

   static Future<void> init() async {
    await Supabase.initialize(
        url: Constance.onlineDatabaseUrl, anonKey: Constance.apiKey);
  }

  Future<AuthResponse> signInWithEmail(
      {required String email, required String password}) async {
    return  await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }
  Future<AuthResponse> signupWithEmail(
      {required String email, required String password,String? name}) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
      data:{"name": name},
    );
  }
  Future<void> signOut()async{
     await supabase.auth.signOut();

  }
}
