import 'dart:io';
import 'package:twitter/twitter.dart';

main(){
  var envVars = Platform.environment;
  print(envVars['CONSUMER_KEY']);
  print(envVars['CONSUMER_SECRET']);
  print(envVars['ACCESS_TOKEN']);
  print(envVars['ACCESS_TOKEN_SECRET']);
  var map = {
      "consumerKey": envVars['CONSUMER_KEY'],
      "consumerSecret": envVars['CONSUMER_SECRET'],
      "accessToken": envVars['ACCESS_TOKEN'],
      "accessSecret": envVars['ACCESS_TOKEN_SECRET']
  };
  var twitter = new Twitter.fromMap(map);
  try {
    var a = twitter.request("GET", "statuses/home_timeline.json");
    a.then((value){
      new File("test.json").writeAsString(value.body);
    });
  } catch(e) {
  } finally {
  }
  return;
}