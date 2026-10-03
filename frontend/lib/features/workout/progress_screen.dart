import 'package:flutter/material.dart';
import 'package:fitflow/shared/theme/app_theme.dart';
import 'package:fitflow/shared/widgets/stat_card.dart';
import 'package:fitflow/shared/widgets/section_title.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  static const int _streakDays = 7;
  static const List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const List<int> _weekMinutes = [45, 30, 60, 0, 50, 40, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StreakBanner(streakDays: _streakDays),
              const SizedBox(height: AppTheme.spacingLG),
              _StatsGrid(),
              const SizedBox(height: AppTheme.spacingLG),
              _WeeklyActivity(
                days: _weekDays,
                minutes: _weekMinutes,
              ),
              const SizedBox(height: AppTheme.spacingLG),
              _AchievementsSection(),
              const SizedBox(height: AppTheme.spacingMD),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Streak banner ─────────────────────────────────────────────────────────────

class _StreakBanner extends StatelessWidget {
  final int streakDays;
  const _StreakBanner({required this.streakDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 40)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$streakDays Day Streak!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Keep it up — you\'re on a roll!',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stats grid ────────────────────────────────────────────────────────────────

class _StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'This Month'),
        const SizedBox(height: AppTheme.spacingMD),
        Row(
          children: [
            Expanded(
              child: StatCard(
                value: '18',
                label: 'Workouts\nCompleted',
                icon: Icons.fitness_center_rounded,
                color: AppTheme.primaryGreen,
              ),
            ),
            const SizedBox(width: AppTheme.spacingMD),
            Expanded(
              child: StatCard(
                value: '9,240',
                label: 'Calories\nBurned',
                icon: Icons.local_fire_department_rounded,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingMD),
        Row(
          children: [
            Expanded(
              child: StatCard(
                value: '22',
                label: 'Active\nDays',
                icon: Icons.calendar_today_rounded,
                color: AppTheme.infoBlue,
              ),
            ),
            const SizedBox(width: AppTheme.spacingMD),
            Expanded(
              child: StatCard(
                value: '14.5 h',
                label: 'Total\nTime',
                icon: Icons.timer_rounded,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Weekly activity chart ─────────────────────────────────────────────────────

class _WeeklyActivity extends StatelessWidget {
  final List<String> days;
  final List<int> minutes;

  const _WeeklyActivity({required this.days, required this.minutes});

  @override
  Widget build(BuildContext context) {
    final maxMinutes =
        minutes.reduce((a, b) => a > b ? a : b).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Weekly Activity'),
        const SizedBox(height: AppTheme.spacingMD),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Minutes active per day',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textMedium,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 120,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(days.length, (i) {
                      final isToday = i == 5;
                      final barH = minutes[i] == 0
                          ? 4.0
                          : (minutes[i] / maxMinutes * 80.0);
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (minutes[i] > 0)
                              Text(
                                '${minutes[i]}m',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: isToday
                                      ? AppTheme.primaryGreen
                                      : AppTheme.textMedium,
                                ),
                              ),
                            const SizedBox(height: 4),
                            Container(
                              height: barH,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: isToday
                                    ? AppTheme.primaryGreen
                                    : minutes[i] == 0
                                        ? AppTheme.bgSurface
                                        : AppTheme.accentGreen,
                                borderRadius:
                                    BorderRadius.circular(AppTheme.radiusSM),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              days[i],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: isToday
                                    ? AppTheme.primaryGreen
                                    : AppTheme.textMedium,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Achievements ──────────────────────────────────────────────────────────────

class _AchievementsSection extends StatelessWidget {
  static const List<_Achievement> _achievements = [
    _Achievement(
      emoji: '🏅',
      title: 'First Workout',
      desc: 'Completed your first session',
      unlocked: true,
    ),
    _Achievement(
      emoji: '🔥',
      title: '7-Day Streak',
      desc: 'Trained 7 days in a row',
      unlocked: true,
    ),
    _Achievement(
      emoji: '💪',
      title: '10 Workouts',
      desc: '8 of 10 workouts done',
      unlocked: false,
      progress: 0.8,
    ),
    _Achievement(
      emoji: '🥗',
      title: 'Nutrition Master',
      desc: 'Hit nutrition goals 7 days straight',
      unlocked: false,
      progress: 0.3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Achievements'),
        const SizedBox(height: AppTheme.spacingMD),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _achievements.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppTheme.spacingMD,
            crossAxisSpacing: AppTheme.spacingMD,
            childAspectRatio: 1.4,
          ),
          itemBuilder: (_, i) => _AchievementCard(achievement: _achievements[i]),
        ),
      ],
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final _Achievement achievement;
  const _AchievementCard({required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  achievement.emoji,
                  style: TextStyle(
                    fontSize: 22,
                    color: achievement.unlocked
                        ? null
                        : const Color(0x80000000),
                  ),
                ),
                const Spacer(),
                if (achievement.unlocked)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '✓',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.darkGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              achievement.title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: achievement.unlocked
                    ? AppTheme.textDark
                    : AppTheme.textMedium,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              achievement.desc,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textMedium,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (!achievement.unlocked && achievement.progress != null) ...[
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: achievement.progress,
                  minHeight: 4,
                  backgroundColor: AppTheme.bgSurface,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppTheme.accentGreen,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Achievement {
  final String emoji;
  final String title;
  final String desc;
  final bool unlocked;
  final double? progress;

  const _Achievement({
    required this.emoji,
    required this.title,
    required this.desc,
    required this.unlocked,
    this.progress,
  });
}
