import 'package:flutter/material.dart';
import 'chat_conversation_screen.dart';


class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Dummy chat data
  final List<ChatItem> _allChats = [
    ChatItem(
      name: 'Ahmed Khan',
      lastMessage: 'Is the buffalo still available?',
      time: '2:30 PM',
      unreadCount: 2,
      avatar: 'M',
      isOnline: true,
      imagePath: null,
    ),
    ChatItem(
      name: 'Qurban Ali',
      lastMessage: 'Can we negotiate the price?',
      time: '1:45 PM',
      unreadCount: 0,
      avatar: 'Q',
      isOnline: true,
      imagePath: 'assets/images/pic1.1.png',
    ),
    ChatItem(
      name: 'Fatima Sheikh',
      lastMessage: 'Thank you for the information',
      time: '12:20 PM',
      unreadCount: 0,
      avatar: 'F',
      isOnline: false,
      imagePath: null,
    ),
    ChatItem(
      name: 'Hassan Raza',
      lastMessage: 'What is the milk capacity?',
      time: 'Yesterday',
      unreadCount: 1,
      avatar: 'H',
      isOnline: false,
      imagePath: null,
    ),
    ChatItem(
      name: 'Ayesha Malik',
      lastMessage: 'I am interested in the cow',
      time: 'Yesterday',
      unreadCount: 0,
      avatar: 'A',
      isOnline: true,
      imagePath: null,
    ),
    ChatItem(
      name: 'Aafaque Ali',
      lastMessage: 'Where is the location?',
      time: 'Monday',
      unreadCount: 0,
      avatar: 'A',
      isOnline: false,
      imagePath: null,
    ),
    ChatItem(
      name: 'Zainab Tariq',
      lastMessage: 'Can I visit tomorrow?',
      time: 'Monday',
      unreadCount: 3,
      avatar: 'Z',
      isOnline: true,
      imagePath: null,
    ),
    ChatItem(
      name: 'Gh Qadir',
      lastMessage: 'Please share more pictures',
      time: 'Sunday',
      unreadCount: 0,
      avatar: 'G',
      isOnline: false,
      imagePath: null,
    ),
  ];

  List<ChatItem> get _filteredChats {
    if (_searchQuery.isEmpty) {
      return _allChats;
    }
    return _allChats
        .where((chat) =>
        chat.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF52B788),
        leading: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            'assets/logos/Cattle Silhouette.png',
            height: 28,
            width: 28,
            fit: BoxFit.cover,
          ),
        ),
        title: const Text(
          'Chats',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // More options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: const Color(0xFF52B788),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search chats...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    });
                  },
                )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // Chat List
          Expanded(
            child: _filteredChats.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No chats found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: _filteredChats.length,
              itemBuilder: (context, index) {
                final chat = _filteredChats[index];
                return _buildChatItem(chat);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(ChatItem chat) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to chat conversation screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatConversationScreen(
                userName: chat.name,
                userAvatar: chat.avatar,
                userImage: chat.imagePath,
                isOnline: chat.isOnline,
              ),
            ),
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Avatar with online indicator
              // ← ONLY CHANGED THIS SECTION
              Stack(
                children: [
                  // Show image if available, otherwise show letter
                  chat.imagePath != null
                      ? CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(chat.imagePath!),
                    backgroundColor: Colors.grey[200],
                  )
                      : CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xFF52B788),
                    child: Text(
                      chat.avatar,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (chat.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),

              // Chat info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          chat.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          chat.time,
                          style: TextStyle(
                            fontSize: 12,
                            color: chat.unreadCount > 0
                                ? const Color(0xFF52B788)
                                : Colors.grey[600],
                            fontWeight: chat.unreadCount > 0
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            chat.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: chat.unreadCount > 0
                                  ? Colors.black87
                                  : Colors.grey[600],
                              fontWeight: chat.unreadCount > 0
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (chat.unreadCount > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF52B788),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              chat.unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// Chat Item Model
class ChatItem {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String avatar;
  final bool isOnline;
  final String? imagePath;

  ChatItem({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.avatar,
    required this.isOnline,
    required this.imagePath,
  });
}
