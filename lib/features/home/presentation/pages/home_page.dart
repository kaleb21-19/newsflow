import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsflow/core/di/injection.dart';
import 'package:newsflow/core/theme/app_text_styles.dart';
import 'package:newsflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:newsflow/features/news/presentation/pages/news_tab.dart';
import 'package:newsflow/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:newsflow/features/saved/presentation/pages/saved_tab.dart';

import '../../../../core/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    NewsTab(),
    SavedTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey400,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_outlined),
            activeIcon: Icon(Icons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ─── Profile Tab ──────────────────────────────────────────

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state.user;

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 32),

                // Avatar
                CircleAvatar(
                  radius: 48,
                  backgroundImage: user?.avatar.isNotEmpty == true
                      ? NetworkImage(user!.avatar)
                      : null,
                  backgroundColor: AppColors.primary,
                  child: user?.avatar.isEmpty == true
                      ? Text(
                          user?.firstName[0].toUpperCase() ?? 'U',
                          style: const TextStyle(
                            fontSize: 32,
                            color: AppColors.white,
                          ),
                        )
                      : null,
                ),

                const SizedBox(height: 16),

                // Name
                Text(
                  '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                  style: AppTextStyles.headingMedium,
                ),

                const SizedBox(height: 4),

                // Email
                Text(
                  user?.email ?? '',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 48),

                // Logout button
                OutlinedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const LogoutRequested(),
                        );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                  ),
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          );
        },
      ),
      
    );
  }
}
