import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static String baseUrl = "http://10.0.2.2:3000";
  // static String baseUrl = "http://192.168.1.9:3000";
}

class SessionManager {
  static Future<String> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessionId = prefs.getInt('user_id').toString() ?? '';
    String sessionEmployeeName = prefs.getString('employee_name') ?? '';
    String sessionPosition = prefs.getInt('position_id').toString() ?? '';
    String sessionDivision = prefs.getInt('division_id').toString() ?? '';
    String session =
        "$sessionId-$sessionEmployeeName-$sessionPosition-$sessionDivision";
    return session;
  }

  static Future<String> getSessionId() async {
    String session = await getSession();
    String sessionId = session.split('-')[0];
    return sessionId;
  }

  static Future<String> getEmployeeName() async {
    String session = await getSession();
    String sessionEmployeeName = session.split('-')[1];
    return sessionEmployeeName;
  }

  static Future<String> getPositionId() async {
    String session = await getSession();
    String sessionPositionId = session.split('-')[2];
    return sessionPositionId;
  }

  static Future<String> getDivId() async {
    String session = await getSession();
    String sessionDivId = session.split('-')[3];
    return sessionDivId;
  }
}
