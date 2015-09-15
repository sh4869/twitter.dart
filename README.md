twitter.dart   [![Build Status](https://travis-ci.org/sh4869/twitter.dart.svg?branch=master)](https://travis-ci.org/sh4869/twitter.dart)  [![pub package](https://img.shields.io/pub/v/twitter.svg)](https://pub.dartlang.org/packages/twitter)
====

This is a Client Library for Twitter in Dart.

This library is developing now.

## Example

```dart
import 'package:twitter/twitter.dart';

main () async {
  var = new Twitter('YOUR CONSUMER KEY', 'YOUR CONSUMER SERCRET',
                    'YOUR ACCESS TOKEN', 'YOUR ACCESS TOKEN SECERT');
  var response = await twitter.request("GET", "statuses/user_timeline.json");
  print(response.body);
}
```

## Getting Start

add the following to your pubspec.yaml:

```yaml
dependencies:
  twitter: "0.1.0"
```

or Use [den](https://github.com/seaneagan/den) 

```
den install twitter
```
