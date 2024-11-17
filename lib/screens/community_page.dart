import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "커뮤니티",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pageTitle(),
            SizedBox(height: 20),
            _sectionTitle('진행중인 행사', color: Color(0xFF677C34)),
            SizedBox(height: 16),
            _eventItem('10th : HIGHTHON', isActive: true),
            SizedBox(height: 16),
            _eventItem('DIVE 2024 (글로벌 데이터 해커톤 대회)', isActive: true),
            SizedBox(height: 32),
            _sectionTitle('종료된 행사', color: Color(0xFFA7ABA7)),
            SizedBox(height: 16),
            _eventItem('2024년 서울 빅데이터 포럼', isActive: false),
            SizedBox(height: 16),
            _eventItem('AI BUS 2024 (인공지능 컨퍼런스)', isActive: false),
          ],
        ),
      ),
    );
  }

  // 커뮤니티 페이지 상단 제목과 설명
  Widget _pageTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '커뮤니티',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '신청한 행사의 개최자와 참가자와 쉽게 소통해보세요.',
          style: TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // 섹션 제목 위젯
  Widget _sectionTitle(String title, {required Color color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // 행사 항목 위젯
  Widget _eventItem(String title, {bool isActive = true}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFB2D069) : Color(0xFFBBBBBB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Color(0xFF181C18) : Color(0xFF6A6A6A),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: isActive ? Color(0xFF181C18) : Color(0xFF6A6A6A),
          ),
        ],
      ),
    );
  }
}
