import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "홈",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("박준원님이 신청하신 행사입니다"),
            _horizontalEventList([
              _eventCard("[서울핀테크랩] 2024 서울핀테크위크 데모데이", "D-3"),
              _eventCard("DIVE 2024 (글로벌 데이터 해커톤 대회)", "D-3"),
            ]),
            Divider(),
            _sectionTitle("박준원님 맞춤 추천 행사", showMore: true),
            _horizontalEventList([
              _eventCard("2024 서울 우먼테크 해커톤", "D-5"),
              _eventCard("제12회 K-해커톤", "D-10"),
              _eventCard("DIVE 2024 (글로벌 데이터 해커톤 대회)", "D-20"),
            ]),
            _tagsSection(),
            _sectionTitle("'해커톤' 관련 행사", showMore: true),
            _horizontalEventList([
              _eventCard("2024 서울 우먼테크 해커톤", "D-5"),
              _eventCard("제12회 K-해커톤", "D-10"),
              _eventCard("DIVE 2024 (글로벌 데이터 해커톤 대회)", "D-20"),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, {bool showMore = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          if (showMore)
            GestureDetector(
              onTap: () {},
              child: Text(
                "더보기",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF666B66),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _horizontalEventList(List<Widget> events) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: events,
      ),
    );
  }

  Widget _eventCard(String title, String dDay) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 150,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.image, size: 40, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          dDay,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tagsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _tagChip("#해커톤", isSelected: true),
          _tagChip("#세미나"),
          _tagChip("#컨퍼런스"),
          _tagChip("#특강"),
        ],
      ),
    );
  }

  Widget _tagChip(String label, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFAAD247) : Colors.grey[200],
        border:
            Border.all(color: isSelected ? Colors.transparent : Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
