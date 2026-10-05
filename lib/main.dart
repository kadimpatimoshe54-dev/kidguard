import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/monitoring_viewmodel.dart';
import 'views/dashboard_view.dart';

void main() {
  runApp(const KidGuardApp());
}

class KidGuardApp extends StatelessWidget {
  const KidGuardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MonitoringViewModel()),
      ],
      child: MaterialApp(
        title: 'KidGuard Parental Control',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const DashboardView(),
      ),
    );
  }
}
  
