/**
 * EventBus
 *
 * Taken from: "https://github.com/crazycodeboy/react-native-event-bus"
 */
export default class EventBus {
  eventListeners = [];

  static getInstance() {
    if (!EventBus.instance) {
      EventBus.instance = new EventBus();
    }

    return EventBus.instance;
  }

  dispatch(eventName, data) {
    const Listeners = this.eventListeners[eventName];

    if (Array.isArray(Listeners)) {
      Listeners.map((listener) => {
        if (typeof listener === 'function') {
          listener(data);
        }
      });
    }
  }

  listen(eventName, listener) {
    let listeners = this.eventListeners[eventName];

    if (Array.isArray(listeners)) {
      listeners.push(listener);
    } else {
      this.eventListeners[eventName] = [listener];
    }
  }
}
