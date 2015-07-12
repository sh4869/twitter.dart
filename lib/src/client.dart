library twitter.client;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oauth/oauth.dart' as oauth;

class Client extends oauth.Client {
	
	Client(oauth.Tokens tokens)
		: super(tokens);

	@override
	Future<http.Response> get(url, {Map<String,String> headers, body, Encoding encoding}){
		if (url is String) url = Uri.parse(url);
		var request = new http.Request("GET",url);

		if (headers != null) request.headers.addAll(headers);
		if (encoding != null) request.encoding = encoding;
		if (body != null){
			if (body is String){
				request.body = body;
			} else if (body is List){
				request.bodyBytes = body;
			} else if (body is Map){
				request.bodyFields = body;
			} else {
				throw new ArgumentError('Invalid request body "$body".');
			}
		}
		return super.send(request).then(http.Response.fromStream);
	} 
}