import 'package:flutter/material.dart';

enum ReminderCategory { all, academic, community, exams }

enum ReminderType { classReminder, studySession, labSchedule, assignmentDue }

class Reminder {
  final String id;
  final String title;
  final String description;
  final ReminderType type;
  final ReminderCategory category;
  final DateTime createdAt;
  final bool isAiSuggestion;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.createdAt,
    this.isAiSuggestion = false,
  });

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    }
  }
}

class SmartRemindersScreen extends StatefulWidget {
  const SmartRemindersScreen({super.key});

  @override
  State<SmartRemindersScreen> createState() => _SmartRemindersScreenState();
}

class _SmartRemindersScreenState extends State<SmartRemindersScreen> {
  ReminderCategory _selectedCategory = ReminderCategory.all;

  final List<Reminder> _reminders = [
    Reminder(
      id: '1',
      title: 'Class Reminder',
      description: 'Data Structures class starts in 10 minutes - Room 301',
      type: ReminderType.classReminder,
      category: ReminderCategory.academic,
      createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
    ),
    Reminder(
      id: '2',
      title: 'Study Session Reminder',
      description: 'Perfect time to review Neural Networks - you have 2 hours free',
      type: ReminderType.studySession,
      category: ReminderCategory.academic,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      isAiSuggestion: true,
    ),
    Reminder(
      id: '3',
      title: 'Lab Schedule',
      description: 'Tomorrow: Machine Learning Lab at 2 PM - Lab 2',
      type: ReminderType.labSchedule,
      category: ReminderCategory.academic,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Reminder(
      id: '4',
      title: 'Assignment Due',
      description: 'Neural Networks assignment due in 2 days',
      type: ReminderType.assignmentDue,
      category: ReminderCategory.exams,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  List<Reminder> get _filteredReminders {
    if (_selectedCategory == ReminderCategory.all) {
      return _reminders;
    }
    return _reminders.where((r) => r.category == _selectedCategory).toList();
  }

  void _addReminder(Reminder reminder) {
    setState(() {
      _reminders.insert(0, reminder);
    });
  }

  void _deleteReminder(String id) {
    setState(() {
      _reminders.removeWhere((r) => r.id == id);
    });
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
                    child: _filteredReminders.isEmpty
                        ? _buildEmptyState()
                        : _buildRemindersList(),
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
          onPressed: () => _showAddReminderSheet(context),
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: const Text(
            'Add Reminder',
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Smart Notifications',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Never miss an important update',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.6),
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
              Icons.notifications_active_rounded,
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
          children: ReminderCategory.values.map((category) {
            final isSelected = _selectedCategory == category;
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => setState(() => _selectedCategory = category),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFF7C4DFF), Color(0xFF9C6AFF)],
                          )
                        : null,
                    color: isSelected ? null : const Color(0xFF1E1E3F).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                    boxShadow: isSelected
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
                    _getCategoryLabel(category),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRemindersList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      itemCount: _filteredReminders.length,
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
          child: _ReminderCard(
            reminder: _filteredReminders[index],
            onDelete: () => _deleteReminder(_filteredReminders[index].id),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF7C4DFF).withOpacity(0.2),
                  const Color(0xFF7C4DFF).withOpacity(0.05),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7C4DFF).withOpacity(0.2),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              size: 48,
              color: Color(0xFF7C4DFF),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No reminders yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the button below to add your first reminder',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryLabel(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.all:
        return 'All';
      case ReminderCategory.academic:
        return 'Academic';
      case ReminderCategory.community:
        return 'Community';
      case ReminderCategory.exams:
        return 'Exams';
    }
  }

  void _showAddReminderSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddReminderSheet(
        onAdd: _addReminder,
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onDelete;

  const _ReminderCard({
    required this.reminder,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getIconConfig();

    return Dismissible(
      key: Key(reminder.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFF5252).withOpacity(0.8),
              const Color(0xFFFF1744).withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_rounded, color: Colors.white, size: 26),
      ),
      child: Container(
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
              color: Colors.black.withOpacity(0.2),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: config.iconColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Subtle glow on left side
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        config.iconColor,
                        config.iconColor.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIcon(),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  reminder.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                              if (reminder.isAiSuggestion) _buildAiTag(),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            reminder.description,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.65),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 14,
                                color: Colors.white.withOpacity(0.4),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                reminder.timeAgo,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white.withOpacity(0.4),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  Widget _buildIcon() {
    final config = _getIconConfig();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            config.iconColor.withOpacity(0.25),
            config.iconColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: config.iconColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: config.iconColor.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        config.icon,
        color: config.iconColor,
        size: 22,
      ),
    );
  }

  Widget _buildAiTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF7C4DFF).withOpacity(0.3),
            const Color(0xFF9C6AFF).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF7C4DFF).withOpacity(0.4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C4DFF).withOpacity(0.2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.auto_awesome,
            size: 12,
            color: const Color(0xFF7C4DFF).withOpacity(0.9),
          ),
          const SizedBox(width: 4),
          const Text(
            'AI Suggestion',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFFB794FF),
            ),
          ),
        ],
      ),
    );
  }

  _IconConfig _getIconConfig() {
    switch (reminder.type) {
      case ReminderType.classReminder:
        return _IconConfig(
          icon: Icons.school_rounded,
          iconColor: const Color(0xFF7C4DFF),
          backgroundColor: const Color(0xFF7C4DFF).withOpacity(0.15),
        );
      case ReminderType.studySession:
        return _IconConfig(
          icon: Icons.auto_stories_rounded,
          iconColor: const Color(0xFFB794FF),
          backgroundColor: const Color(0xFFB794FF).withOpacity(0.15),
        );
      case ReminderType.labSchedule:
        return _IconConfig(
          icon: Icons.science_rounded,
          iconColor: const Color(0xFFFFB74D),
          backgroundColor: const Color(0xFFFFB74D).withOpacity(0.15),
        );
      case ReminderType.assignmentDue:
        return _IconConfig(
          icon: Icons.assignment_rounded,
          iconColor: const Color(0xFFFF7043),
          backgroundColor: const Color(0xFFFF7043).withOpacity(0.15),
        );
    }
  }
}

class _IconConfig {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  _IconConfig({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });
}

class _AddReminderSheet extends StatefulWidget {
  final Function(Reminder) onAdd;

  const _AddReminderSheet({required this.onAdd});

  @override
  State<_AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends State<_AddReminderSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  ReminderType _selectedType = ReminderType.classReminder;
  ReminderCategory _selectedCategory = ReminderCategory.academic;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1E1E3F),
            Color(0xFF0A022E),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7C4DFF), Color(0xFF9C6AFF)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C4DFF).withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add_alert_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add New Reminder',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Stay organized and never miss a deadline',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _buildTextField(
                controller: _titleController,
                label: 'Title',
                hint: 'e.g., Class Reminder',
                icon: Icons.title_rounded,
              ),
              const SizedBox(height: 18),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'e.g., Math class in Room 205',
                icon: Icons.description_outlined,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Text(
                'Reminder Type',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 12),
              _buildTypeSelector(),
              const SizedBox(height: 24),
              Text(
                'Category',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 12),
              _buildCategorySelector(),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C4DFF), Color(0xFF9C6AFF)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7C4DFF).withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _handleAdd,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_rounded, size: 22),
                        SizedBox(width: 8),
                        Text(
                          'Add Reminder',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 14,
            ),
            prefixIcon: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF7C4DFF).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF7C4DFF),
                size: 20,
              ),
            ),
            filled: true,
            fillColor: const Color(0xFF1E1E3F).withOpacity(0.8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF7C4DFF),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: ReminderType.values.map((type) {
        final isSelected = _selectedType == type;
        final color = _getTypeColor(type);
        return GestureDetector(
          onTap: () => setState(() => _selectedType = type),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      colors: [
                        color.withOpacity(0.3),
                        color.withOpacity(0.15),
                      ],
                    )
                  : null,
              color: isSelected ? null : const Color(0xFF1E1E3F).withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? color.withOpacity(0.5) : Colors.white.withOpacity(0.1),
                width: 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getTypeIcon(type),
                  size: 18,
                  color: isSelected ? color : Colors.white.withOpacity(0.5),
                ),
                const SizedBox(width: 6),
                Text(
                  _getTypeLabel(type),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? color : Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategorySelector() {
    final categories = [
      ReminderCategory.academic,
      ReminderCategory.community,
      ReminderCategory.exams,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
      children: categories.map((category) {
        final isSelected = _selectedCategory == category;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => setState(() => _selectedCategory = category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFF7C4DFF), Color(0xFF9C6AFF)],
                      )
                    : null,
                color: isSelected ? null : const Color(0xFF1E1E3F).withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF7C4DFF).withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                _getCategoryLabel(category),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );}

  void _handleAdd() {
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all fields'),
          backgroundColor: const Color(0xFFFF5252),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    final reminder = Reminder(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      type: _selectedType,
      category: _selectedCategory,
      createdAt: DateTime.now(),
    );

    widget.onAdd(reminder);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Reminder added successfully!'),
          ],
        ),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  String _getTypeLabel(ReminderType type) {
    switch (type) {
      case ReminderType.classReminder:
        return 'Class';
      case ReminderType.studySession:
        return 'Study';
      case ReminderType.labSchedule:
        return 'Lab';
      case ReminderType.assignmentDue:
        return 'Assignment';
    }
  }

  IconData _getTypeIcon(ReminderType type) {
    switch (type) {
      case ReminderType.classReminder:
        return Icons.school_rounded;
      case ReminderType.studySession:
        return Icons.auto_stories_rounded;
      case ReminderType.labSchedule:
        return Icons.science_rounded;
      case ReminderType.assignmentDue:
        return Icons.assignment_rounded;
    }
  }

  Color _getTypeColor(ReminderType type) {
    switch (type) {
      case ReminderType.classReminder:
        return const Color(0xFF7C4DFF);
      case ReminderType.studySession:
        return const Color(0xFFB794FF);
      case ReminderType.labSchedule:
        return const Color(0xFFFFB74D);
      case ReminderType.assignmentDue:
        return const Color(0xFFFF7043);
    }
  }

  String _getCategoryLabel(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.all:
        return 'All';
      case ReminderCategory.academic:
        return 'Academic';
      case ReminderCategory.community:
        return 'Community';
      case ReminderCategory.exams:
        return 'Exams';
    }
  }
}
