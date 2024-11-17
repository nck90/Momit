import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'four_page.dart'; // LoginScreen

class SignupPage4 extends StatefulWidget {
  @override
  _SignupPage4State createState() => _SignupPage4State();
}

class _SignupPage4State extends State<SignupPage4> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;
  bool _passwordsMatch = true;
  bool _isLoading = false;
  String? _errorMessage;

  XFile? _profileImage;
  final ImagePicker _picker = ImagePicker();

  bool get _isFormComplete {
    return _idController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordConfirmController.text.isNotEmpty &&
        _passwordsMatch;
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = image;
    });
  }

  void _validatePasswords() {
    setState(() {
      _passwordsMatch = _passwordController.text == _passwordConfirmController.text;
    });
  }

  Future<void> _register() async {
    if (!_isFormComplete) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = _idController.text;

    if (prefs.containsKey(email)) {
      setState(() {
        _isLoading = false;
        _errorMessage = "이미 존재하는 이메일입니다.";
      });
      return;
    }

    await prefs.setString(email, _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("회원가입 성공!")),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFFDFDFD),
        elevation: 1,
        title: Text(
          "회원가입",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 116,
                  height: 110,
                  padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFFFDFDFD),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '프로필 사진',
                        style: TextStyle(
                          color: Color(0xFF181C18),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _profileImage == null
                          ? Image.asset(
                              'assets/profile_upload_icon.png',
                              width: 46,
                              height: 46,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(_profileImage!.path),
                                width: 46,
                                height: 46,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildInputField("아이디 (이메일)", _idController, false),
            SizedBox(height: 20),
            _buildInputField(
              "비밀번호",
              _passwordController,
              true,
              isPassword: true,
              isPasswordVisible: _passwordVisible,
              onVisibilityToggle: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            SizedBox(height: 20),
            _buildInputField(
              "비밀번호 확인",
              _passwordConfirmController,
              true,
              isPassword: true,
              isPasswordVisible: _passwordConfirmVisible,
              onVisibilityToggle: () {
                setState(() {
                  _passwordConfirmVisible = !_passwordConfirmVisible;
                });
              },
            ),
            if (!_passwordsMatch)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '비밀번호가 일치하지 않습니다.',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isFormComplete ? _register : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormComplete
                    ? Color(0xFFAAD247)
                    : Color(0xFFBDBDBD),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    bool isRequired, {
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onVisibilityToggle,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Color(0xFF666B66),
                  ),
                  onPressed: onVisibilityToggle,
                )
              : null,
        ),
      ),
    );
  }
}