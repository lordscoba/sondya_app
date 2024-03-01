import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SondyaSelectWidget {
  void showBottomSheet<T>({
    required BuildContext context,
    required List<T> options,
    required void Function(T selectedOption) onItemSelected,
  }) {
    List<T> filteredOptions = List.from(options);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (query) {
                      setState(() {
                        filteredOptions = options
                            .where((option) => option
                                .toString()
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    itemCount: filteredOptions.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: ListTile(
                          title: Text(filteredOptions[index].toString()),
                          onTap: () {
                            onItemSelected(filteredOptions[index]);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showBottomSheetApi<T>({
    required BuildContext context,
    required AsyncValue<Map<String, dynamic>> options,
    required void Function(String selectedOption) onItemSelected,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return options.when(
          data: (data) {
            List<Map<String, dynamic>> allOptions = List.from(data["data"]);
            List<Map<String, dynamic>> filteredOptions = List.from(allOptions);
            return StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (query) {
                          setState(() {
                            filteredOptions = allOptions
                                .where((option) => option["name"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(query.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        itemCount: filteredOptions.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: ListTile(
                              key: ValueKey(filteredOptions[index]["name"]),
                              title: Text(
                                  filteredOptions[index]["name"].toString()),
                              onTap: () {
                                onItemSelected(filteredOptions[index]["name"]);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
          loading: () => const Center(
            child: CupertinoActivityIndicator(
              radius: 50,
            ),
          ),
          error: (error, stackTrace) => Text('Error: ${error.toString()}'),
        );
      },
    );
  }
}
