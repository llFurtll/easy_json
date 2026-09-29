// Genéricos além de `T` / `List<T>`: coleções de `T`, classe genérica como
// campo e campos herdados de superclasse genérica.
import 'package:dart_easy_json/easy_json.dart';
import 'generic_models.easy.dart';

@EasyJson()
class Item with ItemSerializer {
  @EasyValidate(min: 0)
  final int n;
  Item({required this.n});
}

@EasyJson()
class Box<T> with BoxSerializer<T> {
  final Set<T> tags;
  final Map<String, T> byKey;
  final List<List<T>> grid;
  final T? maybe;
  Box({required this.tags, required this.byKey, required this.grid, this.maybe});
}

@EasyJson()
class Holder with HolderSerializer {
  final Box<Item> box;
  final Box<int>? nums;
  final List<Box<String>> many;
  final Map<String, Box<Item>> named;
  Holder({required this.box, this.nums, required this.many, required this.named});
}

@EasyJson()
class Wrapper<T> with WrapperSerializer<T> {
  final Box<T> inner;
  Wrapper({required this.inner});
}

class BasePage<T> {
  final List<T> items;
  final T? first;
  BasePage({required this.items, this.first});
}

@EasyJson()
class ItemPage extends BasePage<Item> with ItemPageSerializer {
  final int total;
  ItemPage({required super.items, super.first, required this.total});
}
