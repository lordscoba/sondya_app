import 'package:flutter/material.dart';
import 'package:sondya_app/utils/input_validations.dart';

class VariationWidget extends StatefulWidget {
  final Map<String, List<dynamic>> mapData;
  final void Function(Map<String, List<dynamic>> mapData) onItemSelected;
  const VariationWidget(
      {super.key, this.mapData = const {}, required this.onItemSelected});

  @override
  State<VariationWidget> createState() => _VariationWidgetState();
}

class _VariationWidgetState extends State<VariationWidget> {
  Map<String, List<dynamic>> mapIte = {};

  @override
  void initState() {
    super.initState();

    if (widget.mapData.isEmpty) {
      mapIte.addAll({
        "variant 1": [],
      });
    } else {
      mapIte.addAll(widget.mapData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: mapIte.length,
          itemBuilder: (context, index) {
            var key = mapIte.keys.elementAt(index);
            var values = mapIte[key] ?? [];
            return VariantItem(
              keyW: key,
              valuesW: values,
              onItemSelected: (newKey, newValues) {
                setState(() {
                  mapIte.remove(key);
                  mapIte[newKey] = newValues;
                  widget.onItemSelected(mapIte);
                });
              },
            );
          },
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {
            setState(() {
              mapIte.addEntries([MapEntry("variant ${mapIte.length + 1}", [])]);
            });
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add),
              SizedBox(width: 10),
              Text("Add Variant"),
            ],
          ),
        ),
      ],
    );
  }
}

class VariantItem extends StatefulWidget {
  final String keyW;
  final List<dynamic> valuesW;
  final void Function(String newKey, List<dynamic> newValues) onItemSelected;
  const VariantItem(
      {super.key,
      required this.keyW,
      required this.valuesW,
      required this.onItemSelected});

  @override
  State<VariantItem> createState() => _VariantItemState();
}

class _VariantItemState extends State<VariantItem> {
  final _formKey = GlobalKey<FormState>();
  late String key;
  late List<dynamic> values;

  String newValues = "";
  @override
  void initState() {
    super.initState();
    key = widget.keyW;
    values = widget.valuesW;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Variation Type",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter Variation Type",
                    labelText: 'Variation Type',
                  ),
                  initialValue: key,
                  validator: isInputEmpty,
                  onSaved: (value) {
                    key = value!;
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                values.isEmpty
                    ? const Text(
                        "Variation",
                        style: TextStyle(color: Colors.grey),
                      )
                    : Wrap(
                        spacing: 5,
                        children: values.map((item) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 35,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFEDB842).withOpacity(0.7),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  item.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEDB842),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: const EdgeInsets.all(2.0),
                                  iconSize: 15,
                                  color: Colors.white,
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      if (_formKey.currentState!.validate()) {
                                        values.remove(item);
                                        _formKey.currentState?.save();

                                        // call back and save
                                        widget.onItemSelected(key, values);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter Variation",
                    labelText: 'Variation',
                  ),
                  controller: TextEditingController(text: newValues),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    if (value != null) {
                      newValues = value;
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
                color: const Color(0xFFEDB842).withOpacity(0.33),
                borderRadius: BorderRadius.circular(8)),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: Color(0xFFEDB842),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  setState(() {
                    values.add(newValues);
                    // call back and save
                    widget.onItemSelected(key, values);
                    newValues = "";
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
