import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_page.dart'; // 개인 회원 페이지
import 'company_main_page.dart'; // 기업 회원 페이지

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPersonalMember = true; // 개인 회원/기업 회원 구분
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  bool get isButtonActive =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String email = emailController.text;
    String password = passwordController.text;

    String? storedPassword = prefs.getString(email);

    if (storedPassword == password) {
      if (isPersonalMember) {
        // 개인 회원 로그인
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else {
        // 기업 회원 로그인
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CompanyMainPage()),
        );
      }
    } else {
      setState(() {
        errorMessage = "잘못된 이메일 또는 비밀번호입니다.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, size: 30),
                  ),
                  Spacer(),
                  Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),

            SizedBox(height: 40),

            // Membership Tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPersonalMember = true;
                    });
                  },
                  child: Text(
                    '개인 회원',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          isPersonalMember ? Color(0xFF666B66) : Color(0xFFA7ABA7),
                    ),
                  ),
                ),
                SizedBox(width: 40),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPersonalMember = false;
                    });
                  },
                  child: Text(
                    '기업 회원',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          isPersonalMember ? Color(0xFFA7ABA7) : Color(0xFFAAD247),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Highlight bar under selected tab
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 4,
                  color: isPersonalMember ? Color(0xFF666B66) : Colors.transparent,
                ),
                SizedBox(width: 40),
                Container(
                  width: 80,
                  height: 4,
                  color: isPersonalMember ? Colors.transparent : Color(0xFFAAD247),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Email Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: emailController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  hintText: '이메일 또는 아이디를 적어주세요',
                  filled: true,
                  fillColor: Color(0xFFF0F0F0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(109),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Password Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: passwordController,
                onChanged: (value) => setState(() {}),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '비밀번호를 적어주세요',
                  filled: true,
                  fillColor: Color(0xFFF0F0F0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(109),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),

            // Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: isButtonActive ? _login : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonActive
                      ? Color(0xFF666B66)
                      : Color(0xFFD9D9D9),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Center(
                  child: Text(
                    '로그인하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            // Social Login Options
            Text(
              '소셜 아이디로 간편 로그인',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFA7ABA7),
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFFEE600),
                  radius: 25,
                ),
                SizedBox(width: 20),
                CircleAvatar(
                  backgroundColor: Color(0xFF04C75B),
                  radius: 25,
                ),
                SizedBox(width: 20),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25,
                ),
              ],
            ),

            SizedBox(height: 40),

            // Links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '아이디찾기',
                  style: TextStyle(fontSize: 14, color: Color(0xFFA7ABA7)),
                ),
                SizedBox(width: 20),
                Text('|', style: TextStyle(color: Color(0xFFA7ABA7))),
                SizedBox(width: 20),
                Text(
                  '비밀번호찾기',
                  style: TextStyle(fontSize: 14, color: Color(0xFFA7ABA7)),
                ),
                SizedBox(width: 20),
                Text('|', style: TextStyle(color: Color(0xFFA7ABA7))),
                SizedBox(width: 20),
                Text(
                  '회원가입',
                  style: TextStyle(fontSize: 14, color: Color(0xFFA7ABA7)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}