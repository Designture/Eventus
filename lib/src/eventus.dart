part of eventus;

abstract class Eventus {

  /**
   * Mapping of events to a list of events handlers.
   */
  Dictionary<String, List<Function>> _events = new Dictionary();

  /**
   * Mapping of events to a list of one-time event handlers.
   */
  Dictionary<String, List<Function>> _eventsOnce = new Dictionary();

  /**
   * This function triggers all the handlers currently listening
   * to `event` and passes them `data`.
   *
   * @param String event    The event to trigger.
   * @param dynamic data    The data to send to each handler.
   * @return void
   */
  void emit(String event, [arg1, arg2, arg3]) {
    this._events.get(event).map((List<Function> handlers) {
      handlers.forEach((Function handler) {
        _callHandler(handler, arg1, arg2, arg3);
      });
    });

    this._eventsOnce.remove(event)?.forEach((Function handler) {
      _callHandler(handler, arg1, arg2, arg3);
    });
  }

  /**
   * Helper function to call the handler with the correct number of arguments.
   */
  void _callHandler(Function handler, arg1, arg2, arg3) {
    if (arg1 == null) {
      handler();
    } else if (arg2 == null) {
      handler(arg1);
    } else if (arg3 == null) {
      handler(arg1, arg2);
    } else {
      handler(arg1, arg2, arg3);
    }
  }

  /**
   * This function binds the `handler` as a listener to the `event`.
   *
   * @param String event        The event to add the handler to.
   * @param Function handler    The handler to bind to the event.
   * @return void
   */
  void on(String event, Function handler) {
    this._events.putIfAbsent(event, () => new List<Function>());
    this._events.get(event).map((List<Function> handlers) {
      handlers.add(handler);
    });
  }

  /**
   * This function binds the `handler` as listener to the first
   * occurrence of the `event`. When `handler` is called once,
   * it is removed.
   *
   * @param String event        The event to add the handler to.
   * @param Function handler    The handler to bind to the event.
   * @return void
   */
  void once(String event, Function handler) {
    this._eventsOnce.putIfAbsent(event, () => new List<Function>());
    this._eventsOnce.get(event).map((List<Function> handlers) {
      handlers.add(handler);
    });
  }

  /**
   * This function attempt to unbind the `handler` from the `event`.
   *
   * @param String event        The event to remove the handler from.
   * @param Function handler    The handler to remove.
   * @return void
   */
  void removeListener(String event, Function handler) {
    this._events.get(event).map((List<Function> handlers) {
      this._events[event] = handlers.where((h) => h != handler).toList();
    });
    this._eventsOnce.get(event).map((List<Function> handlers) {
      this._eventsOnce[event] = handlers.where((h) => h != handler).toList();
    });
  }

  /**
   * This function attempt to remove all handlers from the `event`.
   *
   * @param String event        The event to remove all handlers.
   * @return void
   */
  void removeAllListeners(String event) {
    this._events.remove(event);
    this._eventsOnce.remove(event);
  }

  /**
   * This function unbind all the handlers for the events.
   */
  void clearListeners() {
    this._events.clear();
    this._eventsOnce.clear();
  }

  /**
   * Returns a list of listeners for the specified event.
   *
   * @param String event    The event to get all of their listeners.
   */
  List<Function> listeners(String event) {
    List<Function> result = new List();

    this._events.get(event).map((List<Function> handlers) {
      result.addAll(handlers);
    });

    this._eventsOnce.get(event).map((List<Function> handlers) {
      result.addAll(handlers);
    });

    return result;
  }

}
