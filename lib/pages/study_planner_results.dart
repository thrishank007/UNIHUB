import 'package:flutter/material.dart';
import 'package:unihub/pages/focus_session_screen.dart';
import 'package:unihub/models/study_plan_model.dart';

class StudyPlannerResults extends StatefulWidget {
  final String subject;
  final String availableTime;
  final String focusType;
  final StudyPlanModel studyPlan;

  const StudyPlannerResults({
    super.key,
    required this.subject,
    required this.availableTime,
    required this.focusType,
    required this.studyPlan,
  });

  @override
  State<StudyPlannerResults> createState() => _StudyPlannerResultsState();
}

class _StudyPlannerResultsState extends State<StudyPlannerResults>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  // Track expanded state for each task card
  final Map<int, bool> _expandedTasks = {};
  // Track completed topics: taskIndex -> Set of topic indices
  final Map<int, Set<int>> _completedTopics = {};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    
    // Initialize tracking maps
    for (int i = 0; i < widget.studyPlan.weeklyTasks.length; i++) {
      _expandedTasks[i] = false;
      _completedTopics[i] = {};
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  // Calculate progress for a task
  double _getTaskProgress(int taskIndex) {
    final task = widget.studyPlan.weeklyTasks[taskIndex];
    if (task.topics.isEmpty) return 0.0;
    final completed = _completedTopics[taskIndex]?.length ?? 0;
    return completed / task.topics.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A022E),
                  Color(0xFF1A1A3E),
                  Color(0xFF2D1B4E),
                  Color(0xFF1A1A3E),
                  Color(0xFF0A022E),
                ],
                stops: [0.0, 0.25, 0.5, 0.75, 1.0],
              ),
            ),
          ),
          // Decorative circles
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF7C4DFF).withOpacity(0.3),
                    const Color(0xFF7C4DFF).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF9C7CFF).withOpacity(0.2),
                    const Color(0xFF9C7CFF).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF9800).withOpacity(0.15),
                    const Color(0xFFFF9800).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Column(
              children: [
                _buildCustomAppBar(),
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAIRecommendationsCard(),
                          const SizedBox(height: 24),
                          _buildStudyStreakSection(),
                          const SizedBox(height: 24),
                          _buildWeeklyPlanSection(),
                          const SizedBox(height: 24),
                          if (widget.studyPlan.keyTopics.isNotEmpty) ...[
                            _buildKeyTopicsSection(),
                            const SizedBox(height: 24),
                          ],
                          if (widget.studyPlan.studyTechniques.isNotEmpty) ...[
                            _buildStudyTechniquesSection(),
                            const SizedBox(height: 24),
                          ],
                          _buildFocusModeSection(),
                          const SizedBox(height: 40),
                        ],
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

  Widget _buildCustomAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Expanded(
            child: Text(
              'AI Study Planner',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: IconButton(
              icon: const Icon(Icons.settings, color: Colors.white70),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIRecommendationsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7C4DFF), Color(0xFF9C7CFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C4DFF).withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'AI Recommendations',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Based on your schedule and performance',
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '"${widget.studyPlan.recommendation}"',
              style: const TextStyle(color: Colors.white, fontSize: 15, fontStyle: FontStyle.italic, height: 1.4),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.amber, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.studyPlan.motivationalTip,
                  style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStudyStreakSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E3F).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Study Streak', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFFF9800), Color(0xFFFFB74D)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: const Color(0xFFFF9800).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.white, size: 18),
                    const SizedBox(width: 4),
                    Text('${widget.studyPlan.streakDays} days', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildStreakCalendar(),
        ],
      ),
    );
  }

  Widget _buildStreakCalendar() {
    final now = DateTime.now();
    final currentWeekday = now.weekday;
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: days.map((day) => SizedBox(
            width: 36,
            child: Text(day, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.w500)),
          )).toList(),
        ),
        const SizedBox(height: 12),
        ...List.generate(4, (weekIndex) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (dayIndex) {
                final isCurrentWeek = weekIndex == 3;
                final isPastDay = isCurrentWeek ? dayIndex < currentWeekday : weekIndex < 3;
                final isToday = isCurrentWeek && dayIndex == currentWeekday - 1;
                double fillLevel = 0.0;
                if (isPastDay || isToday) {
                  final totalDays = (weekIndex * 7) + dayIndex + 1;
                  if (totalDays <= widget.studyPlan.streakDays + 21) {
                    fillLevel = [0.3, 0.5, 0.7, 1.0, 0.8, 0.6, 0.9][dayIndex];
                  }
                }
                return _buildStreakCell(fillLevel: fillLevel, isToday: isToday);
              }),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildStreakCell({required double fillLevel, bool isToday = false}) {
    Color cellColor;
    if (fillLevel == 0) {
      cellColor = Colors.white.withOpacity(0.08);
    } else if (fillLevel < 0.4) {
      cellColor = const Color(0xFF7C4DFF).withOpacity(0.3);
    } else if (fillLevel < 0.7) {
      cellColor = const Color(0xFF7C4DFF).withOpacity(0.6);
    } else {
      cellColor = const Color(0xFF7C4DFF);
    }

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: cellColor,
        borderRadius: BorderRadius.circular(8),
        border: isToday ? Border.all(color: Colors.white, width: 2) : null,
        boxShadow: fillLevel > 0.7 ? [BoxShadow(color: const Color(0xFF7C4DFF).withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 2))] : null,
      ),
    );
  }

  Widget _buildWeeklyPlanSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E3F).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("This Week's Plan", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          if (widget.studyPlan.weeklyTasks.isEmpty)
            _buildEmptyTasksPlaceholder()
          else
            ...List.generate(widget.studyPlan.weeklyTasks.length, (index) {
              final task = widget.studyPlan.weeklyTasks[index];
              return _buildExpandableTaskItem(task, index, isLast: index == widget.studyPlan.weeklyTasks.length - 1);
            }),
        ],
      ),
    );
  }

  Widget _buildEmptyTasksPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
      child: Center(child: Text('No tasks generated. Try regenerating the plan.', style: TextStyle(color: Colors.white.withOpacity(0.5)))),
    );
  }

  Widget _buildExpandableTaskItem(StudyTaskModel task, int taskIndex, {bool isLast = false}) {
    final isExpanded = _expandedTasks[taskIndex] ?? false;
    final progress = _getTaskProgress(taskIndex);
    final completedCount = _completedTopics[taskIndex]?.length ?? 0;
    final totalTopics = task.topics.length;
    
    // Create topics preview string for subtitle
    final topicsPreview = task.topics.isNotEmpty 
        ? task.topics.map((t) => t.name).join(', ')
        : task.subtitle;

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isExpanded ? task.color.withOpacity(0.4) : Colors.white.withOpacity(0.08),
          width: isExpanded ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // Header (clickable to expand/collapse)
          InkWell(
            onTap: () {
              setState(() {
                _expandedTasks[taskIndex] = !isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon container
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: task.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(task.icon, color: task.color, size: 26),
                  ),
                  const SizedBox(width: 14),
                  // Title and subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          topicsPreview,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 13,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Time badge and arrow
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: task.color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${task.hoursLeft}h left',
                          style: TextStyle(
                            color: task.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white.withOpacity(0.4),
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Expandable content with progress and topics
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                // Progress bar inside expanded area
                if (totalTopics > 0) 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.white.withOpacity(0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(task.color),
                              minHeight: 5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '$completedCount/$totalTopics',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                _buildTopicsList(task, taskIndex),
              ],
            ),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicsList(StudyTaskModel task, int taskIndex) {
    if (task.topics.isEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Text(
          'No specific topics available',
          style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13, fontStyle: FontStyle.italic),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(task.topics.length, (topicIndex) {
            final topic = task.topics[topicIndex];
            final isCompleted = _completedTopics[taskIndex]?.contains(topicIndex) ?? false;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (isCompleted) {
                      _completedTopics[taskIndex]?.remove(topicIndex);
                    } else {
                      _completedTopics[taskIndex]?.add(topicIndex);
                    }
                  });
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: isCompleted 
                        ? task.color.withOpacity(0.12) 
                        : Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isCompleted 
                          ? task.color.withOpacity(0.3) 
                          : Colors.white.withOpacity(0.06),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Custom checkbox - circular style
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: isCompleted ? task.color : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isCompleted ? task.color : Colors.white.withOpacity(0.25),
                            width: 2,
                          ),
                          boxShadow: isCompleted ? [
                            BoxShadow(
                              color: task.color.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ] : null,
                        ),
                        child: isCompleted
                            ? const Icon(Icons.check, color: Colors.white, size: 16)
                            : null,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              topic.name,
                              style: TextStyle(
                                color: isCompleted 
                                    ? Colors.white.withOpacity(0.5) 
                                    : Colors.white.withOpacity(0.95),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                decoration: isCompleted ? TextDecoration.lineThrough : null,
                                decorationColor: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            if (topic.description.isNotEmpty) ...[
                              const SizedBox(height: 3),
                              Text(
                                topic.description,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.35),
                                  fontSize: 12,
                                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                                  decorationColor: Colors.white.withOpacity(0.25),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildKeyTopicsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E3F).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF4CAF50).withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.topic, color: Color(0xFF4CAF50), size: 20),
              ),
              const SizedBox(width: 12),
              const Text('Key Topics to Focus', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.studyPlan.keyTopics.map((topic) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.4)),
                ),
                child: Text(topic, style: const TextStyle(color: Color(0xFF81C784), fontSize: 13, fontWeight: FontWeight.w500)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyTechniquesSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E3F).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFFFF9800).withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.psychology, color: Color(0xFFFF9800), size: 20),
              ),
              const SizedBox(width: 12),
              const Text('Recommended Techniques', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          ...widget.studyPlan.studyTechniques.asMap().entries.map((entry) {
            final index = entry.key;
            final technique = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: const Color(0xFFFF9800).withOpacity(0.2), shape: BoxShape.circle),
                    child: Center(child: Text('${index + 1}', style: const TextStyle(color: Color(0xFFFFB74D), fontWeight: FontWeight.bold, fontSize: 13))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(technique, style: const TextStyle(color: Colors.white, fontSize: 14))),
                ],
              ),
            );
          }),
          Divider(height: 24, color: Colors.white.withOpacity(0.1)),
          Row(
            children: [
              const Icon(Icons.coffee, color: Color(0xFFBCAAA4), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.studyPlan.breakRecommendation,
                  style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFocusModeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1E1E3F).withOpacity(0.9), const Color(0xFF2D1B4E).withOpacity(0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF7C4DFF).withOpacity(0.3)),
        boxShadow: [BoxShadow(color: const Color(0xFF7C4DFF).withOpacity(0.2), blurRadius: 25, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF7C4DFF).withOpacity(0.3), const Color(0xFF9C7CFF).withOpacity(0.2)]),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: const Color(0xFF7C4DFF).withOpacity(0.3), blurRadius: 20, spreadRadius: 5)],
            ),
            child: const Icon(Icons.center_focus_strong, color: Colors.white, size: 44),
          ),
          const SizedBox(height: 20),
          const Text('Focus Mode', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Block distractions and study with AI guidance', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FocusSessionScreen(subject: widget.subject, focusType: widget.focusType)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C4DFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                shadowColor: const Color(0xFF7C4DFF).withOpacity(0.5),
              ),
              child: const Text('Start Focus Session', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            ),
          ),
        ],
      ),
    );
  }
}
