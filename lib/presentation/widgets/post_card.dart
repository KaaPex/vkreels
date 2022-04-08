import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vk_reels/presentation/animation/expandable_text.dart';
import 'widgets.dart';
import 'package:vk_sdk/vk_sdk.dart';

class PostCard extends StatefulWidget {
  final VKPost post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
  }

  Widget _getPostHeader() {
    NetworkImage? image;
    String name = '';

    if (widget.post.profile?.photo50 != null) {
      image = NetworkImage(widget.post.profile?.photo50 ?? '');
      name = '${widget.post.profile?.firstName} ${widget.post.profile?.lastName}';
    }

    if (widget.post.group?.photo50 != null) {
      image = NetworkImage(widget.post.group?.photo50 ?? '');
      name = widget.post.group?.screenName ?? widget.post.group?.name ?? '';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 16,
      ).copyWith(right: 0),
      child: Row(
        children: [
          Avatar(
            radius: 12.0,
            backgroundImage: image,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            constraints: const BoxConstraints(),
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }

  Image? _getIImage(VKPost post) {
    // TODO: decide with image index take
    if (post.attachments != null && post.attachments?.isNotEmpty == true) {
      final attachments = post.attachments;
      try {
        final itemPhoto =
            attachments?.firstWhere((element) => element?.type == VKAttachmentType.photo, orElse: () => null);
        if (itemPhoto != null) {
          final index = itemPhoto.photo!.sizes != null ? itemPhoto.photo!.sizes!.length - 1 : 0;
          final String url = itemPhoto.photo!.sizes![index].url;
          return Image.network(
            url,
            fit: BoxFit.cover,
          );
        }

        final itemVideo =
            attachments?.firstWhere((element) => element?.type == VKAttachmentType.video, orElse: () => null);
        if (itemVideo != null) {
          final index = itemVideo.video!.image != null ? itemVideo.video!.image!.length - 1 : 0;
          final String url = itemVideo.video!.image![index].url;
          return Image.network(
            url,
            fit: BoxFit.cover,
          );
        }
      } catch (error) {
        print(error);
      }
    }
    return null;
  }

  _buildPostContext(VKPost post) {
    final postImage = _getIImage(post);

    if (postImage == null && post.text != null) {
      final textSubstringLength = post.text!.length >= 45 ? 45 : post.text?.length;
      return Center(
        child: Flexible(
          child: Text(
            post.text?.substring(0, textSubstringLength) ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32.0,
            ),
          ),
        ),
      );
    }
    return postImage;
  }

  _buildPostText(VKPost post) {
    return ExpandableText(
      author: post.ownerId == post.profile?.userId
          ? '${post.profile?.screenName ?? post.profile?.userId}'
          : '${post.group?.screenName ?? post.group?.id}',
      text: post.text ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final VKPost postData = widget.post.copyHistory != null ? widget.post.copyHistory![0] : widget.post;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Column(
        children: [
          // Header section
          _getPostHeader(),
          // context
          GestureDetector(
            onDoubleTap: () {
              //TODO: like/dislike post
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: _buildPostContext(postData),
                ),
                AnimatedOpacity(
                  opacity: isLikeAnimating ? 1 : 0,
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  child: const Icon(Icons.favorite_border),
                )
              ],
            ),
          ),
          // footer section (likes, comments, reposts, views)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.favorite),
              ],
            ),
          ),
          // footer descriptions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // author and description
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: _buildPostText(postData),
                ),
                // created date
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  width: double.infinity,
                  child: Text(
                    DateFormat.yMMMd().format(widget.post.date!),
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
