import 'package:flutter/material.dart';

const double _kAppBarHeight = 128.0;
// const double _kFabHalfSize = 28.0; // TODO(mpcomplete): needs to adapt to screen size
const double _kRecipePageMaxWidth = 500.0;


final ThemeData _kTheme = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  accentColor: Colors.redAccent,
);

class CreateEventPage extends StatefulWidget {
  CreateEventPage({Key key, this.title, this.coverUrl}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String coverUrl;

  @override
  _CreateEventPageState createState() => new _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Theme(
      data: _kTheme.copyWith(platform: Theme.of(context).platform),
      child: new Scaffold(
        key: scaffoldKey,
        floatingActionButton: new FloatingActionButton(
          child: const Icon(Icons.edit),
          onPressed: () {
            scaffoldKey.currentState.showSnackBar(const SnackBar(
              content: const Text('Not supported.'),
            ));
          },
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(context, statusBarHeight),
            _buildBody(context, statusBarHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, double statusBarHeight) {
    return new SliverAppBar(
      pinned: true,
      expandedHeight: _kAppBarHeight,
      actions: <Widget>[
        new IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {
            scaffoldKey.currentState.showSnackBar(const SnackBar(
              content: const Text('Not supported.'),
            ));
          },
        ),
      ],
      flexibleSpace:  new FlexibleSpaceBar(
                title: const Text('Ali Connors'),
                background: new Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      height: 148.0,
                      decoration: new BoxDecoration(
                        // shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(widget.coverUrl),
                          ),
                        ),
                    ),                   
                    // This gradient ensures that the toolbar icons are distinct
                    // against the background image.
                    const DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: const LinearGradient(
                          begin: const Alignment(0.0, -1.0),
                          end: const Alignment(0.0, -0.4),
                          colors: const <Color>[const Color(0x60000000), const Color(0x00000000)],
                        ),
                      ),
                    ),
                  ],
                ),
              )
  
    );
  }
   
  Widget _buildBody(BuildContext context, double statusBarHeight) {
      final EdgeInsets mediaPadding = MediaQuery.of(context).padding;
      final EdgeInsets padding = new EdgeInsets.only(
        top: 8.0,
        left: 8.0 + mediaPadding.left,
        right: 8.0 + mediaPadding.right,
        bottom: 8.0
      );
      return new SliverPadding(
        padding: padding,
        sliver: new SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: _kRecipePageMaxWidth,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              
              return Text("Text $index");
            },
            childCount: 5
          ),
        ),
      );
    }
    
    // CustomScrollView(
    //   slivers: <Widget>[
    //     new SliverAppBar(
    //       pinned: true,
    //       expandedHeight: 250.0,
    //       flexibleSpace: new FlexibleSpaceBar(
    //         title: new Text(widget.title),
    //         background: new Image.network(widget.coverUrl),
    //       ),
    //     ),
    //     new SliverPadding(
    //       padding: new EdgeInsets.all(16.0),
    //       sliver: new SliverList(
    //         delegate: new SliverChildListDelegate(<Widget>[
             
    //               new Container(
    //                 height: 120.0,
    //                 decoration: new BoxDecoration(
    //                   // shape: BoxShape.circle,
    //                     image: new DecorationImage(
    //                       fit: BoxFit.cover,
    //                       image: new NetworkImage(widget.coverUrl),
    //                     ),
    //                   ),
    //                 ),
                    
    //               new ListTile(
    //                 leading: const Icon(Icons.person),
    //                 title: new TextField(
    //                   decoration: new InputDecoration(
    //                     hintText: "Name",
    //                   ),
    //                 ),
    //               ),
    //               new ListTile(
    //                 leading: const Icon(Icons.phone),
    //                 title: new TextField(
    //                   decoration: new InputDecoration(
    //                     hintText: "Phone",
    //                   ),
    //                 ),
    //               ),
    //               new ListTile(
    //                 leading: const Icon(Icons.email),
    //                 title: new TextField(
    //                   decoration: new InputDecoration(
    //                     hintText: "Email",
    //                   ),
    //                 ),
    //               ),
    //               const Divider(
    //                 height: 1.0,
    //               ),
    //               new ListTile(
    //                 leading: const Icon(Icons.label),
    //                 title: const Text('Nick'),
    //                 subtitle: const Text('None'),
    //               ),
    //               new ListTile(
    //                 leading: const Icon(Icons.today),
    //                 title: const Text('Birthday'),
    //                 subtitle: const Text('February 20, 1980'),
    //                 trailing: const Icon(Icons.check_circle, color: Colors.green,),
    //               ),
    //               new ListTile(
    //                 leading: const Icon(Icons.group),
    //                 title: const Text('Contact group'),
    //                 subtitle: const Text('Not specified'),
    //               )
    //         ]),
    //       ),
    //     ),
    //   ],
    // );

    // return new Scaffold(
    //   appBar: new AppBar(
    //     // Here we take the value from the CreateEventPage object that was created by
    //     // the App.build method, and use it to set our appbar title.
    //     title: new Text(widget.title),
    //     actions: <Widget>[
    //       new IconButton(icon: const Icon(Icons.save), onPressed: () {})
    //     ],
    //   ),
    //   body: new Column(
    //     children: <Widget>[
    //       new Container(
    //         height: 120.0,
    //         decoration: new BoxDecoration(
    //           // shape: BoxShape.circle,
    //             image: new DecorationImage(
    //               fit: BoxFit.cover,
    //               image: new NetworkImage(widget.coverUrl),
    //             ),
    //           ),
    //         ),
    //       new ListTile(
    //         leading: const Icon(Icons.person),
    //         title: new TextField(
    //           decoration: new InputDecoration(
    //             hintText: "Name",
    //           ),
    //         ),
    //       ),
    //       new ListTile(
    //         leading: const Icon(Icons.phone),
    //         title: new TextField(
    //           decoration: new InputDecoration(
    //             hintText: "Phone",
    //           ),
    //         ),
    //       ),
    //       new ListTile(
    //         leading: const Icon(Icons.email),
    //         title: new TextField(
    //           decoration: new InputDecoration(
    //             hintText: "Email",
    //           ),
    //         ),
    //       ),
    //       const Divider(
    //         height: 1.0,
    //       ),
    //       new ListTile(
    //         leading: const Icon(Icons.label),
    //         title: const Text('Nick'),
    //         subtitle: const Text('None'),
    //       ),
    //       new ListTile(
    //         leading: const Icon(Icons.today),
    //         title: const Text('Birthday'),
    //         subtitle: const Text('February 20, 1980'),
    //         trailing: const Icon(Icons.check_circle, color: Colors.green,),
    //       ),
    //       new ListTile(
    //         leading: const Icon(Icons.group),
    //         title: const Text('Contact group'),
    //         subtitle: const Text('Not specified'),
    //       )
    //     ],
    //   ),
    // );

}