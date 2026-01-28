import 'package:flutter/material.dart';
import 'dart:async';
import 'cattle_detail_screen.dart';
import 'package:cattle_marketplace/features/chat/presentation/chats_screen.dart';
import 'package:cattle_marketplace/features/favorites/presentation/favorites_screen.dart';
import 'package:cattle_marketplace/features/favorites/data/favorites_manager.dart';
import 'package:cattle_marketplace/features/profile/presentation/profile_screen.dart';



class HomeBuyerScreen extends StatefulWidget {
  const HomeBuyerScreen({super.key});

  @override
  State<HomeBuyerScreen> createState() => _HomeBuyerScreenState();
}

class _HomeBuyerScreenState extends State<HomeBuyerScreen> {
  int _selectedNavIndex = 0;
  String _selectedCategory = 'Cow';
  int _currentCarouselPage = 0;
  Set<int> _favoritedIndices = {0};

  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;

  final List<List<String>> _featuredImages = [
    [
      'assets/images/buffalo1.1.jpg',
      'assets/images/buffalo_front1.1.jpg',
      'assets/images/buffalo_side1.2.jpg',
    ],
    [
      'assets/images/Cow 1.1.jpg',
      'assets/images/Cow_front1.1.jpg',
      'assets/images/Cow_side1.1.jpg',
    ],
    [
      'assets/images/goat 1.1.jpg',
      'assets/images/goat_front1.1.jpg',
      'assets/images/goat_side1.2.jpg'
    ],
  ];

  final List<Map<String, dynamic>> _gridItems = [
    {
      'images': [
        'assets/images/buffalo1.1.jpg',
        'assets/images/buffalo_front1.1.jpg',
        'assets/images/buffalo_side1.2.jpg',
      ],
      'name': 'Buffalo',
      'location': 'Multan',
      'price': 'Rs 180000',
    },
    {
      'images': [
        'assets/images/Cow 1.1.jpg',
        'assets/images/Cow_front1.1.jpg',
        'assets/images/Cow_side1.1.jpg',
      ],
      'name': 'Sahiwal Heifer',
      'location': 'Multan',
      'price': 'Rs 185000',
    },
    {
      'images': [
        'assets/images/goat 1.1.jpg',
        'assets/images/goat_front1.1.jpg',
        'assets/images/goat_side1.2.jpg',
      ],
      'name': 'Goat',
      'location': 'Multan',
      'price': 'Rs 190000',
    },
    {
      'images': [
        'assets/images/goat 1.1.jpg',
        'assets/images/goat_front1.1.jpg',
        'assets/images/goat_side1.2.jpg',
      ],
      'name': 'Goat',
      'location': 'Multan',
      'price': 'Rs 190000',
    },
    {
      'images': [
        'assets/images/Cow 1.1.jpg',
        'assets/images/Cow_front1.1.jpg',
        'assets/images/Cow_side1.1.jpg',
      ],
      'name': 'Sahiwal Heifer',
      'location': 'Multan',
      'price': 'Rs 185000',
    },
    {
      'images': [
        'assets/images/buffalo1.1.jpg',
        'assets/images/buffalo_front1.1.jpg',
        'assets/images/buffalo_side1.2.jpg',
      ],
      'name': 'Buffalo',
      'location': 'Multan',
      'price': 'Rs 180000',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoSlide();
    });
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!_pageController.hasClients) return;

      int nextPage;
      if (_currentCarouselPage < 2) {
        nextPage = _currentCarouselPage + 1;
      } else {
        nextPage = 0;
      }

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentCarouselPage = index;
    });

    _timer?.cancel();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // ← ADDED: Method to switch between screens
  Widget _getCurrentScreen() {
    switch (_selectedNavIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const FavoritesScreen();
      case 2:
        return const ChatsScreen();
      case 3:
       // return const Center(child: Text('Profile Screen - Coming Soon!'));
        return const ProfileScreen(userRole: 'Buyer');// Show Profile tab for Buyer
      default:
        return _buildHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: _getCurrentScreen(), // ← CHANGED: was SafeArea(...)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 7,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Home', 0),
                  _buildNavItem(Icons.favorite_border, 'Favorites', 1),
                  _buildNavItem(Icons.chat_bubble_outline, 'Chats', 2),
                  _buildNavItem(Icons.person_outline, 'Profile', 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedNavIndex == index;
    int unreadCount = index == 2 ? 5 : 0;

    return GestureDetector(
      onTap: () => setState(() => _selectedNavIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF52B788).withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: isSelected ? const Color(0xFF52B788) : Colors.grey[400],
                  size: 26,
                ),
                if (index == 2 && unreadCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        unreadCount > 9 ? '9+' : '$unreadCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF52B788) : Colors.grey[400],
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // ← ADDED: Your original home screen wrapped in a method
  Widget _buildHomeContent() {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // Header (FIXED - Non-scrollable)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF52B788),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        'assets/logos/Cattle Silhouette.png',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Home Screen (Buyer View)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Color(0xFF52B788), size: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Search - NOW WITH SHADOW!
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: const Icon(Icons.filter_list, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Category Chips - NOW WITH SHADOW!
          Container(
            height: 56,
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: ['Cow', 'Buffalo', 'Goat', 'Sheep', 'All'].map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedCategory = category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF52B788) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF52B788) : Colors.grey[300]!,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // SCROLLABLE CONTENT
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              primary: true,
              children: [
                const SizedBox(height: 16),

                // AUTO-SLIDING Featured Cards
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildFeaturedCard(index),
                      );
                    },
                  ),
                ),

                // Dots Indicator
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentCarouselPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentCarouselPage == index
                            ? const Color(0xFF52B788)
                            : Colors.grey[300],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 24),

                // Grid - 6 ITEMS WITH MORE PADDING
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final item = _gridItems[index];
                      return _buildCattleCard(
                        name: item['name']!,
                        location: item['location']!,
                        price: item['price']!,
                        isFavorite: _favoritedIndices.contains(index),
                        images: item['images']!,
                        index: index,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(int index) {
    final titles = ['Premium Buffalo', 'Sahiwal Cow', 'Premium Goat'];
    final prices = ['Rs 200,000', 'Rs 180,000', 'Rs 150,000'];
    final locations = ['Sukkur', 'Multan', 'Karachi'];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CattleDetailScreen(
              name: titles[index],
              price: prices[index],
              location: locations[index],
              breed: titles[index].split(' ').last,
              age: '3 Years',
              weight: '500 KG',
              images: _featuredImages[index],
              initialFavorite: false,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  _featuredImages[index][0],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF52B788),
                      child: const Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '⭐ FEATURED',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      titles[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      prices[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.white70, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          locations[index],
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
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

  Widget _buildCattleCard({
    required String name,
    required String location,
    required String price,
    required bool isFavorite,
    required List<String> images,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CattleDetailScreen(
              name: name,
              price: price,
              location: location,
              breed: name,
              age: '3 Years',
              weight: '500 KG',
              images: images,
              initialFavorite: isFavorite,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        images[0],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_favoritedIndices.contains(index)) {
                            _favoritedIndices.remove(index);
                            // Remove from favorites manager
                            FavoritesManager().removeFavorite(name + location);
                          } else {
                            _favoritedIndices.add(index);
                            // Add to favorites manager
                            FavoritesManager().addFavorite({
                              'images': images,
                              'name': name,
                              'location': location,
                              'price': price,
                              'breed': name,
                              'age': '3 Years',
                              'weight': '500 KG',
                            });
                          }
                        });
                      },

                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 12, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Color(0xFF52B788),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
