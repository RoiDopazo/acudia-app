import 'package:acudia/app-localizations.dart';
import 'package:acudia/core/providers/AuthProvider.dart';
import 'package:acudia/core/providers/CounterProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final authModel = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(translate(context, 'app_name')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalizations.of(context).translate('title')),
            // Consumer looks for an ancestor Provider widget
            // and retrieves its model (Counter, in this case).
            // Then it uses that model to build widgets, and will trigger
            // rebuilds if the model is updated.
            Consumer<CounterProvider>(
              builder: (context, counter, child) => Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            MaterialButton(
              child: Text('Decrement'),
              onPressed: () =>
                  Provider.of<CounterProvider>(context, listen: false)
                      .decrement(),
            ),
            RaisedButton(
              onPressed: () =>
                  Provider.of<AuthProvider>(context, listen: false).doLogin(),
              child: Text("Login G+"),
              color: Colors.primaries[0],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Provider.of is another way to access the model object held
        // by an ancestor Provider. By default, even this listens to
        // changes in the model, and rebuilds the whole encompassing widget
        // when notified.
        //
        // By using `listen: false` below, we are disabling that
        // behavior. We are only calling a function here, and so we don't care
        // about the current value. Without `listen: false`, we'd be rebuilding
        // the whole MyHomePage whenever Counter notifies listeners.
        onPressed: () =>
            Provider.of<CounterProvider>(context, listen: false).increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
