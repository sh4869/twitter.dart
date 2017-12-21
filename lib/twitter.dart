import 'dart:async';

import 'package:oauth/oauth.dart' as oauth;
import 'package:http/http.dart' as http;

import 'src/client.dart';
import 'src/twitter_stream.dart';

export 'src/twitter_stream.dart';

/// A Class for Twitter
class Twitter {
  /// Twitter API Endpoint
  final String baseUrl = 'https://api.twitter.com/1.1/';

  /// oauth.Tokens for [Client]
  oauth.Tokens oauthTokens;

  /// An HTTP Client
  Client twitterClient;

  Twitter._internal(this.oauthTokens, this.twitterClient);

  /// Creates a new [Twitter] instance from [consumerKey],[consumerSecret],[accessToken],[accessSecret]
  factory Twitter(String consumerKey, String consumerSecret, String accessToken,
      String accessSecret) {
    oauth.Tokens oauthTokens = new oauth.Tokens(
        consumerId: consumerKey,
        consumerKey: consumerSecret,
        userId: accessToken,
        userKey: accessSecret);
    Client twitterClient = new Client(oauthTokens);
    return new Twitter._internal(oauthTokens, twitterClient);
  }

  /// Create a new [Twitter] instance from Map.
  ///
  /// ```dart
  /// Map keymap = {"consumerKey" : "YOUR CONSUMER KEY",
  ///               "consumerSecret" : "YOUR CONSUMER SECRET",
  ///               "accessToken" : "YOUR ACCESS TOKEN",
  ///               "accessSecret" : "YOUR ACCESS SECRET"};
  /// Twitter twitter = new Twitter.fromMap(keyMap);
  ///```
  ///
  factory Twitter.fromMap(Map keyMap) {
    oauth.Tokens oauthTokens = new oauth.Tokens(
        consumerId: keyMap['consumerKey'],
        consumerKey: keyMap['consumerSecret'],
        userId: keyMap['accessToken'],
        userKey: keyMap['accessSecret']);
    Client twitterClient = new Client(oauthTokens);
    return new Twitter._internal(oauthTokens, twitterClient);
  }

  /// send a request to Twitter
  ///
  /// [method] is HTTP method name, for example "GET" , "POST".
  /// [endPoint] is REST API Name of Twitter. for example "statuses/mentions_timeline.json".
  /// [body] is HTTP Request's body.
  Future<http.Response> request(String method, String endPoint, {Map body}) {
    var requestUrl = baseUrl + endPoint;
    var _completer = new Completer();

    twitterClient.request(method, requestUrl, body: body).then((response) {
      twitterClient.close();
      if (response.statusCode == 200 || response.statusCode == 201) {
        _completer.complete(response);
      } else {
        _completer.completeError(response.reasonPhrase);
      }
    });
    return _completer.future;
  }

  /// Connect to Twitter User Stream
  Future<TwitterStream> getUserStream() async {
    Uri uri = Uri.parse("https://userstream.twitter.com/1.1/user.json");
    var request = new http.Request("GET", uri);
    var response = await twitterClient.send(request);
    return new TwitterStream(response.stream.toStringStream());
  }
}
