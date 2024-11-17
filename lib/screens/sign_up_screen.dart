import 'package:flutter/material.dart';
import 'registration_screen.dart';
import '../widgets/custom_button.dart';
import 'four_page.dart'; // LoginScreen을 가져오기 위해 추가

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: Center(
        child: Container(
          width: 390,
          height: 844,
          child: Stack(
            children: [
              // 로고 부분
              Positioned(
                left: 160,
                top: 150,
                child: Container(
                  width: 70,
                  height: 66,
                  child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                ),
              ),
              Positioned(
                left: 41,
                top: 338,
                child: Text(
                  '모밋에서 원하는 행사를 찾아보세요!',
                  style: TextStyle(
                    color: Color(0xFF387F39),
                    fontSize: 22,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 380,
                child: Text(
                  '개최자 또는 참가자와 편하고 빠르게\n효율적으로 의사소통 할 수 있어요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFA7ABA7),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 635,
                child: CustomButton(
                  text: '시작하기',
                  textColor: Colors.white,
                  backgroundColor: Color(0xFF387F39),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()),
                    );
                  },
                ),
              ),
              Positioned(
                left: 20,
                top: 705,
                child: CustomButton(
                  text: '로그인',
                  textColor: Color(0xFF387F39),
                  backgroundColor: Color(0xFFFDFDFD),
                  onPressed: () {
                    // 로그인 버튼 클릭 시 LoginScreen으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}