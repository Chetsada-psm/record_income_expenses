import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:record_income_expenses/add_transaction_screen.dart';
import 'package:record_income_expenses/transaction_model.dart';
import 'transaction_model.dart' as custom;

class TransactionListScreen extends StatefulWidget {
  final List<custom.UserTransaction> transactions;

  TransactionListScreen({Key? key, required this.transactions}) : super(key: key);

  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}


class _TransactionListScreenState extends State<TransactionListScreen> {
  bool showChart = false;
  List<custom.UserTransaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('Income and expenses').get();

    setState(() {
      _transactions = snapshot.docs.map((doc) {
        var transaction = custom.UserTransaction.fromFirestore(doc);
        return transaction;
      }).toList();
    });
  }

  void _addTransaction(custom.UserTransaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
    fetchTransactions(); // รีเฟรชข้อมูลหลังจากเพิ่ม
  }

  double get totalIncome => _transactions
      .where((tx) => tx.type == 'รายรับ')
      .fold(0.0, (sum, item) => sum + item.amount);

  double get totalExpense => _transactions
      .where((tx) => tx.type == 'รายจ่าย')
      .fold(0.0, (sum, item) => sum + item.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการรายรับรายจ่าย'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 207, 244, 185),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8, spreadRadius: 2),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('รวมรายรับ: $totalIncome บาท', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                  Text('รวมรายจ่าย: $totalExpense บาท', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showChart = !showChart;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 182, 238, 233),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: Text(showChart ? 'ซ่อนกราฟย้อนหลัง 2 เดือน' : 'แสดงกราฟย้อนหลัง 2 เดือน'),
            ),
            SizedBox(height: 20),
            if (showChart)
              Container(
                height: 300,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8, spreadRadius: 2),
                  ],
                ),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceEvenly,
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(toY: totalIncome, color: Colors.green),
                          BarChartRodData(toY: totalExpense, color: Colors.red),
                        ],
                        showingTooltipIndicators: [0, 1],
                      ),
                      // คุณสามารถปรับแก้ค่าเพื่อแสดงกราฟในเดือนที่ต่างออกไป
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            switch (value.toInt()) {
                              case 0:
                                return Text('เดือนที่แล้ว');
                              case 1:
                                return Text('เดือนนี้');
                              default:
                                return Text('');
                            }
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final tx = _transactions[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(tx.note, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${tx.amount} บาท - ${tx.type}'),
                      trailing: Text(tx.date.toLocal().toString(), style: TextStyle(color: Colors.grey)),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTransactionScreen(onAddTransaction: _addTransaction),
                  ),
                );
              },
              child: Text('เพิ่มรายการ'),
            ),
          ],
        ),
      ),
    );
  }
}
