import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/monitoring_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KidGuard Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Consumer<MonitoringViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  viewModel.isMonitoringActive
                      ? Icons.security
                      : Icons.gpp_bad,
                  size: 80,
                  color: viewModel.isMonitoringActive
                      ? Colors.green
                      : Colors.red,
                ),
                const SizedBox(height: 20),
                Text(
                  viewModel.isMonitoringActive
                      ? 'Monitoring is Active'
                      : 'Monitoring is Paused',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Switch(
                  value: viewModel.isMonitoringActive,
                  onChanged: (value) {
                    viewModel.toggleMonitoring(value);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
