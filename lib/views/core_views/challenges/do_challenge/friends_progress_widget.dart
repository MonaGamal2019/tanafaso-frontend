import 'package:azkar/models/challenge.dart';
import 'package:azkar/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class FriendsProgressWidget extends StatefulWidget {
  final Challenge challenge;
  final List<String> challengedUsersIds;
  final List<String> challengedUsersFullNames;

  FriendsProgressWidget({
    @required this.challenge,
    @required this.challengedUsersIds,
    @required this.challengedUsersFullNames,
  });

  @override
  _FriendsProgressWidgetState createState() => _FriendsProgressWidgetState();
}

class _FriendsProgressWidgetState extends State<FriendsProgressWidget> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: ListView.separated(
          padding: EdgeInsets.all(0),
          separatorBuilder: (BuildContext context, int index) => Divider(),
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: widget.challengedUsersIds.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: getFriendProgressOnChallengeIcon(
                      widget.challengedUsersIds[index]),
                ),
                Text(widget.challengedUsersFullNames[index]),
                Visibility(
                  visible: widget.challengedUsersIds[index] ==
                      widget.challenge?.creatingUserId(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(AppLocalizations.of(context).challengeCreator),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getFriendProgressOnChallengeIcon(String userId) {
    if (userId == null) {
      return Container();
    }

    if (widget.challenge
        .getUsersFinishedIds()
        .any((userFinished) => userFinished == userId)) {
      return Icon(
        Icons.done_outline,
        size: 15,
        color: Colors.green,
      );
    }

    if (widget.challenge.deadlinePassed()) {
      return Icon(
        Icons.error_outline,
        size: 15,
        color: Colors.red,
      );
    }

    return Icon(
      Icons.not_started,
      size: 15,
      color: Colors.yellow,
    );
  }
}
