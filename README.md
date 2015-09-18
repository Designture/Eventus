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

You can use string to identify the event, and provide additional data separately:

```dart
// to emit:
emitter.emit("success", result_var);
// to subscribe:
emitter.on("success", (String r) => doStuff(r));
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
[node_event_emitter]: https://nodejs.org/api/events.html#events_class_events_eventemitter
