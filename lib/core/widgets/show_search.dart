import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/person.dart';
import 'package:search_page/search_page.dart';

show(BuildContext context) {
  showSearch(
    context: context,
    delegate: SearchPage<Object>(
      items: people,
      searchLabel: 'Search people',
      suggestion: const Center(
        child: Text('Filter people by name, surname or age'),
      ),
      failure: const Center(
        child: Text('No person found :('),
      ),
      filter: (person) => [
        (person as Person).name,
        (person).surname,
        (person).age.toString(),
      ],
      builder: (person) => ListTile(
        title: Text((person as Person).name),
        subtitle: Text((person).surname),
        trailing: Text('${(person).age} yo'),
      ),
    ),
  );
}
