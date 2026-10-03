import 'package:flutter/material.dart';
import 'package:fitflow/shared/theme/app_theme.dart';
import 'package:fitflow/shared/widgets/section_title.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  static const int _consumedKcal = 1820;
  static const int _goalKcal = 2200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nutrition')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CalorieCard(
                consumed: _consumedKcal,
                goal: _goalKcal,
              ),
              const SizedBox(height: AppTheme.spacingLG),
              _MacroSection(),
              const SizedBox(height: AppTheme.spacingLG),
              _ScanAddRow(),
              const SizedBox(height: AppTheme.spacingLG),
              _RecentMeals(),
              const SizedBox(height: AppTheme.spacingMD),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Calorie overview card ─────────────────────────────────────────────────────

class _CalorieCard extends StatelessWidget {
  final int consumed;
  final int goal;

  const _CalorieCard({required this.consumed, required this.goal});

  @override
  Widget build(BuildContext context) {
    final progress = (consumed / goal).clamp(0.0, 1.0);
    final remaining = goal - consumed;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Calories Today',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppTheme.textMedium,
                          ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$consumed',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                          ),
                          TextSpan(
                            text: ' / $goal kcal',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppTheme.textMedium,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _CircleProgress(progress: progress),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMD),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: AppTheme.bgSurface,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppTheme.primaryGreen,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$remaining kcal remaining',
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleProgress extends StatelessWidget {
  final double progress;
  const _CircleProgress({required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 72,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 7,
            backgroundColor: AppTheme.bgSurface,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppTheme.primaryGreen,
            ),
          ),
          Text(
            '${(progress * 100).round()}%',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Macros ────────────────────────────────────────────────────────────────────

class _MacroSection extends StatelessWidget {
  static const List<_Macro> _macros = [
    _Macro(label: 'Protein', value: 110, max: 150, unit: 'g',
        color: Color(0xFF3B82F6)),
    _Macro(label: 'Carbs', value: 210, max: 275, unit: 'g',
        color: Color(0xFFF59E0B)),
    _Macro(label: 'Fat', value: 60, max: 75, unit: 'g',
        color: Color(0xFFEF4444)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Macronutrients'),
        const SizedBox(height: AppTheme.spacingMD),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMD),
            child: Column(
              children: _macros
                  .map((m) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _MacroBar(macro: m),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _MacroBar extends StatelessWidget {
  final _Macro macro;
  const _MacroBar({required this.macro});

  @override
  Widget build(BuildContext context) {
    final progress = (macro.value / macro.max).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              macro.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
            ),
            Text(
              '${macro.value}${macro.unit} / ${macro.max}${macro.unit}',
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: AppTheme.bgSurface,
            valueColor: AlwaysStoppedAnimation<Color>(macro.color),
          ),
        ),
      ],
    );
  }
}

class _Macro {
  final String label;
  final int value;
  final int max;
  final String unit;
  final Color color;
  const _Macro({
    required this.label,
    required this.value,
    required this.max,
    required this.unit,
    required this.color,
  });
}

// ── Scan & Add row ────────────────────────────────────────────────────────────

class _ScanAddRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ElevatedButton.icon(
            onPressed: () => _onScanFood(context),
            icon: const Icon(Icons.camera_alt_rounded, size: 20),
            label: const Text('Scan Food'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded, size: 20),
            label: const Text('Add Meal'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
            ),
          ),
        ),
      ],
    );
  }

  void _onScanFood(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.info_outline_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Prototype: Food scanning will use computer vision '
                'in the final release.',
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.textDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

// ── Recent meals ──────────────────────────────────────────────────────────────

class _RecentMeals extends StatelessWidget {
  static const List<_Meal> _meals = [
    _Meal(
      name: 'Oatmeal with Berries',
      time: 'Breakfast · 8:30 AM',
      kcal: 380,
      icon: Icons.breakfast_dining_rounded,
      color: Color(0xFFF59E0B),
    ),
    _Meal(
      name: 'Grilled Chicken Salad',
      time: 'Lunch · 12:15 PM',
      kcal: 520,
      icon: Icons.lunch_dining_rounded,
      color: AppTheme.primaryGreen,
    ),
    _Meal(
      name: 'Protein Shake',
      time: 'Snack · 3:00 PM',
      kcal: 240,
      icon: Icons.local_cafe_rounded,
      color: Color(0xFF8B5CF6),
    ),
    _Meal(
      name: 'Salmon with Quinoa',
      time: 'Dinner · 7:00 PM',
      kcal: 680,
      icon: Icons.dinner_dining_rounded,
      color: Color(0xFF3B82F6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Recent Meals', action: 'See All'),
        const SizedBox(height: AppTheme.spacingMD),
        Card(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _meals.length,
            separatorBuilder: (_, _) => const Divider(height: 1, indent: 64),
            itemBuilder: (_, i) => _MealTile(meal: _meals[i]),
          ),
        ),
      ],
    );
  }
}

class _MealTile extends StatelessWidget {
  final _Meal meal;
  const _MealTile({required this.meal});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: meal.color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppTheme.radiusSM),
        ),
        child: Icon(meal.icon, color: meal.color, size: 20),
      ),
      title: Text(
        meal.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppTheme.textDark,
        ),
      ),
      subtitle: Text(
        meal.time,
        style: const TextStyle(fontSize: 12, color: AppTheme.textMedium),
      ),
      trailing: Text(
        '${meal.kcal} kcal',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppTheme.textDark,
        ),
      ),
    );
  }
}

class _Meal {
  final String name;
  final String time;
  final int kcal;
  final IconData icon;
  final Color color;
  const _Meal({
    required this.name,
    required this.time,
    required this.kcal,
    required this.icon,
    required this.color,
  });
}
