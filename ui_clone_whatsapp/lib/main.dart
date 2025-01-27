import 'package:flutter/material.dart';
import 'package:ui_clone_whatsapp/config/theme.dart';
import 'package:ui_clone_whatsapp/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => StatusProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppTheme.primaryColor,
          primary: AppTheme.primaryColor,
          secondary: AppTheme.accentColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppTheme.lightGreen,
          foregroundColor: Colors.white,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// Add this provider class for managing app state
class AppStateProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _currentLanguage = 'en';
  
  bool get isDarkMode => _isDarkMode;
  String get currentLanguage => _currentLanguage;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setLanguage(String languageCode) {
    _currentLanguage = languageCode;
    notifyListeners();
  }
}

// Add this provider for managing chat state
class ChatProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _chats = [
    {
      'name': 'John Doe',
      'lastMessage': 'Hey, how are you?',
      'time': '10:30 AM',
      'unreadCount': 2,
      'profileImage': 'https://placekitten.com/200/200',
    },
    {
      'name': 'Jane Smith',
      'lastMessage': 'Meeting at 3 PM',
      'time': '9:45 AM',
      'unreadCount': 0,
      'profileImage': 'https://placekitten.com/201/201',
    },
    {
      'name': 'Alice Johnson',
      'lastMessage': 'Thanks for your help!',
      'time': 'Yesterday',
      'unreadCount': 0,
      'profileImage': 'https://placekitten.com/202/202',
    },
    {
      'name': 'Bob Wilson',
      'lastMessage': 'See you tomorrow',
      'time': 'Yesterday',
      'unreadCount': 1,
      'profileImage': 'https://placekitten.com/203/203',
    },
  ];

  List<Map<String, dynamic>> get chats => _chats;

  void addChat(Map<String, dynamic> chat) {
    _chats.insert(0, chat);
    notifyListeners();
  }

  void updateLastMessage(String name, String message) {
    final index = _chats.indexWhere((chat) => chat['name'] == name);
    if (index != -1) {
      _chats[index]['lastMessage'] = message;
      _chats[index]['time'] = 'Just now';
      _chats[index]['unreadCount'] = 0;
      
      // Move the chat to top
      final chat = _chats.removeAt(index);
      _chats.insert(0, chat);
      
      notifyListeners();
    }
  }

  void markAsRead(String name) {
    final index = _chats.indexWhere((chat) => chat['name'] == name);
    if (index != -1) {
      _chats[index]['unreadCount'] = 0;
      notifyListeners();
    }
  }
}

// Add this provider for managing status updates
class StatusProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _statusUpdates = [
    {
      'name': 'My Status',
      'time': 'Tap to add status update',
      'imageUrl': 'https://placekitten.com/200/200',
      'hasUpdate': false,
    },
    {
      'name': 'John Doe',
      'time': '10 minutes ago',
      'imageUrl': 'https://placekitten.com/201/201',
      'hasUpdate': true,
    },
    {
      'name': 'Jane Smith',
      'time': '35 minutes ago',
      'imageUrl': 'https://placekitten.com/202/202',
      'hasUpdate': true,
    },
  ];

  List<Map<String, dynamic>> get statusUpdates => _statusUpdates;

  void addStatus(Map<String, dynamic> status) {
    _statusUpdates.add(status);
    notifyListeners();
  }

  void removeStatus(int index) {
    _statusUpdates.removeAt(index);
    notifyListeners();
  }
}
