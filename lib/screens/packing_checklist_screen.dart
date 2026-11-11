import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Packing checklist with categories, progress bar and local persistence.
class PackingChecklistScreen extends StatefulWidget {
  const PackingChecklistScreen({super.key});

  @override
  State<PackingChecklistScreen> createState() => _PackingChecklistScreenState();
}

class _PackItem {
  String name;
  String category;
  bool packed;
  _PackItem(this.name, this.category, {this.packed = false});

  Map<String, dynamic> toJson() =>
      {'name': name, 'category': category, 'packed': packed};
  factory _PackItem.fromJson(Map<String, dynamic> j) => _PackItem(
        j['name'] as String,
        j['category'] as String,
        packed: j['packed'] as bool? ?? false,
      );
}

class _PackingChecklistScreenState extends State<PackingChecklistScreen> {
  static const _prefsKey = 'packing_checklist_v1';
  static const _categories = ['Essentials', 'Clothes', 'Gadgets', 'Vehicle', 'Health'];
  static const Map<String, IconData> _icons = {
    'Essentials': Icons.badge,
    'Clothes': Icons.checkroom,
    'Gadgets': Icons.devices,
    'Vehicle': Icons.directions_car,
    'Health': Icons.medical_services,
  };

  final List<_PackItem> _items = [];
  final TextEditingController _controller = TextEditingController();
  String _newCategory = 'Essentials';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_PackItem> _defaults() => [
        _PackItem('ID card / Driving licence', 'Essentials'),
        _PackItem('Wallet & cards', 'Essentials'),
        _PackItem('Hotel bookings', 'Essentials'),
        _PackItem('Rain jacket', 'Clothes'),
        _PackItem('Comfortable shoes', 'Clothes'),
        _PackItem('Phone charger', 'Gadgets'),
        _PackItem('Power bank', 'Gadgets'),
        _PackItem('Vehicle RC & insurance', 'Vehicle'),
        _PackItem('Spare tyre / puncture kit', 'Vehicle'),
        _PackItem('First-aid kit', 'Health'),
        _PackItem('Water bottle', 'Health'),
      ];

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    final loaded = <_PackItem>[];
    if (raw != null) {
      try {
        final list = jsonDecode(raw) as List<dynamic>;
        loaded.addAll(list.map((e) => _PackItem.fromJson(e as Map<String, dynamic>)));
      } catch (_) {}
    }
    if (!mounted) return;
    setState(() {
      _items
        ..clear()
        ..addAll(loaded.isEmpty ? _defaults() : loaded);
      _loading = false;
    });
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _prefsKey, jsonEncode(_items.map((e) => e.toJson()).toList()));
  }

  void _addItem() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _items.add(_PackItem(text, _newCategory)));
    _controller.clear();
    _save();
  }

  void _resetAll() {
    setState(() {
      for (final i in _items) {
        i.packed = false;
      }
    });
    _save();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final packed = _items.where((i) => i.packed).length;
    final progress = _items.isEmpty ? 0.0 : packed / _items.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Packing Checklist'),
        actions: [
          IconButton(
            tooltip: 'Uncheck all',
            icon: const Icon(Icons.restart_alt),
            onPressed: _resetAll,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$packed of ${_items.length} items packed',
                              style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: progress),
                            duration: const Duration(milliseconds: 500),
                            builder: (_, value, __) => ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: value,
                                minHeight: 10,
                              ),
                            ),
                          ),
                          if (progress == 1.0) ...[
                            const SizedBox(height: 8),
                            Text('All set! Have a great trip 🎉',
                                style: TextStyle(color: scheme.primary)),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(hintText: 'Add an item'),
                          onSubmitted: (_) => _addItem(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _newCategory,
                        underline: const SizedBox(),
                        items: _categories
                            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                            .toList(),
                        onChanged: (v) => setState(() => _newCategory = v ?? _newCategory),
                      ),
                      IconButton.filled(
                        onPressed: _addItem,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: _categories.map((cat) {
                      final catItems = _items.where((i) => i.category == cat).toList();
                      if (catItems.isEmpty) return const SizedBox.shrink();
                      return ExpansionTile(
                        initiallyExpanded: true,
                        leading: Icon(_icons[cat], color: scheme.primary),
                        title: Text(
                            '$cat  (${catItems.where((i) => i.packed).length}/${catItems.length})'),
                        children: catItems.map((item) {
                          return Dismissible(
                            key: ObjectKey(item),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              color: Colors.redAccent,
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (_) {
                              setState(() => _items.remove(item));
                              _save();
                            },
                            child: CheckboxListTile(
                              value: item.packed,
                              title: Text(
                                item.name,
                                style: TextStyle(
                                  decoration: item.packed
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              onChanged: (v) {
                                setState(() => item.packed = v ?? false);
                                _save();
                              },
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
