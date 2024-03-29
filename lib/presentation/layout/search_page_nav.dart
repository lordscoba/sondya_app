import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SearchPageNavbar extends ConsumerStatefulWidget {
  const SearchPageNavbar({super.key});

  @override
  ConsumerState<SearchPageNavbar> createState() => _SearchPageNavbarState();
}

class _SearchPageNavbarState extends ConsumerState<SearchPageNavbar> {
  final _formKey = GlobalKey<FormState>();
  late NavSearchBarType search;

  int _selectedValue = 0; // Initially selected value
  String _selectedString = 'Products';

  void Function(int?)? _handleRadioValueChanged(value) {
    if (_selectedValue == 0) {
      setState(() {
        _selectedValue = value!;
        _selectedString = "Products";
      });
    } else {
      setState(() {
        _selectedValue = value!;
        _selectedString = "Services";
      });
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    search = NavSearchBarType();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: 650,
            width: 380,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter search",
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                    validator: isInputEmpty,
                    onSaved: (value) {
                      search.search = value!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(_selectedString),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 0,
                        groupValue: _selectedValue,
                        onChanged: _handleRadioValueChanged,
                      ),
                      const Text("Product"),
                      Radio(
                        value: 1,
                        groupValue: _selectedValue,
                        onChanged: _handleRadioValueChanged,
                      ),
                      const Text("Service"),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // context.push('/home');
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                      }
                    },
                    child: const Text("Search"),
                  ),
                ],
                // Your scrollable content here
              ),
            ),
          ),
        ),
      ),
    );
  }
}
