import 'package:flutter/material.dart';
import 'sign_up_page.dart'; // SignUpPage 파일을 import 해주세요
import 'sign_up2_page.dart'; // SignUpPage2 파일을 import 해주세요

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
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
        color: Color(0xFFEFEFEF),
        child: Center(
          child: Container(
            width: 390,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  '반가워요!',
                  style: TextStyle(
                    color: Color(0xFF181C18),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '당신의 소속을 선택해주세요',
                  style: TextStyle(
                    color: Color(0xFF181C18),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 60),
                RoleButton(
                  label: '개최자',
                  isSelected: selectedRole == 'host',
                  onTap: () {
                    setState(() {
                      selectedRole = 'host';
                    });
                  },
                ),
                SizedBox(height: 16),
                RoleButton(
                  label: '참가자',
                  isSelected: selectedRole == 'participant',
                  onTap: () {
                    setState(() {
                      selectedRole = 'participant';
                    });
                  },
                ),
                Spacer(),
                BottomButtonContainer(
                  isEnabled: selectedRole != null,
                  onPressed: selectedRole == 'participant'
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        }
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage2()),
                          );
                        },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  RoleButton({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? Color(0xFFAAD247) : Color(0xFF666B66),
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Color(0xFFAAD247) : Color(0xFF666B66),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class BottomButtonContainer extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;

  BottomButtonContainer({required this.isEnabled, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: GestureDetector(
        onTap: isEnabled ? onPressed : null,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isEnabled ? Color(0xFFAAD247) : Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(13),
          ),
          alignment: Alignment.center,
          child: Text(
            '다음으로',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
