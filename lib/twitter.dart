library twitter;

import 'dart:async';
import 'dart:convert' show JSON;
import 'package:oauth/oauth.dart' as oauth;
import 'package:http/http.dart' as http;

class Twitter{

	String baseUrl = 'https://api.twitter.com/1.1/';

	String consumerKey;

	String consumerSecret;

	String accessToken;

	String accessSecret;

	oauth.Tokens oauthTokens;

	oauth.Client oauthClient;


	Twitter._internal(this.oauthTokens,this.oauthClient);

	factory Twitter(String consumerKey,String consumerSecret,String accessToken,String accessSecret){
		oauth.Tokens oauthTokens = new oauth.Tokens(
				consumerId: consumerKey,
				consumerKey: consumerSecret,
				userId: accessToken,
				userKey: accessSecret);
		oauth.Client oauthClient = new oauth.Client(oauthTokens);
		return new Twitter._internal(oauthTokens,oauthClient);
	}


	Future<String> request (String method,String endPoint,{Map body}) async {
		var requestUrl = baseUrl + endPoint;
		switch (method){
			case 'POST':
				if(body != null){
					var res = await oauthClient.post(requestUrl,body:body);
					return res.body;
				}else{
					var res = await oauthClient.post(requestUrl);
					return res.body;
				}
				break;
			case 'GET':
				if(body != null){
					var res = await oauthClient.get(requestUrl,body:body);
					return res.body;
				}else{
					var res = await oauthClient.get(requestUrl);
					print(res.statusCode);
					return res.body;
				}
				break;
			default:
				break;
		}
	}



}
