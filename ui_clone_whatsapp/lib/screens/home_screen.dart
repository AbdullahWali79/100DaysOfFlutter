import 'package:flutter/material.dart';
import 'package:ui_clone_whatsapp/config/theme.dart';
import 'package:ui_clone_whatsapp/widgets/chat_list.dart';
import 'package:ui_clone_whatsapp/widgets/status_list.dart';
import 'package:ui_clone_whatsapp/widgets/calls_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                autofocus: true,
              )
            : const Text('WhatsApp'),
        actions: [
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _stopSearch,
            )
          else ...[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _startSearch,
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                // Handle menu item selection
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'new_group',
                    child: Text('New group'),
                  ),
                  const PopupMenuItem(
                    value: 'new_broadcast',
                    child: Text('New broadcast'),
                  ),
                  const PopupMenuItem(
                    value: 'linked_devices',
                    child: Text('Linked devices'),
                  ),
                  const PopupMenuItem(
                    value: 'starred_messages',
                    child: Text('Starred messages'),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Text('Settings'),
                  ),
                ];
              },
            ),
          ],
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ChatList(),
          StatusList(),
          CallsList(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    switch (_tabController.index) {
      case 0:
        return FloatingActionButton(
          onPressed: () {
            // Navigate to new chat screen
          },
          child: const Icon(Icons.message),
        );
      case 1:
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              mini: true,
              onPressed: () {
                // Navigate to text status screen
              },
              child: const Icon(Icons.edit),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                // Navigate to camera for status
              },
              child: const Icon(Icons.camera_alt),
            ),
          ],
        );
      case 2:
        return FloatingActionButton(
          onPressed: () {
            // Navigate to new call screen
          },
          child: const Icon(Icons.add_call),
        );
      default:
        return Container();
    }
  }
}
