import 'package:eventus/eventus.dart';

/**
 * To use the Eventus you only need to extend the
 * Eventus class.
 */
class Test extends Eventus {

  /**
   * Dummy handler function.
   *
   * @param String msg    Message to be processed.
   */
  void handleMsg(String msg) {
    print("Class Function");
  }

}

main() {
  Test obj = new Test();

  // add a handler to `message` event
  obj.on('message', (String msg) {
    print("> ${msg}");
  });

  // add another handler. when we use named functions we can
  // remove the handler with the `removeListener` method
  obj.on('message', obj.handleMsg);

  // add a once event handler. this handler is removed in his
  // first execution
  obj.once('message', (String msg) {
    print("Once > ${msg}");
  });

  // just another handler in a different event
  obj.on('login', (String username, String password) {
    print("${username} - ${password}");
  });

  // call a event who not exists. this call not pass any arguments
  // to the handlers
  obj.emit('notExists');

  // should call the three handlers
  obj.emit('message', 'M#1');

  // remove the class `handleMsg` handler associated to the
  // `message` event
  obj.removeListener('message', obj.handleMsg);

  // the once handler was been removed at this time
  obj.emit('message', 'M#2');

  // remove all listeners associated to the message event
  obj.removeAllListeners('message');

  // no one it's listening the `message` event
  obj.emit('message', 'M#3');

  // should raise an exception. the handler not have the
  // correct number of arguments. two correct that the handler
  // can change his signature to `(String username, [String password])`
  try {
    obj.emit('login', 'asd');
  } on NoSuchMethodError catch (_) {}

  // clear all class listeners
  obj.clearListeners();

  // every listeners was been removed
  obj.emit('login', 'user', 'pass');
}
