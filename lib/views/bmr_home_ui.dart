import 'package:flutter/material.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  TextEditingController weightCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();

  bool isMan = false;
  bool isFemale = false;
  double? bmr;

  void showWarningMSG(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('คำเตือน'),
        content: Text(msg),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  void calculateBMR() {
    if (!isMan && !isFemale) {
      showWarningMSG(context, 'โปรดเลือกเพศก่อน');
      return;
    }

    if (weightCtrl.text.isEmpty) {
      showWarningMSG(context, 'โปรดป้อนน้ำหนักด้วย...');
      return;
    }
    if (heightCtrl.text.isEmpty) {
      showWarningMSG(context, 'โปรดป้อนส่วนสูงด้วย...');
      return;
    }
    if (ageCtrl.text.isEmpty) {
      showWarningMSG(context, 'โปรดป้อนอายุด้วย...');
      return;
    }

    double weight = double.parse(weightCtrl.text);
    double height = double.parse(heightCtrl.text);
    int age = int.parse(ageCtrl.text);

    setState(() {
      if (isMan) {
        bmr = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
      } else if (isFemale) {
        bmr = 65.5 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
      }
    });
  }

  void resetForm() {
    setState(() {
      isMan = false;
      isFemale = false;
      weightCtrl.clear();
      heightCtrl.clear();
      ageCtrl.clear();
      bmr = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('BMR App'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.width * 0.1),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icon/bmr.jpg',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.1),
            Row(
              children: [
                Icon(Icons.person, color: Colors.black),
                Checkbox(
                  value: isMan,
                  activeColor: Colors.deepOrange,
                  onChanged: (value) {
                    setState(() {
                      isMan = value!;
                      if (isMan) isFemale = false;
                    });
                  },
                  
                ),
                
                Text('     ชาย'),
                SizedBox(width: 40),
                Checkbox(
                  value: isFemale,
                  activeColor: Colors.deepOrange,
                  onChanged: (value) {
                    setState(() {
                      isFemale = value!;
                      if (isFemale) isMan = false;
                    });
                  },
                ),
                Text('    หญิง'),
              ],
            ),
            SizedBox(height: 20),
            buildInputRow(Icons.monitor_weight, 'กิโลกรัม', weightCtrl),
            buildInputRow(Icons.height, 'เซนติเมตร', heightCtrl),
            buildInputRow(Icons.elderly, 'ปี', ageCtrl),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: calculateBMR,
                    child: Text('คำนวณ'),
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: resetForm,
                    child: Text('ยกเลิก'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            
              Column(
                children: [
                  Divider(thickness: 1),
                  Text(
                    'อัตราการเผาผลาญพลังงาน',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    bmr != null ? bmr!.toStringAsFixed(2) : '-???-',
                    style: TextStyle(fontSize: 24, color: Colors.deepOrange),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildInputRow(IconData icon, String unit, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: ctrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '0.00',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(unit),
        ],
      ),
    );
  }
}