import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> register(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 이메일 중복 확인
    String? existingUser = prefs.getString(email);
    if (existingUser != null) {
      return false; // 이미 등록된 사용자
    }

    // 사용자 데이터 저장
    await prefs.setString(email, password);
    return true;
  }

  Future<bool> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 저장된 비밀번호 확인
    String? storedPassword = prefs.getString(email);
    if (storedPassword != null && storedPassword == password) {
      return true; // 로그인 성공
    }
    return false; // 로그인 실패
  }
}