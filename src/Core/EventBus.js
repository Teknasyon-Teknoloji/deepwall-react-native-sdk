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

  fireEvent(eventName, data) {
    const Listeners = this.eventListeners[eventName];

    if (Array.isArray(Listeners)) {
      Listeners.map((listener) => {
        if (typeof listener === 'function') {
          listener(data);
        }
      });
    }
  }

  addListener(eventName, listener) {
    let listeners = this.eventListeners[eventName];

    if (Array.isArray(listeners)) {
      listeners.push(listener);
    } else {
      this.eventListeners[eventName] = [listener];
    }
  }

  removeListener(listener) {
    Object.keys(this.eventListeners).map(eventName => {
        let listeners = this.eventListeners[eventName];

        if (listeners) {
          for (let i = 0, l = listeners.length; i < l; i++) {
            if (listener === listeners[i]) {
              listeners.splice(i, 1);
            }
          }
        }

        if (listeners.length === 0) {
            delete this.eventListeners[eventName];
        }
    })
  }
}
