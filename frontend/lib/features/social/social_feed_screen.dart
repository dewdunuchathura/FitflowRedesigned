import 'package:flutter/material.dart';
import 'package:fitflow/shared/theme/app_theme.dart';
import 'package:fitflow/shared/widgets/section_title.dart';

// ── Screen ────────────────────────────────────────────────────────────────────

class SocialFeedScreen extends StatefulWidget {
  const SocialFeedScreen({super.key});

  @override
  State<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends State<SocialFeedScreen> {
  late final List<_PostData> _posts;

  @override
  void initState() {
    super.initState();
    _posts = [
      _PostData(
        id: '1',
        name: 'Alex Rivera',
        initials: 'AR',
        avatarColor: const Color(0xFF3B82F6),
        time: '2 min ago',
        content:
            'Just crushed a 45-minute HIIT session! 🔥 Feeling amazing. '
            'New personal best on burpees today — 3 sets of 20!',
        workout: 'HIIT · 45 min · 420 kcal',
        likeCount: 24,
        commentCount: 5,
        isLiked: false,
      ),
      _PostData(
        id: '2',
        name: 'Priya Singh',
        initials: 'PS',
        avatarColor: const Color(0xFFEC4899),
        time: '18 min ago',
        content:
            'Morning yoga ☀️ Starting every day with 30 minutes of mindful '
            'movement. Today\'s focus: hip flexors and lower back. '
            'Who else practices morning yoga?',
        workout: 'Yoga · 30 min · 120 kcal',
        likeCount: 41,
        commentCount: 12,
        isLiked: true,
      ),
      _PostData(
        id: '3',
        name: 'Marcus Chen',
        initials: 'MC',
        avatarColor: const Color(0xFF8B5CF6),
        time: '1 hr ago',
        content:
            'Week 4 of the muscle gain programme complete! 💪 '
            'Squat is up 10 kg from where I started. '
            'FitFlow AI recommendations are genuinely working.',
        workout: 'Strength · 60 min · 350 kcal',
        likeCount: 67,
        commentCount: 8,
        isLiked: false,
      ),
      _PostData(
        id: '4',
        name: 'Fatima Al-Rashid',
        initials: 'FA',
        avatarColor: const Color(0xFFF59E0B),
        time: '3 hr ago',
        content:
            'Hit my nutrition goals for 5 days straight 🥗 '
            'Meal prepping on Sundays is a game changer. '
            'Protein target: 130g today!',
        workout: null,
        likeCount: 33,
        commentCount: 7,
        isLiked: false,
      ),
    ];
  }

  void _toggleLike(int index) {
    setState(() {
      final post = _posts[index];
      _posts[index] = post.copyWith(
        isLiked: !post.isLiked,
        likeCount: post.isLiked ? post.likeCount - 1 : post.likeCount + 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CommunityHeader(),
              const SizedBox(height: AppTheme.spacingLG),
              const SectionTitle(title: 'Recent Posts'),
              const SizedBox(height: AppTheme.spacingMD),
              ...List.generate(
                _posts.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: AppTheme.spacingMD),
                  child: _PostCard(
                    post: _posts[i],
                    onLike: () => _toggleLike(i),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Create Post',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// ── Community header stats ────────────────────────────────────────────────────

class _CommunityHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMD),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _CommunityStat(value: '2.4K', label: 'Members'),
            _Divider(),
            _CommunityStat(value: '128', label: 'Active Today'),
            _Divider(),
            _CommunityStat(value: '47', label: 'Posts Today'),
          ],
        ),
      ),
    );
  }
}

class _CommunityStat extends StatelessWidget {
  final String value;
  final String label;
  const _CommunityStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryGreen,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppTheme.textMedium),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: AppTheme.divider,
    );
  }
}

// ── Post card ─────────────────────────────────────────────────────────────────

class _PostCard extends StatelessWidget {
  final _PostData post;
  final VoidCallback onLike;

  const _PostCard({required this.post, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: post.avatarColor,
                  child: Text(
                    post.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppTheme.textDark,
                        ),
                      ),
                      Text(
                        post.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: AppTheme.textMedium),
                  onPressed: () {},
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Content ─────────────────────────────────────────
            Text(
              post.content,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textDark,
                height: 1.5,
              ),
            ),

            // ── Workout badge ────────────────────────────────────
            if (post.workout != null) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.lightGreen,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.fitness_center_rounded,
                      size: 14,
                      color: AppTheme.darkGreen,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      post.workout!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.darkGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 8),

            // ── Action buttons ───────────────────────────────────
            Row(
              children: [
                _LikeButton(
                  count: post.likeCount,
                  isLiked: post.isLiked,
                  onTap: onLike,
                ),
                const SizedBox(width: 4),
                _CommentButton(count: post.commentCount),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.share_outlined,
                    size: 18,
                    color: AppTheme.textMedium,
                  ),
                  onPressed: () {},
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  final int count;
  final bool isLiked;
  final VoidCallback onTap;

  const _LikeButton({
    required this.count,
    required this.isLiked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              key: ValueKey(isLiked),
              size: 20,
              color: isLiked ? Colors.red : AppTheme.textMedium,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isLiked ? Colors.red : AppTheme.textMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentButton extends StatelessWidget {
  final int count;
  const _CommentButton({required this.count});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
      label: Text('$count'),
      style: TextButton.styleFrom(
        foregroundColor: AppTheme.textMedium,
        visualDensity: VisualDensity.compact,
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────

class _PostData {
  final String id;
  final String name;
  final String initials;
  final Color avatarColor;
  final String time;
  final String content;
  final String? workout;
  final int likeCount;
  final int commentCount;
  final bool isLiked;

  const _PostData({
    required this.id,
    required this.name,
    required this.initials,
    required this.avatarColor,
    required this.time,
    required this.content,
    required this.workout,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
  });

  _PostData copyWith({bool? isLiked, int? likeCount}) {
    return _PostData(
      id: id,
      name: name,
      initials: initials,
      avatarColor: avatarColor,
      time: time,
      content: content,
      workout: workout,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
