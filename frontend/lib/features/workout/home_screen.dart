import 'package:flutter/material.dart';
import 'package:fitflow/shared/theme/app_theme.dart';
import 'package:fitflow/shared/widgets/stat_card.dart';
import 'package:fitflow/shared/widgets/section_title.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  final void Function(int index) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GreetingHeader(),
              const SizedBox(height: AppTheme.spacingLG),
              _DailyFlowCard(onNavigate: onNavigate),
              const SizedBox(height: AppTheme.spacingLG),
              _TodayProgress(),
              const SizedBox(height: AppTheme.spacingLG),
              _QuickActions(onNavigate: onNavigate),
              const SizedBox(height: AppTheme.spacingLG),
              _StreakCard(),
              const SizedBox(height: AppTheme.spacingMD),
              const _PrivacyPolicyLink(),
              const SizedBox(height: AppTheme.spacingMD),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Greeting ──────────────────────────────────────────────────────────────────

class _GreetingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning, Alex 👋',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            const Text(
              'Ready for today\'s workout?',
              style: TextStyle(color: AppTheme.textMedium, fontSize: 14),
            ),
          ],
        ),
        CircleAvatar(
          radius: 22,
          backgroundColor: AppTheme.lightGreen,
          child: const Text(
            'A',
            style: TextStyle(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Daily Flow Card ───────────────────────────────────────────────────────────

class _DailyFlowCard extends StatelessWidget {
  final void Function(int) onNavigate;
  const _DailyFlowCard({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Your Daily Flow'),
        const SizedBox(height: AppTheme.spacingMD),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.primaryGreen, AppTheme.darkGreen],
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
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                    ),
                    child: const Icon(
                      Icons.flash_on_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'AI Recommended',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Full Body Burn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Row(
                children: [
                  Icon(Icons.timer_outlined, color: Colors.white70, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '20 min',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.local_fire_department_outlined,
                      color: Colors.white70, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '180 kcal',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.fitness_center_rounded,
                      color: Colors.white70, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Intermediate',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => onNavigate(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryGreen,
                    minimumSize: const Size(double.infinity, 46),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Start Workout'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Today's Progress ──────────────────────────────────────────────────────────

class _TodayProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Today's Progress"),
        const SizedBox(height: AppTheme.spacingMD),
        Row(
          children: [
            Expanded(
              child: StatCard(
                value: '1,820',
                label: 'Calories',
                icon: Icons.local_fire_department_rounded,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: AppTheme.spacingMD),
            Expanded(
              child: StatCard(
                value: '1 / 2',
                label: 'Workouts',
                icon: Icons.fitness_center_rounded,
                color: AppTheme.primaryGreen,
              ),
            ),
            const SizedBox(width: AppTheme.spacingMD),
            Expanded(
              child: StatCard(
                value: '78%',
                label: 'Nutrition',
                icon: Icons.restaurant_rounded,
                color: AppTheme.infoBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Quick Actions ─────────────────────────────────────────────────────────────

class _QuickActions extends StatelessWidget {
  final void Function(int) onNavigate;
  const _QuickActions({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionItem(
        label: 'AI Workout',
        icon: Icons.auto_awesome_rounded,
        color: AppTheme.primaryGreen,
        index: 1,
      ),
      _ActionItem(
        label: 'Nutrition',
        icon: Icons.restaurant_rounded,
        color: AppTheme.infoBlue,
        index: 3,
      ),
      _ActionItem(
        label: 'Community',
        icon: Icons.people_rounded,
        color: AppTheme.warningOrange,
        index: 2,
      ),
      _ActionItem(
        label: 'Progress',
        icon: Icons.bar_chart_rounded,
        color: Colors.purple,
        index: 4,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Quick Actions'),
        const SizedBox(height: AppTheme.spacingMD),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions
              .map(
                (a) => _QuickActionButton(
                  item: a,
                  onTap: () => onNavigate(a.index),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _ActionItem {
  final String label;
  final IconData icon;
  final Color color;
  final int index;
  const _ActionItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.index,
  });
}

class _QuickActionButton extends StatelessWidget {
  final _ActionItem item;
  final VoidCallback onTap;

  const _QuickActionButton({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppTheme.radiusMD),
            ),
            child: Icon(item.icon, color: item.color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            item.label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Privacy Policy Link ───────────────────────────────────────────────────────

class _PrivacyPolicyLink extends StatelessWidget {
  static const _url =
      'https://dewdunuchathura.github.io/FitflowRedesigned/privacy-policy.html';

  const _PrivacyPolicyLink();

  Future<void> _open() async {
    final uri = Uri.parse(_url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: _open,
        icon: const Icon(Icons.shield_outlined, size: 16,
            color: AppTheme.textMedium),
        label: const Text(
          'Privacy Policy',
          style: TextStyle(fontSize: 13, color: AppTheme.textMedium),
        ),
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.textMedium,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMD, vertical: AppTheme.spacingSM),
        ),
      ),
    );
  }
}

// ── Streak Card ───────────────────────────────────────────────────────────────

class _StreakCard extends StatelessWidget {
  static const int _streakCount = 7;
  static const List<String> _days = [
    'M', 'T', 'W', 'T', 'F', 'S', 'S',
  ];

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
                const Text(
                  '🔥',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 8),
                Text(
                  '7-Day Streak',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.lightGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '🏆 Best Week!',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.darkGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMD),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_days.length, (i) {
                final done = i < _streakCount;
                return Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: done
                            ? AppTheme.primaryGreen
                            : AppTheme.bgSurface,
                        shape: BoxShape.circle,
                        border: done
                            ? null
                            : Border.all(color: AppTheme.divider),
                      ),
                      child: done
                          ? const Icon(
                              Icons.check_rounded,
                              size: 18,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _days[i],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color:
                            done ? AppTheme.primaryGreen : AppTheme.textMedium,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
