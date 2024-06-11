import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/providers/home.provider.dart';
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

  @override
  void initState() {
    super.initState();
    search = NavSearchBarType();
    // Initialize the variable in initState
  }

  void Function(int?)? _handleRadioValueChanged(value) {
    if (value == 0) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      extendBody: true,
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,
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
                      if (_selectedValue == 0) {
                        search.category = "products";

                        ref.read(productSearchprovider.notifier).state =
                            ProductSearchModel.fromJson(search.toJson());
                        context.push('/product/search');
                      } else {
                        search.category = "services";

                        ref.read(serviceSearchprovider.notifier).state =
                            ServiceSearchModel.fromJson(search.toJson());
                        context.push('/service/search');
                      }
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
    );
  }
}
