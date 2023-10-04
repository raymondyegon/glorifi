import 'dart:async';

///Class for emitting events
///BaseEventListeningController is subscribed to this stream
///For now there is only one event in use, meaning on account unlinked we update some data see
/// - BaseEventListeningController onAccountsChanged()
/// - MyBankController onAccountsChanged


class EventBroadcaster {
  EventBroadcaster._();

  static EventBroadcaster _instance = EventBroadcaster._();

  static EventBroadcaster get instance => _instance;

  StreamController<BroadcastableEvent> _controller = StreamController<BroadcastableEvent>.broadcast();

  Stream<BroadcastableEvent> get stream => _controller.stream;

  void addEvent(BroadcastableEvent event){
    _controller.sink.add(event);
  }
}

abstract class BroadcastableEvent {}

class AccountsChangedEvent extends BroadcastableEvent {}

class CreditScoreWasEnabledEvent extends BroadcastableEvent {}