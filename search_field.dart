import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.searchController,
    required this.listStateRefresher,
  }) : super(key: key);

  final TextEditingController searchController;
  final Function listStateRefresher;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 17,
                offset: Offset(0, 5),
              ),
            ]),
        child: Builder(
          builder: (controller) {
            return TextField(
              controller: searchController,
              onChanged: (text) => listStateRefresher(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                hintText: 'search here',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.search),
                ),
                hintStyle: const TextStyle(
                  fontSize: 14,
                ),
              ),
              style: const TextStyle(
                fontSize: 14,
              ),
            );
          },
        ),
      ),
    );
  }
}
