import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic/wallet.dart';
import 'logic/trading_engine.dart';
import 'screens/dashboard.dart';
import 'screens/chart.dart';
import 'screens/settings.dart';
import 'screens/history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final wallet = Wallet();
  await wallet.loadState();
  runApp(MyApp(wallet: wallet));
}

class MyApp extends StatelessWidget {
  final Wallet wallet;
  MyApp({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => wallet),
        Provider(create: (_) => TradingEngine()),
      ],
      child: MaterialApp(
        title: 'CryptoSim Move Upgraded',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  final _pages = [DashboardScreen(), ChartScreen(), HistoryScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Chart'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}