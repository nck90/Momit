import 'package:flutter/material.dart';
import 'package:momit_frontend/screens/sign_up3_page.dart';

class SignupPage2 extends StatefulWidget {
  @override
  _SignupPage2State createState() => _SignupPage2State();
}

class _SignupPage2State extends State<SignupPage2> {
  final TextEditingController organizationNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailVerificationCodeController = TextEditingController();
  String? selectedCompanyType;

  // 유효성 검사: 모든 필드가 채워졌는지 확인
  bool get isFormValid =>
      organizationNameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      emailVerificationCodeController.text.isNotEmpty &&
      selectedCompanyType != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDFDFD),
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          '회원가입',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFF5F5F5),
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      buildInputField('단체(기업)명', '단체(기업)명을 적어주세요', organizationNameController),
                      SizedBox(height: 22),
                      buildInputField('이메일', '이메일을 적어주세요', emailController),
                      SizedBox(height: 22),
                      buildInputField('이메일 인증', '인증 번호를 적어주세요', emailVerificationCodeController),
                      SizedBox(height: 22),
                      buildDropdownField('기업구분', '기업 구분을 선택해주세요', (value) {
                        setState(() {
                          selectedCompanyType = value;
                        });
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 118,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFDFDFD),
                  border: Border(top: BorderSide(color: Color(0xFFECECEC), width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildButton('이전으로', Color(0xFFFDFDFD), Color(0xFFA7ABA7), () {
                      Navigator.pop(context);
                    }),
                    buildButton(
                      '다음으로',
                      isFormValid ? Color(0xFFAAD247) : Color(0xFFE0E0E0),
                      Colors.white,
                      isFormValid
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupPage3()),
                              );
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 텍스트 입력 필드 생성
  Widget buildInputField(String label, String hintText, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: ShapeDecoration(
        color: Color(0xFFFDFDFD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF181C18),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Color(0xFF666B66),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 드롭다운 메뉴 생성
  Widget buildDropdownField(String label, String hintText, ValueChanged<String?> onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: ShapeDecoration(
        color: Color(0xFFFDFDFD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF181C18),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedCompanyType,
              hint: Text(
                hintText,
                style: TextStyle(
                  color: Color(0xFF666B66),
                  fontSize: 16,
                ),
              ),
              underline: SizedBox(),
              items: ['스타트업', '중소기업', '대기업']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  // 버튼 생성
  Widget buildButton(String text, Color backgroundColor, Color textColor, VoidCallback? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 172,
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: Color(0xFFA7ABA7), width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}