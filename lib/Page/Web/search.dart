// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import '../../main.dart';
import 'pagesmall.dart';
import '../../Design/design_course_app_theme.dart';
import 'package:get/get.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  String? _selectedCity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          Expanded(
              child: Form(
                  key: this._formKey,
                  child: Column(
                    children: <Widget>[
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                          autofocus: false,
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontStyle: FontStyle.italic),
                          decoration:
                              InputDecoration(border: OutlineInputBorder())),
                      suggestionsCallback: (pattern) async {
                        return await BackendService.getSuggestions(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          leading: Icon(Icons.shopping_cart),
                          title: Text(suggestion['name']!),
                          subtitle: Text('\$${suggestion['price']}'),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(product: suggestion)));
                      },
                    )  
                  ]))
                  )
          //),
        ],
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  final Map<String, String> product;

  ProductPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text(
              this.product['name']!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              this.product['price']! + ' USD',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}

class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    await Future<void>.delayed(Duration(seconds: 1));

    return List.generate(3, (index) {
      return {
        'name': query + index.toString(),
        'price': Random().nextInt(100).toString()
      };
    });
  }
}
