import 'package:flutter/material.dart';
import '../widgets/app_usage_graph.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KidGuard Parent Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Live Monitoring & Activity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            
            // యాప్ యూసేజ్ గ్రాఫ్ విడ్జెట్
            const AppUsageGraph(),

            // లైవ్ కంట్రోల్స్ కార్డ్స్ (Camera, Screen Mirror, Audio, Notifications)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildControlCard(context, 'Live Camera', Icons.camera_alt, Colors.red),
                  _buildControlCard(context, 'Screen Mirror', Icons.screen_share, Colors.blue),
                  _buildControlCard(context, 'Audio Listen', Icons.mic, Colors.green),
                  _buildControlCard(context, 'Notifications', Icons.notifications_active, Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlCard(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // కంట్రోల్ యాక్షన్ హ్యాండ్లింగ్
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
