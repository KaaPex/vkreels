import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vk_reels/logic/bloc/bloc.dart';
import 'package:vk_reels/logic/cubit/cubit.dart';
import 'package:vk_reels/presentation/screens/screens.dart';
import 'package:vk_reels/presentation/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  final int? id;

  const ProfilePage({Key? key, this.id}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    final userId = context.read<ProfileBloc>().state.profile.userId;
    // if (userId != widget.id) {
    context.read<ProfileBloc>().add(ProfileDataRequested(widget.id));
    context.read<WallCubit>().getUserPosts(widget.id);
    // }
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;

        return state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                appBar: AppBar(
                  title: Row(
                    children: [
                      Icon(
                          profile.isClosed != null && profile.isClosed == true ? Icons.lock : Icons.lock_open_outlined),
                      Text('${profile.screenName ?? profile.userId}'),
                    ],
                  ),
                  centerTitle: false,
                  backgroundColor: Theme.of(context).primaryColor,
                  toolbarHeight: 40,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Navigator.pushNamed(context, SettingsScreen.routeName);
                      },
                    ),
                  ],
                ),
                body: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: profile.photo100 != null ? NetworkImage(profile.photo100!) : null,
                                radius: 40,
                                child: profile.photo100 == null
                                    ? const Icon(
                                        Icons.person,
                                      )
                                    : null,
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BlocBuilder<WallCubit, WallState>(
                                          builder: (_, state) {
                                            return buildStatColumn(state.count, t.profilePosts);
                                          },
                                        ),
                                        buildStatColumn(profile.counters?.notes ?? 0, t.profileNotes),
                                        buildStatColumn(profile.counters?.followers ?? 0, t.profileFollowers),
                                        buildStatColumn(
                                            (profile.counters?.subscriptions ?? 0) + (profile.counters?.pages ?? 0),
                                            t.profileFollowing),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('${profile.firstName} ${profile.lastName}'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '${profile.statusAudio ?? profile.status}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          BlocBuilder<WallCubit, WallState>(
                            builder: (_, state) {
                              if (state.posts.isEmpty) return Container();
                              return PostWidget(post: state.posts[6]);
                            },
                          ),
                        ],
                      ),
                    ),
                    // BlocBuilder<WallCubit, WallState>(
                    //   builder: (_, state) {
                    //     if (state.posts.isEmpty) return Container();
                    //     return PostWidget(post: state.posts[7]);
                    //   },
                    // ),
                  ],
                ),
              );
      },
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
