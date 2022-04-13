import 'package:flutter/material.dart';

//คำแนะนำการทานยา

class GuidePill extends StatefulWidget {
  @override
  _GuidePillState createState() => _GuidePillState();
}

class _GuidePillState extends State<GuidePill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3a73b5),
        title: Text('คำแนะนำการใช้ยา'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '      หากท่านลืมทานยา กรุณาปฏิบัติตามคำแนะนำต่อไปนี้',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          Text(
            '       1. ยาก่อนอาหาร ',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '       ควรทานก่อนอาหาร 30 นาที [ยกเว้นยาเบาหวานบางรายการ] หากเวลาที่นึกได้ว่าลืมทานยา ไม่ใกล้กับเวลาที่ต้องทานยาครั้งต่อไปขอให้ทานยาโดยต้องทานยาในเวลาท้องว่างคือหลังรับประทานอาหาร 2 ชั่วโมง',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Text(
            '       2. ยาหลังอาหาร ',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '       ควรทานหลังอาหารทันทีหรือหลังอาหารภายในเวลาไม่เกิน 15 นาที หากเวลาที่นึกได้ว่าลืมทานยา ไม่ใกล้กับเวลาที่ต้องทานยาครั้งต่อไปขอให้ทานยา โดยทานอาหารมื้อย่อยก่อน',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Text(
            '       3. ยาก่อนนอน ',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '       กรณียาที่ทานเป็นยาก่อนนอนขอให้ข้ามยามือนั้นไปแล้วทานในคืนต่อไปได้เลย',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Text(
            '       4. ยาอื่นๆ ',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '       ยาอื่น ๆ ที่มีวิธีการใช้เฉพาะหรือยาโรคเบาหวานโปรดปรึกษาแพทย์หรือเภสัชกรเมื่อลืมรับประทานยา',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
