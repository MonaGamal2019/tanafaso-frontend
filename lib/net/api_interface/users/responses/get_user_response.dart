import 'package:azkar/models/azkar_challenge.dart';
import 'package:azkar/models/user.dart';
import 'package:azkar/models/user_group.dart';
import 'package:azkar/net/api_interface/response_base.dart';

class GetUserResponse extends ResponseBase {
  User user;

  static GetUserResponse fromJson(Map<String, dynamic> json) {
    GetUserResponse response = new GetUserResponse();
    response.setError(json);
    if (response.hasError()) {
      return response;
    }

    var data = json['data'];
    List<UserGroup> userGroups = [];
    for (var userGroupJson in data['userGroups']) {
      userGroups.add(UserGroup.fromJson(userGroupJson));
    }
    List<AzkarChallenge> personalChallenges = [];
    for (var personalChallengeJson in data['personalChallenges']) {
      personalChallenges.add(AzkarChallenge.fromJson(personalChallengeJson));
    }
    response.user = User(
      email: data['email'],
      id: data['id'],
      username: data['username'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      userGroups: userGroups,
      personalChallenges: personalChallenges,
    );
    return response;
  }
}
