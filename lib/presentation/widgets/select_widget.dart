import 'package:flutter/material.dart';

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
}
