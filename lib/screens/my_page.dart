import 'package:flutter/material.dart';
import 'four_page.dart'; // LoginScreen 정의된 파일을 import

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  late TabController _tabController;

  final List<Widget> _tabPages = [
    BusinessCardTab(),
    QRTab(),
    FavoritesTab(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: _tabIndex);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F2F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '마이 페이지',
          style: TextStyle(
            color: Color(0xFF181C18),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Color(0xFF6C6F7E)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Color(0xFFE0E0E0),
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          // 프로필 섹션
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFD9D9D9),
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '박준원',
                      style: TextStyle(
                        color: Color(0xFF181C18),
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '@jw_08',
                      style: TextStyle(
                        color: Color(0xFFA7ABA7),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 탭 바
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Color(0xFFAAD247), // 연두색 인디케이터
              labelColor: Color(0xFFAAD247), // 연두색 탭 텍스트
              unselectedLabelColor: Color(0xFF6C6F7E), // 비활성 탭 텍스트 색상
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: '명함'),
                Tab(text: 'QR'),
                Tab(text: '관심 행사'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabPages,
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessCardTab extends StatelessWidget {
  final List<Map<String, String>> businessCards = [
    {
      "name": "김예린",
      "position": "UI/UX Designer",
      "company": "ABC 디자인 스튜디오",
      "email": "yerin.kim@example.com",
    },
    {
      "name": "최수진",
      "position": "Software Engineer",
      "company": "XYZ 테크",
      "email": "soojin.choi@example.com",
    },
    {
      "name": "박민수",
      "position": "Product Manager",
      "company": "123 솔루션",
      "email": "minsu.park@example.com",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: businessCards.length,
        itemBuilder: (context, index) {
          final card = businessCards[index];
          return BusinessCard(
            name: card["name"]!,
            position: card["position"]!,
            company: card["company"]!,
            email: card["email"]!,
          );
        },
      ),
    );
  }
}

class BusinessCard extends StatelessWidget {
  final String name;
  final String position;
  final String company;
  final String email;

  BusinessCard({
    required this.name,
    required this.position,
    required this.company,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.white, // 하얀색 배경
          radius: 28,
          child: Icon(
            Icons.person,
            size: 28,
            color: Color(0xFFAAD247),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            color: Color(0xFF181C18),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                position,
                style: TextStyle(
                  color: Color(0xFF6C6F7E),
                  fontSize: 16,
                ),
              ),
              Text(
                company,
                style: TextStyle(
                  color: Color(0xFF6C6F7E),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                email,
                style: TextStyle(
                  color: Color(0xFFAAD247), // 연두색 이메일 텍스트
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF6C6F7E),
          size: 16,
        ),
        onTap: () {
          // 명함 상세 페이지로 이동하는 코드 추가 가능
        },
      ),
    );
  }
}

class QRTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "QR 코드 스캔 및 생성 기능을 여기에 추가하세요.",
        style: TextStyle(
          color: Color(0xFF181C18),
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "관심 행사 목록을 여기에 표시하세요.",
        style: TextStyle(
          color: Color(0xFF181C18),
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}