twitter.dart
===

[![Build Status](https://travis-ci.org/sh4869/twitter.dart.svg?branch=master)](https://travis-ci.org/sh4869/twitter.dart) [![pub package](https://img.shields.io/pub/v/twitter.svg)](https://pub.dartlang.org/packages/twitter)

Twitter Library for Dart.

## Example

### REST API

```dart
import 'package:twitter/twitter.dart';

main () async {
  Twitter twitter= new Twitter('YOUR CONSUMER KEY', 'YOUR CONSUMER SERCRET',
                    'YOUR ACCESS TOKEN', 'YOUR ACCESS TOKEN SECERT');
  var response = await twitter.request("GET", "statuses/user_timeline.json");
  print(response.body);
  twitter.close();
}
```

## TODO

* Write more detailed Example
* Support Twitter Model

## LICENSE

MIT LICENSE

# oauth.dart

In this library, use oauth.dart in [My repository](https://github.com/sh4869/oauth.dart/tree/develop). I fix it by develop original oauth 1 library.