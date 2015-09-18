# Eventus

This project introduces a class to be used as a mixin to allow a class to act as an event emitter
to which others can subscribe.
Several event-related projects existed, but none of them offered the flexibility and simplicity that we wanted,
so we created Eventus.

Eventus is a professional implementation of EventEmitter for Dart. This is based on the Node.js
[EventEmitter][node_event_emitter] enhanced with Dart super power!

## Installation

To install package in your system, declare it as a dependency in `pubspec.yaml`:

```yaml
dependencies:
    eventus: ">=1.0.0 <2.0.0"
```

Then import `eventus` in your project

```dart
import 'package:eventus/eventus.dart';
```

## Usage

You can use strings to identify the event, and provide additional data separately:

```dart
// to emit:
emitter.emit('success', result_var);
// to subscribe:
emitter.on('success', (String r) => doStuff(r));
```

You can send zero or even to three elements to handler, like that:

```dart
emitter.emit('event', arg1, arg2, arg3);
// if you need more arguments use the power of lists
emitter.emit('event', arg1, arg2, [arg3, arg4, arg5]);
```

### Unsubscribing an event

The `removeListener()` method allow you to remove a listener for a given event.
This removes normal listeners or even one-time event handlers.

```dart
emitter.removeListener('event_name', handlerReference);
```

### Remove all listeners for an event

If you want remove all the listeners who are listening a certain event, you use the
`removeAllListeners` method.

```dart
emitter.removeAllListeners('event_name');
```

### Remove all listeners

You can also unsubscribe all events from an event emitter as follows:

```dart
emitter.clearListeners();
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
[node_event_emitter]: https://nodejs.org/api/events.html#events_class_events_eventemitter
