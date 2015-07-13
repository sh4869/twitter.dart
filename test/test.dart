import 'dart:io';

import 'package:twitter/twitter.dart';
import 'package:test/test.dart';

main(){ 
	test("Simple API TEST",() async {
		var envVars = Platform.environment;
		var twitter = new Twitter(envVars['CONSUMER_KEY'],envVars['CONSUMER_SECRET'],
			envVars['ACCESS_TOKEN'],envVars['ACCESS_TOKEN_SECRET']);	
		var response = await twitter.request("GET","statuses/user_timeline");
		expect(response.body,isNotNull);
	});
}
