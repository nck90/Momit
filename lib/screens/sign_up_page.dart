import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'second_page.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
/*************  ✨ Codeium Command ⭐  *************/
/// Builds the main application widget with a light theme and sets 
/// the home to the SignUpPage widget.
/******  64489d39-8d45-4d80-ab00-f267893ad492  *******/  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verificationController = TextEditingController();
  bool isEmailEntered = false;
  bool isFormFilled = false;
  bool isPreviousButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkEmailEntered);
    _nameController.addListener(_checkFormFilled);
    _birthDateController.addListener(_checkFormFilled);
    _emailController.addListener(_checkFormFilled);
    _verificationController.addListener(_checkFormFilled);
  }

  void _checkEmailEntered() {
    setState(() {
      isEmailEntered = _emailController.text.isNotEmpty;
    });
  }

  void _checkFormFilled() {
    setState(() {
      isFormFilled = _nameController.text.isNotEmpty &&
          _birthDateController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _verificationController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _verificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: Color(0xFFFDFDFD),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationScreen()),
            );
          },
        ),
        title: Text(
          '회원가입',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _buildTextField('이름', '실제 이름을 적어주세요', _nameController),
            SizedBox(height: 22),
            _buildTextField('생년월일 (8자리)', '생년월일을 적어주세요 (1900.01.01)', _birthDateController),
            SizedBox(height: 22),
            _buildTextFieldWithButton(
              '이메일',
              '이메일을 적어주세요',
              _emailController,
              '인증번호 받기',
              isEmailEntered,
            ),
            SizedBox(height: 22),
            _buildTextField('이메일 인증', '인증 번호를 적어주세요', _verificationController),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPreviousButton(),
                _buildNextButton(), // "다음으로" 버튼 수정
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              label,
              style: TextStyle(
                color: Color(0xFF181C18),
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: Color(0xFF666B66),
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration.collapsed(
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: Color(0xFF666B66),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithButton(String label, String placeholder, TextEditingController controller,
      String buttonText, bool isButtonEnabled) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              label,
              style: TextStyle(
                color: Color(0xFF181C18),
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: controller,
                    style: TextStyle(
                      color: Color(0xFF666B66),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: placeholder,
                      hintStyle: TextStyle(
                        color: Color(0xFF666B66),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: isButtonEnabled ? () => print("Verification code sent") : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                  decoration: BoxDecoration(
                    color: isButtonEnabled ? Color(0xFF666B66) : Color(0xFFA7ABA7),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousButton() {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPreviousButtonPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPreviousButtonPressed = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegistrationScreen()),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: 172,
        height: 50,
        decoration: BoxDecoration(
          color: isPreviousButtonPressed ? Color(0xFF8A8D8A) : Colors.white,
          border: Border.all(color: Color(0xFFA7ABA7)),
          borderRadius: BorderRadius.circular(13),
        ),
        alignment: Alignment.center,
        child: Text(
          '이전으로',
          style: TextStyle(
            color: Color(0xFFA7ABA7),
            fontSize: 18,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: isFormFilled
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()), // SecondPage로 이동
              );
            }
          : null,
      child: Container(
        width: 172,
        height: 50,
        decoration: BoxDecoration(
          color: isFormFilled ? Color(0xFFAAD247) : Color(0xFFA7ABA7),
          borderRadius: BorderRadius.circular(13),
        ),
        alignment: Alignment.center,
          child: Text(
            '다음으로',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}