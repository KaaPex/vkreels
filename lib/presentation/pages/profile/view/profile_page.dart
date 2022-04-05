import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_reels/logic/bloc/bloc.dart';

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
    if (userId != widget.id) {
      context.read<ProfileBloc>().add(ProfileDataRequested(widget.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final profile = state.profile;

        return state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text('${profile.firstName} ${profile.lastName}'),
                  centerTitle: false,
                ),
              );
      },
    );
  }
}
