import 'package:flutter/material.dart';
import 'package:fitflow/shared/theme/app_theme.dart';
import 'package:fitflow/shared/widgets/section_title.dart';

class AiWorkoutScreen extends StatefulWidget {
  const AiWorkoutScreen({super.key});

  @override
  State<AiWorkoutScreen> createState() => _AiWorkoutScreenState();
}

class _AiWorkoutScreenState extends State<AiWorkoutScreen> {
  String _selectedGoal = 'Muscle Gain';
  String _selectedLevel = 'Intermediate';
  int _selectedTime = 20;

  static const List<String> _goals = [
    'Weight Loss',
    'Muscle Gain',
    'Endurance',
    'Flexibility',
  ];

  static const List<String> _levels = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  static const List<int> _times = [15, 20, 30, 45, 60];

  static const List<_Exercise> _exercises = [
    _Exercise(name: 'Squats', sets: 3, reps: '12 reps', icon: Icons.accessibility_new_rounded),
    _Exercise(name: 'Push Ups', sets: 3, reps: '10 reps', icon: Icons.sports_gymnastics),
    _Exercise(name: 'Lunges', sets: 3, reps: '12 reps', icon: Icons.directions_walk_rounded),
    _Exercise(name: 'Plank', sets: 3, reps: '30 sec', icon: Icons.self_improvement_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Workout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'About AI Workout',
            onPressed: () => _showPrototypeInfo(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderCard(),
              const SizedBox(height: AppTheme.spacingLG),
              _GoalSelector(
                selected: _selectedGoal,
                options: _goals,
                onChanged: (v) => setState(() => _selectedGoal = v),
              ),
              const SizedBox(height: AppTheme.spacingLG),
              _LevelSelector(
                selected: _selectedLevel,
                options: _levels,
                onChanged: (v) => setState(() => _selectedLevel = v),
              ),
              const SizedBox(height: AppTheme.spacingLG),
              _TimeSelector(
                selected: _selectedTime,
                options: _times,
                onChanged: (v) => setState(() => _selectedTime = v),
              ),
              const SizedBox(height: AppTheme.spacingLG),
              _WorkoutPlanSection(exercises: _exercises),
              const SizedBox(height: AppTheme.spacingLG),
              _ActionButtons(),
              const SizedBox(height: AppTheme.spacingMD),
            ],
          ),
        ),
      ),
    );
  }

  void _showPrototypeInfo(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('About AI Workout'),
        content: const Text(
          'This is a UI prototype. In the final product, '
          'an AI model will generate a personalised workout plan '
          'based on your goals, fitness level, available equipment, '
          'and workout history.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppTheme.primaryGreen,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'AI Personalized Workout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Tailored to your goals\nand fitness level.',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalSelector extends StatelessWidget {
  final String selected;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const _GoalSelector({
    required this.selected,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Goal'),
        const SizedBox(height: AppTheme.spacingSM),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((goal) {
            final isSelected = goal == selected;
            return ChoiceChip(
              label: Text(goal),
              selected: isSelected,
              selectedColor: AppTheme.lightGreen,
              onSelected: (_) => onChanged(goal),
              labelStyle: TextStyle(
                color: isSelected ? AppTheme.darkGreen : AppTheme.textMedium,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? AppTheme.primaryGreen : AppTheme.divider,
              ),
              backgroundColor: AppTheme.cardWhite,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _LevelSelector extends StatelessWidget {
  final String selected;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const _LevelSelector({
    required this.selected,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Fitness Level'),
        const SizedBox(height: AppTheme.spacingSM),
        Row(
          children: options.map((level) {
            final isSelected = level == selected;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: level != options.last ? 8 : 0,
                ),
                child: GestureDetector(
                  onTap: () => onChanged(level),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryGreen
                          : AppTheme.cardWhite,
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusMD),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primaryGreen
                            : AppTheme.divider,
                      ),
                    ),
                    child: Text(
                      level,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : AppTheme.textMedium,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _TimeSelector extends StatelessWidget {
  final int selected;
  final List<int> options;
  final ValueChanged<int> onChanged;

  const _TimeSelector({
    required this.selected,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Available Time'),
        const SizedBox(height: AppTheme.spacingSM),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((t) {
            final isSelected = t == selected;
            return ChoiceChip(
              label: Text('$t min'),
              selected: isSelected,
              selectedColor: AppTheme.lightGreen,
              onSelected: (_) => onChanged(t),
              labelStyle: TextStyle(
                color: isSelected ? AppTheme.darkGreen : AppTheme.textMedium,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              side: BorderSide(
                color: isSelected ? AppTheme.primaryGreen : AppTheme.divider,
              ),
              backgroundColor: AppTheme.cardWhite,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _WorkoutPlanSection extends StatelessWidget {
  final List<_Exercise> exercises;
  const _WorkoutPlanSection({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Your Plan'),
        const SizedBox(height: AppTheme.spacingMD),
        Card(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: exercises.length,
            separatorBuilder: (_, _) =>
                const Divider(height: 1, indent: 64),
            itemBuilder: (_, i) => _ExerciseTile(exercise: exercises[i], index: i),
          ),
        ),
      ],
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  final _Exercise exercise;
  final int index;
  const _ExerciseTile({required this.exercise, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.lightGreen,
          borderRadius: BorderRadius.circular(AppTheme.radiusSM),
        ),
        child: Icon(exercise.icon, color: AppTheme.primaryGreen, size: 20),
      ),
      title: Text(
        exercise.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppTheme.textDark,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        '${exercise.sets} sets · ${exercise.reps}',
        style: const TextStyle(color: AppTheme.textMedium, fontSize: 13),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.bgSurface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '#${index + 1}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textMedium,
          ),
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('Start Workout'),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.tune_rounded),
          label: const Text('Customize Plan'),
        ),
      ],
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────

class _Exercise {
  final String name;
  final int sets;
  final String reps;
  final IconData icon;
  const _Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.icon,
  });
}
