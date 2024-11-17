import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CompanyMainPage extends StatefulWidget {
  @override
  _CompanyMainPageState createState() => _CompanyMainPageState();
}

class _CompanyMainPageState extends State<CompanyMainPage> {
  int currentStep = 1;
  // 첫 번째 단계 컨트롤러
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventDescriptionController = TextEditingController();
  List<String> selectedKeywords = [];
  XFile? _eventImage;

  // 두 번째 단계 컨트롤러
  TextEditingController _eventDateController = TextEditingController();
  TextEditingController _eventLocationController = TextEditingController();
  TextEditingController _eventTargetController = TextEditingController();
  TextEditingController _eventParticipantsController = TextEditingController();

  // 세 번째 단계 컨트롤러
  TextEditingController _eventApplicationScheduleController = TextEditingController();
  TextEditingController _eventContactPathController = TextEditingController();
  TextEditingController _eventOthersController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // 첫 번째 단계 리스너
    _eventNameController.addListener(_updateButtonState);
    _eventDescriptionController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    // 첫 번째 단계 컨트롤러 dispose
    _eventNameController.dispose();
    _eventDescriptionController.dispose();
    // 두 번째 단계 컨트롤러 dispose
    _eventDateController.dispose();
    _eventLocationController.dispose();
    _eventTargetController.dispose();
    _eventParticipantsController.dispose();
    // 세 번째 단계 컨트롤러 dispose
    _eventApplicationScheduleController.dispose();
    _eventContactPathController.dispose();
    _eventOthersController.dispose();
    super.dispose();
  }

  void _previousStep() {
    setState(() {
      if (currentStep > 1) currentStep--;
    });
  }

  void _nextStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    } else {
      // 등록 기능 수행
      _submitForm();
    }
  }

  void _submitForm() {
    // 등록 로직을 여기에 추가하세요.
    // 예시로 콘솔에 출력합니다.
    print('폼이 제출되었습니다.');
  }

  // 필수 입력 필드가 모두 채워졌는지 확인
  bool get _isNextEnabled {
    if (currentStep == 1) {
      return _eventNameController.text.isNotEmpty &&
          _eventDescriptionController.text.isNotEmpty &&
          selectedKeywords.isNotEmpty;
    } else if (currentStep == 2) {
      return _eventDateController.text.isNotEmpty &&
          _eventLocationController.text.isNotEmpty &&
          _eventTargetController.text.isNotEmpty &&
          _eventParticipantsController.text.isNotEmpty;
    } else if (currentStep == 3) {
      return _eventNameController.text.isNotEmpty &&
          _eventDescriptionController.text.isNotEmpty &&
          selectedKeywords.isNotEmpty &&
          _eventDateController.text.isNotEmpty &&
          _eventLocationController.text.isNotEmpty &&
          _eventTargetController.text.isNotEmpty &&
          _eventParticipantsController.text.isNotEmpty &&
          _eventApplicationScheduleController.text.isNotEmpty &&
          _eventContactPathController.text.isNotEmpty &&
          _eventOthersController.text.isNotEmpty;
    } else {
      return true;
    }
  }

  // 입력 필드의 변경 사항을 감지하여 버튼 상태 업데이트
  void _updateButtonState() {
    setState(() {});
  }

  Widget _buildStepIndicator() {
    Color activeColor = Color(0xFFAAD247);
    Color inactiveColor = Color(0xFFFDFDFD);

    return Padding(
      padding: const EdgeInsets.only(top: 16), // 단계 표시기를 위로 올리기 위해 패딩 조정
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepCircle(1, currentStep >= 1 ? activeColor : inactiveColor),
          _buildStepLine(currentStep >= 2 ? activeColor : Color(0xFFE0E0E0)),
          _buildStepCircle(2, currentStep >= 2 ? activeColor : inactiveColor),
          _buildStepLine(currentStep >= 3 ? activeColor : Color(0xFFE0E0E0)),
          _buildStepCircle(3, currentStep >= 3 ? activeColor : inactiveColor),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int step, Color color) {
    bool isActive = currentStep >= step;
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isActive ? color : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Color(0xFFAAD247),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '$step',
          style: TextStyle(
            color: isActive
                ? (color == Color(0xFFFDFDFD)
                    ? Color(0xFFAAD247)
                    : Colors.white)
                : Color(0xFFAAD247),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildStepLine(Color color) {
    return Container(
      width: 60,
      height: 2,
      color: color,
    );
  }

  Future<void> _pickEventImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _eventImage = image;
      });
      _updateButtonState();
    }
  }

  Widget _buildEventImageSection() {
    return GestureDetector(
      onTap: _pickEventImage,
      child: Container(
        width: 116,
        height: 110,
        decoration: BoxDecoration(
          color: Color(0xFFFDFDFD),
          borderRadius: BorderRadius.circular(14),
          image: _eventImage != null
              ? DecorationImage(
                  image: FileImage(File(_eventImage!.path)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _eventImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '행사 사진',
                    style: TextStyle(
                      color: Color(0xFF181C18),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Color(0xFFFDFDFD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Color(0xFF666B66),
                      size: 30,
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildInputField(String label, String hintText,
      TextEditingController controller,
      {int maxLines = 1}) {
    return Container(
      margin: EdgeInsets.only(bottom: 22), // 입력 필드 간 간격 조정
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
      decoration: BoxDecoration(
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF181C18),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 50, // 높이 고정
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              maxLines: 1, // 한 줄 입력
              onChanged: (text) {
                _updateButtonState();
              },
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeywordSection() {
    // 대표 키워드 리스트
    List<String> keywords = ['#세미나', '#컨퍼런스', '#특강', '#해커톤'];

    return Container(
      margin: EdgeInsets.only(bottom: 22), // 입력 폼이 잘리지 않도록 마진 조정
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
      decoration: BoxDecoration(
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '대표키워드',
            style: TextStyle(
              color: Color(0xFF181C18),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 22),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: keywords.map((keyword) {
              bool isSelected = selectedKeywords.contains(keyword);
              return ChoiceChip(
                label: Text(
                  keyword,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Color(0xFF666B66),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                labelPadding: EdgeInsets.symmetric(horizontal: 8),
                selected: isSelected,
                selectedColor: Color(0xFFAAD247),
                backgroundColor: Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFF666B66)),
                  borderRadius: BorderRadius.circular(16),
                ),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedKeywords.add(keyword);
                    } else {
                      selectedKeywords.remove(keyword);
                    }
                    _updateButtonState();
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 두 번째 단계 콘텐츠 빌드
  Widget _buildSecondContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          _buildInputField(
              '행사 일시', '행사를 진행하는 날짜를 적어주세요.', _eventDateController),
          _buildInputField(
              '행사 장소', '행사를 진행하는 위치를 적어주세요.', _eventLocationController),
          _buildInputField(
              '모집 대상', '행사 모집 대상을 적어주세요.', _eventTargetController),
          _buildInputField(
              '참여 인원', '행사 참여 인원을 적어주세요.', _eventParticipantsController),
        ],
      ),
    );
  }

  // 세 번째 단계 콘텐츠 빌드
  Widget _buildThirdContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          _buildInputField('참가 신청 일정', '참가 신청에 관한 일정을 적어주세요.', _eventApplicationScheduleController),
          _buildInputField('문의 경로', '문의 경로를 적어주세요.', _eventContactPathController),
          _buildInputField('기타', '기타 안내 사항을 적어주세요.', _eventOthersController),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFFFDFDFD),
        border: Border(
          top: BorderSide(color: Color(0xFFECECEC)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: currentStep > 1 ? _previousStep : null,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: Color(0xFFAAD247), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: Text(
                '이전으로',
                style: TextStyle(
                  color: Color(0xFFAAD247),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: _isNextEnabled ? _nextStep : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isNextEnabled ? Color(0xFFAAD247) : Color(0xFFA7ABA7),
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: Text(
                currentStep < 3 ? '다음으로' : '등록하기',
                style: TextStyle(
                  color: Color(0xFFFDFDFD),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (currentStep) {
      case 1:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬 추가
            children: [
              SizedBox(height: 20),
              _buildEventImageSection(),
              SizedBox(height: 20), // 행사 사진과 행사명 사이 간격 추가
              _buildInputField('행사명', '행사 이름을 적어주세요.', _eventNameController),
              _buildInputField(
                '행사 설명',
                '행사에 대해 소개해주세요.',
                _eventDescriptionController,
                maxLines: 1,
              ),
              _buildKeywordSection(),
            ],
          ),
        );
      case 2:
        return _buildSecondContent();
      case 3:
        return _buildThirdContent();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      resizeToAvoidBottomInset: true, // 키보드가 올라올 때 화면이 잘리지 않도록 함
      appBar: AppBar(
        backgroundColor: Color(0xFFFDFDFD),
        elevation: 1,
        title: Text(
          '행사 등록하기',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            _buildStepIndicator(),
            _buildContent(),
            SizedBox(height: 32), // 마지막에 여백 추가
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}