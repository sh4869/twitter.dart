library twitter;

import 'dart:async';

import 'package:oauth/oauth.dart' as oauth;
import 'package:http/http.dart' as http;

import 'src/client.dart';

class Twitter {

	final String baseUrl = 'https://api.twitter.com/1.1/';

	oauth.Tokens oauthTokens;

	Client twitterClient;

	Twitter._internal(this.oauthTokens,this.twitterClient);

	factory Twitter(String consumerKey,String consumerSecret,String accessToken,String accessSecret){
		oauth.Tokens oauthTokens = new oauth.Tokens(
				consumerId: consumerKey,
				consumerKey: consumerSecret,
				userId: accessToken,
				userKey: accessSecret);
		Client twitterClient = new Client(oauthTokens);
		return new Twitter._internal(oauthTokens,twitterClient);
	}


	Future<http.Response> request (String method,String endPoint,{Map body}) {
		var requestUrl = baseUrl + endPoint;
		return twitterClient.request(method, requestUrl, body:body);	
	}
}
