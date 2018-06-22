import 'package:built_redux/built_redux.dart';

import 'package:talkpal/talkpal.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final eventsMiddlewareBuilder = new MiddlewareBuilder<AppState, AppStateBuilder, AppActions>();
//   ..add(AppActionsNames.newEventAction, requestEventAction);

// void requestEventAction(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next, Action<EventRequest> action) async {
//   next(action);

//   CollectionReference collection = Firestore.instance.collection('eventsAction');
//   Map<String, dynamic> data = serializers.serialize(action.payload);
//   print("#requestEventAction ${data.toString()}");

//   collection.add(data).then((ref){        
//         print('Added document with ID: ${ref.documentID} ');
//         return true;
//      });
// }

