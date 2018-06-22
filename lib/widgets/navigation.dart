
import 'package:flutter/widgets.dart';
import 'package:talkpal/talkpal.dart';
import 'package:built_redux/built_redux.dart';
// import 'package:flutter_built_redux/flutter_built_redux.dart';

class Navigation extends StatefulWidget  {
  const Navigation({Key key, this.store }) : super(key: key);

  final Store<AppState, AppStateBuilder, AppActions> store;

  static NavigationState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  NavigationState createState() => new NavigationState(store);
}

class NavigationState extends State<Navigation>  {

    final Store<AppState, AppStateBuilder, AppActions> store;
    
    NavigationState(this.store);

    @override
    void initState() {
      super.initState();

      this.widget.store.actions.startLoginFlow(this.context);
      
      widget.store.actionStream(AppActionsNames.loginSuccess).listen((change) {
   
        if( !change.next.user.loggedIn )
        {
          widget.store.actions.startLoginFlow(this.context);
        }
      });
    }

 @override
  Widget build(BuildContext context) =>   
    _InheritedStateContainer(
      data: this,
      child: Container(),
    );  
}

class _InheritedStateContainer extends InheritedWidget {
  final NavigationState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // Note: we could get fancy here and compare whether the old AppState is
  // different than the current AppState. However, since we know this is the
  // root Widget, when we make changes we also know we want to rebuild Widgets
  // that depend on the StateContainer.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}