import 'dart:async';
import 'dart:convert';

const int _LF = 10;
const int _CR = 13;

/// Provide Stream class for Twitter user Stream.
class TwitterStream extends Stream<Object> {
  Stream<String> _source;
  StreamSubscription<Object> _subscription;
  StreamController<Object> _controller;
  String _piecetweet = "";
  JsonDecoder _decoder = new JsonDecoder();

  TwitterStream(Stream<String> source) : _source = source {
    _controller = new StreamController<Object>(
        onListen: _onListen,
        onPause: _onPause,
        onResume: _onResume,
        onCancel: _onCancel);
  }

  StreamSubscription<Object> listen(void onData(Object tweet),
      {Function onError, void onDone(), bool cancelOnError}) {
    return _controller.stream.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  void _onListen() {
    _subscription =
        _source.listen(_onData, onError: _controller.addError, onDone: _onDone);
  }

  void _onPause() {
    _subscription.pause();
  }

  void _onResume() {
    _subscription.resume();
  }

  void _onCancel() {
    _subscription.cancel();
    _subscription = null;
  }

  void _onData(String input) {
    var tweetText = splitOnlyCRLF(input);
    for (var tweet in tweetText) {
      try {
        tweet = _piecetweet + tweet;
        tweet = tweet.replaceAll(new RegExp(r"\r$"), "");
        if (tweet.startsWith("{") && tweet.endsWith("}")) {
          var tweetObj = _decoder.convert(tweet);
          _controller.add(tweetObj);
          _piecetweet = "";
        } else {
          _piecetweet = tweet;
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void _onDone() {
    print("Done");
  }

  Iterable<String> splitOnlyCRLF(String lines, [int start = 0, int end]) sync* {
    end = RangeError.checkValidRange(start, end, lines.length);
    int sliceStart = start;
    int char = 0;
    for (int i = start; i < end; i++) {
      int previousChar = char;
      char = lines.codeUnitAt(i);
      if (char != _LF) continue;
      if (previousChar != _CR) {
        continue;
      }
      yield lines.substring(sliceStart, i);
      sliceStart = i + 1;
    }
    if (sliceStart < end) {
      yield lines.substring(sliceStart, end);
    }
  }
}
