import 'package:flutter/material.dart';

class GoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Savings Goals'),
      ),
      body: ListView(
        children: [
          _buildGoalCard(
            'Emergency Fund',
            20000,
            15000,
            'RM 5,000 to go',
            Colors.blue,
          ),
          _buildGoalCard(
            'New Car',
            80000,
            30000,
            'RM 50,000 to go',
            Colors.green,
          ),
          _buildGoalCard(
            'Holiday Trip',
            5000,
            3500,
            'RM 1,500 to go',
            Colors.orange,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new goal
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildGoalCard(String title, double target, double current, String remaining, Color color) {
    double progress = current / target;
    
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RM ${current.toStringAsFixed(2)}'),
                Text('RM ${target.toStringAsFixed(2)}'),
              ],
            ),
            SizedBox(height: 8),
            Text(
              remaining,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
} 