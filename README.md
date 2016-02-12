twitter.dart 
===

[![Build Status](https://travis-ci.org/sh4869/twitter.dart.svg?branch=master)](https://travis-ci.org/sh4869/twitter.dart) [![pub package](https://img.shields.io/pub/v/twitter.svg)](https://pub.dartlang.org/packages/twitter)

Twitter Library for Dart.

## Example

```dart
import 'package:twitter/twitter.dart';

main () async {
  Twitter twitter= new Twitter('YOUR CONSUMER KEY', 'YOUR CONSUMER SERCRET',
                    'YOUR ACCESS TOKEN', 'YOUR ACCESS TOKEN SECERT');
  var response = await twitter.request("GET", "statuses/user_timeline.json");
  print(response.body);
}
```

or,

```dart
main () {
  Map keymap = {"consumerKey" : "YOUR CONSUMER KEY",
                 "consumerSecret" : "YOUR CONSUMER SECRET",
                 "accessToken" : "YOUR ACCESS TOKEN",
                "accessSecret" : "YOUR ACCESS SECRET"};
  Twitter twitter = new Twitter.fromMap(keyMap);
``

## Getting Start

add the following to your pubspec.yaml:

```yaml
dependencies:
  twitter: "0.2.0"
```

## LICENSE

MIT LICENSE
