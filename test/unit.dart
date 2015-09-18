import 'package:eventus/eventus.dart';
import 'package:test/test.dart';

/**
 * The Eventus class is abstract so we need to extend it.
 */
class EventEmitter extends Eventus {}

void main() {
  // Eventus instance
  Eventus eventus;

  setUp(() {
    eventus = new EventEmitter();
  });

  group('::on', () {
    test(
        "should add function-type listener to string-type event if event isn't registered yer", () {
      String eventName = 'event';
      Function eventHandler = () {
        print('Hello World');
      };

      eventus.on(eventName, eventHandler);
      expect(eventus.listeners(eventName), equals([eventHandler]));
    });

    test(
        "should add function-type listener to string-type event if such event is already registered", () {
      String eventName = 'eventA';
      Function eventHandler = () {
        print('Hello world');
      };

      Function anotherEventHandler = () {
        print('Hello again');
      };

      eventus.on(eventName, eventHandler);
      eventus.on(eventName, anotherEventHandler);
      expect(eventus.listeners(eventName),
          equals([eventHandler, anotherEventHandler]));
    });
  });

  group('::listeners', () {
    test('should return empty list if none of listeners are added', () {
      expect(eventus.listeners('some event'), isEmpty);
    });

    test('shoufl return both listeners and one-time listeners for event', () {
      int i = 0;
      eventus.on('eventA', () => i++);
      eventus.once('eventA', () => i++);
      expect(eventus
          .listeners('eventA')
          .length, equals(2));
    });
  });

  group('::removeListener', () {
    test('should remove listener for given event', () {
      String eventName = 'eventA';
      Function eventHandler = () {
        print('Hello world');
      };

      eventus.on(eventName, eventHandler);
      eventus.removeListener(eventName, eventHandler);
      expect(eventus.listeners(eventName), isEmpty);
    });

    test('shoudl remove nothing if event does is not registered', () {
      String eventAName = 'eventA';
      String eventBName = 'eventB';
      Function eventHandler = () {
        print('Hello world');
      };

      eventus.on(eventAName, eventHandler);
      eventus.removeListener(eventBName, eventHandler);
      expect(eventus.listeners(eventAName), equals([eventHandler]));
    });

    test('should remove nothing if event has no such listener registered', () {
      String eventAName = 'eventA';

      Function eventHandler = () {
        print('Hello world');
      };

      Function anotherHandler = () {
        print('Salut!');
      };

      eventus.on(eventAName, eventHandler);
      eventus.removeListener(eventAName, anotherHandler);
      expect(eventus.listeners(eventAName), equals([eventHandler]));
    });

    test('should remove one-time event handlers', () {
      String eventName = 'eventA';

      Function eventHandler = () {
        print('Hello world');
      };

      eventus.once(eventName, eventHandler);
      eventus.removeListener(eventName, eventHandler);
      expect(eventus.listeners(eventName), isEmpty);
    });
  });

  group('::removeAllListeners', () {
    test('should remove all listeners for given event if it exists', () {
      eventus.on('event', () => prints('Olá'));
      eventus.removeAllListeners('event');

      expect(eventus.listeners('event'), isEmpty);
    });

    test('should remove also one-time events', () {
      eventus.on('event', () => prints('olá!'));
      eventus.once('event', () => prints('Bonito :)'));
      eventus.removeAllListeners('event');
      expect(eventus.listeners('event'), isEmpty);
    });
  });

  group('::clearListeners', () {
    test('should remove all listeners', () {
      eventus.on('eventA', () => print('Hello!'));
      eventus.on('eventB', () => print('Salut!'));
      eventus.clearListeners();

      expect(eventus.listeners('eventA'), isEmpty);
      expect(eventus.listeners('eventB'), isEmpty);
    });
  });

  group('::emit', () {
    test('should execute handler for given event', () {
      int i = 1;
      eventus.on('event', () => i++);
      eventus.emit('event');
      expect(i, equals(2));
    });

    test('should execute handler with 1 parameter', () {
      int i = 0;
      eventus.on('event', (int number) {
        i = number;
      });
      eventus.emit('event', 2);
      expect(i, equals(2));
    });

    test('should execute handler with 2 parameter', () {
      int i = 0;
      eventus.on('event', (int num1, int num2) {
        i = num1 + num2;
      });
      eventus.emit('event', 1, 2);
      expect(i, equals(3));
    });

    test('should execute handler with 3 parameter', () {
      int i = 0;
      eventus.on('event', (int num1, int num2, int num3) {
        i = num1 + num2 + num3;
      });
      eventus.emit('event', 1, 2, 3);
      expect(i, equals(6));
    });
  });

  group('::once', () {
    test(
        'should declare handler that is immediately removed after executing', () {
      int i = 0;
      eventus.once('event', () => i++);
      eventus.emit('event');
      expect(i, equals(1));
      expect(eventus.listeners('event'), isEmpty);
    });
  });
}
