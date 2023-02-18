import 'package:flutter/cupertino.dart';

import '../themes/theme.dart';

class Constance {
  /// App Name
  static Widget appText(context) => RichText(
        text: TextSpan(
          text: "Note",
          style: textAppBarTheme(context).copyWith(
            letterSpacing: 2.5,
            color: bluishClr,
          ),
          children: [
            TextSpan(
              text: " App",
              style: textAppBarTheme(context).copyWith(
                letterSpacing: 2.5,
                color: pinkClr,
              ),
            )
          ],
        ),
      );


  /// database Status
  static String dataStatus = "status";
  static String dataAdd = "add";
  static String dataUpdate = "update";
  static String dataDelete = "delete";


  /// user model
  static String userId = "id";
  static String userName = "name";
  static String userPassword = "password";
  static String userEmail = "email";

  /// note model
  static String noteId = 'noteId';
  static String noteTitle = "noteTitle";
  static String noteContent = "noteContent";
  static String noteDateTimeCreated = "noteDateTimeCreated";
  static String noteDateTimeEdited = "noteDateTimeEdited";

  ///date Format
  static String dateFormat = "MMM dd yyy hh:mm a";

  ///get storage
  static String offLineMode = "offLineMode";
  static String signedIn = "signedIn";

  ///supabase
  static String onlineDatabaseUrl = "https://ulmzuhhpiommsyckieop.supabase.co";
  static String apiKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVsbXp1aGhwaW9tbXN5Y2tpZW9wIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzYzMDE3OTksImV4cCI6MTk5MTg3Nzc5OX0.Q8io31bIaIpytj8Lq1-TfqU3B_kxQdW0r8tTfZs0Y-M";
}
