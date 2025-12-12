import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['All', 'Academics', 'Events', 'Lost & Found'];

  final List<CommunityPost> _allPosts = [
    CommunityPost(
      id: '1',
      authorName: 'Computer Science Club',
      authorAvatar: 'CS',
      avatarColor: const Color(0xFF7C4DFF),
      timeAgo: '2 hours ago',
      category: 'Events',
      title: 'AI & Machine Learning Workshop',
      description:
          'Join us for an exciting hands-on workshop on AI fundamentals. Learn about neural networks, deep learning, and practical applications!',
      scheduledTime: 'Tomorrow, 3:00 PM',
      scheduledLocation: 'Auditorium A',
      imageUrl: 'tech_festival',
      likes: 24,
      comments: 8,
      actionText: 'Register',
      actionColor: const Color(0xFF7C4DFF),
    ),
    CommunityPost(
      id: '2',
      authorName: 'Academic Office',
      authorAvatar: 'AO',
      avatarColor: const Color(0xFF2196F3),
      timeAgo: '5 hours ago',
      category: 'Academics',
      title: 'Mid-term Exam Schedule Released',
      description:
          'The mid-term examination schedule for all departments has been published. Please check your student portal for detailed timings and venues.',
      likes: 45,
      comments: 12,
      actionText: 'View Details',
      actionColor: const Color(0xFF2196F3),
    ),
    CommunityPost(
      id: '3',
      authorName: 'Alex Kumar',
      authorAvatar: 'AK',
      avatarColor: const Color(0xFFFF7043),
      timeAgo: '1 day ago',
      category: 'Lost & Found',
      title: 'Lost: Blue Notebook',
      description:
          'Lost my Data Structures notebook near the library. It has my name on the cover. Please contact me if found!',
      likes: 3,
      comments: 5,
      actionText: 'Help Find',
      actionColor: const Color(0xFFFF7043),
    ),
    CommunityPost(
      id: '4',
      authorName: 'Sports Committee',
      authorAvatar: 'SC',
      avatarColor: const Color(0xFF4CAF50),
      timeAgo: '3 hours ago',
      category: 'Events',
      title: 'Annual Sports Day Registration',
      description:
          'Register now for the annual sports day! Events include cricket, football, basketball, athletics, and more. Limited slots available.',
      scheduledTime: 'Next Monday, 8:00 AM',
      scheduledLocation: 'Main Ground',
      likes: 67,
      comments: 23,
      actionText: 'Register',
      actionColor: const Color(0xFF4CAF50),
    ),
    CommunityPost(
      id: '5',
      authorName: 'Library Admin',
      authorAvatar: 'LA',
      avatarColor: const Color(0xFF9C27B0),
      timeAgo: '6 hours ago',
      category: 'Academics',
      title: 'Extended Library Hours',
      description:
          'During exam season, the library will remain open until 11 PM. Additional study rooms are also available for booking.',
      likes: 89,
      comments: 15,
      actionText: 'View Details',
      actionColor: const Color(0xFF9C27B0),
    ),
    CommunityPost(
      id: '6',
      authorName: 'Priya Sharma',
      authorAvatar: 'PS',
      avatarColor: const Color(0xFFE91E63),
      timeAgo: '2 days ago',
      category: 'Lost & Found',
      title: 'Found: Student ID Card',
      description:
          'Found a student ID card near the cafeteria. Name starts with "R". Contact me to claim it.',
      likes: 12,
      comments: 8,
      actionText: 'Help Find',
      actionColor: const Color(0xFFE91E63),
    ),
  ];

  List<CommunityPost> get _filteredPosts {
    if (_selectedTabIndex == 0) return _allPosts;
    final category = _tabs[_selectedTabIndex];
    return _allPosts.where((post) => post.category == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A022E),
              Color(0xFF1A1A3E),
              Color(0xFF2D1B4E),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Floating decorative circles
            ..._buildFloatingOrbs(),
            // Main content
            SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildFilterTabs(),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                      itemCount: _filteredPosts.length,
                      itemBuilder: (context, index) {
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 350 + (index * 80)),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: child,
                              ),
                            );
                          },
                          child: _PostCard(post: _filteredPosts[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF7C4DFF), Color(0xFF9C6AFF)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C4DFF).withOpacity(0.5),
              blurRadius: 16,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Create post coming soon!')),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: const Text(
            'Create Post',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFloatingOrbs() {
    return [
      // Top right purple orb
      Positioned(
        top: -50,
        right: -30,
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFF7C4DFF).withOpacity(0.4),
                const Color(0xFF7C4DFF).withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      // Bottom left orange orb
      Positioned(
        bottom: 150,
        left: -60,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFFFF9800).withOpacity(0.25),
                const Color(0xFFFF9800).withOpacity(0.08),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      // Middle right small orb
      Positioned(
        top: 300,
        right: -40,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFF9C27B0).withOpacity(0.3),
                const Color(0xFF9C27B0).withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Community',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Connect with your campus',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            _tabs.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => setState(() => _selectedTabIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: _selectedTabIndex == index
                        ? const LinearGradient(
                            colors: [Color(0xFF7C4DFF), Color(0xFF9C6AFF)],
                          )
                        : null,
                    color: _selectedTabIndex == index
                        ? null
                        : const Color(0xFF1E1E3F).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _selectedTabIndex == index
                          ? Colors.transparent
                          : Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                    boxShadow: _selectedTabIndex == index
                        ? [
                            BoxShadow(
                              color: const Color(0xFF7C4DFF).withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      color: _selectedTabIndex == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.7),
                      fontWeight: _selectedTabIndex == index
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final CommunityPost post;

  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E3F).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        post.avatarColor,
                        post.avatarColor.withOpacity(0.7),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: post.avatarColor.withOpacity(0.4),
                        blurRadius: 12,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    child: Text(
                      post.authorAvatar,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        post.timeAgo,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: post.avatarColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: post.avatarColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    post.category,
                    style: TextStyle(
                      color: post.avatarColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Post Image (if available)
          if (post.imageUrl != null) _buildPostImage(),

          // Post Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (post.category == 'Events')
                      const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text('🎉', style: TextStyle(fontSize: 16)),
                      ),
                    if (post.category == 'Academics')
                      const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text('📚', style: TextStyle(fontSize: 16)),
                      ),
                    if (post.category == 'Lost & Found')
                      const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text('🔍', style: TextStyle(fontSize: 16)),
                      ),
                    Expanded(
                      child: Text(
                        post.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  post.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                if (post.scheduledTime != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: post.avatarColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${post.scheduledTime} • ${post.scheduledLocation}',
                        style: TextStyle(
                          color: post.avatarColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Divider
          Divider(
            color: Colors.white.withOpacity(0.1),
            height: 1,
            thickness: 1,
          ),

          // Footer with likes, comments, and action
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _InteractionButton(
                  icon: Icons.favorite_border,
                  count: post.likes,
                ),
                const SizedBox(width: 16),
                _InteractionButton(
                  icon: Icons.chat_bubble_outline,
                  count: post.comments,
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.share_outlined,
                  size: 18,
                  color: Colors.white.withOpacity(0.5),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        post.actionColor,
                        post.actionColor.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: post.actionColor.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${post.actionText} - Coming soon!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      post.actionText,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostImage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF7C4DFF), Color(0xFF00BCD4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C4DFF).withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            right: 20,
            top: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 60,
            bottom: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Banner content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    '🤖 Workshop',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'TECH\nFESTIVAL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InteractionButton extends StatelessWidget {
  final IconData icon;
  final int count;

  const _InteractionButton({
    required this.icon,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white.withOpacity(0.6)),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class CommunityPost {
  final String id;
  final String authorName;
  final String authorAvatar;
  final Color avatarColor;
  final String timeAgo;
  final String category;
  final String title;
  final String description;
  final String? scheduledTime;
  final String? scheduledLocation;
  final String? imageUrl;
  final int likes;
  final int comments;
  final String actionText;
  final Color actionColor;

  CommunityPost({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.avatarColor,
    required this.timeAgo,
    required this.category,
    required this.title,
    required this.description,
    this.scheduledTime,
    this.scheduledLocation,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.actionText,
    required this.actionColor,
  });
}
