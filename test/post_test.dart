import 'dart:io';

import 'package:twitter/twitter.dart';
import 'package:test/test.dart';

main() {
  test("Simple API TEST", () async {
    var envVars = Platform.environment;
    var twitter = new Twitter(
        envVars['CONSUMER_KEY'],
        envVars['CONSUMER_SECRET'],
        envVars['ACCESS_TOKEN'],
        envVars['ACCESS_TOKEN_SECRET']);
    var response = await twitter.request("GET", "statuses/user_timeline.json");
    expect(response.body, isNotNull);
  });
  test("Twitter.fromMap Test", () async {
    var envVars = Platform.environment;
    Map keyMap = {
      "consumerKey": envVars['CONSUMER_KEY'],
      "consumerSecret": envVars['CONSUMER_SECRET'],
      "accessToken": envVars['ACCESS_TOKEN'],
      "accessSecret": envVars['ACCESS_TOKEN_SECRET']
    };
    var twitter = new Twitter.fromMap(keyMap);
    var response = await twitter.request("GET", "statuses/user_timeline.json");
    expect(response.body,isNotNull);
  });
  // mulitple request test #5
  test("mulitple request test",() async {
    var envVars = Platform.environment;
    Map keyMap = {
      "consumerKey": envVars['CONSUMER_KEY'],
      "consumerSecret": envVars['CONSUMER_SECRET'],
      "accessToken": envVars['ACCESS_TOKEN'],
      "accessSecret": envVars['ACCESS_TOKEN_SECRET']
    };
    var twitter = new Twitter.fromMap(keyMap);
    var response = await twitter.request("GET", "statuses/user_timeline.json");
    var response2 = await twitter.request("GET", "statuses/user_timeline.json");
    expect(response.body, isNotNull);
  });
}
