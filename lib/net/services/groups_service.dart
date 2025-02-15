import 'dart:convert';

import 'package:azkar/models/group.dart';
import 'package:azkar/models/user_score.dart';
import 'package:azkar/net/api_caller.dart';
import 'package:azkar/net/api_exception.dart';
import 'package:azkar/net/api_interface/groups/responses/get_group_leaderboard_response.dart';
import 'package:azkar/net/api_interface/groups/responses/get_group_response.dart';
import 'package:azkar/net/api_interface/groups/responses/get_groups_response.dart';
import 'package:azkar/net/endpoints.dart';
import 'package:http/http.dart' as http;

class GroupsService {
  Future<Group> getGroup(String groupId) async {
    http.Response httpResponse = await ApiCaller.get(
        route: Endpoint(
            endpointRoute: EndpointRoute.GET_GROUP, pathVariables: [groupId]));
    var response = GetGroupResponse.fromJson(
        jsonDecode(utf8.decode(httpResponse.body.codeUnits)));
    if (response.hasError()) {
      throw new ApiException(response.getErrorMessage());
    }
    return response.group;
  }

  Future<List<Group>> getGroups() async {
    http.Response httpResponse = await ApiCaller.get(
        route: Endpoint(endpointRoute: EndpointRoute.GET_GROUPS));
    var response = GetGroupsResponse.fromJson(
        jsonDecode(utf8.decode(httpResponse.body.codeUnits)));
    if (response.hasError()) {
      throw new ApiException(response.getErrorMessage());
    }
    return response.groups;
  }

  Future<List<UserScore>> getGroupLeaderboard(String groupId) async {
    http.Response httpResponse = await ApiCaller.get(
        route: Endpoint(
            endpointRoute: EndpointRoute.GET_GROUP_LEADERBOARD,
            pathVariables: [groupId]));
    var response = GetGroupLeaderboardResponse.fromJson(
        jsonDecode(utf8.decode(httpResponse.body.codeUnits)));
    if (response.hasError()) {
      throw new ApiException(response.getErrorMessage());
    }
    return response.userScores;
  }
}
