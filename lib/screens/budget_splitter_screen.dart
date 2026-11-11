import 'package:flutter/material.dart';

/// Split a trip's total cost between travellers, with optional
/// custom shares (e.g. a driver who pays less).
class BudgetSplitterScreen extends StatefulWidget {
  const BudgetSplitterScreen({super.key});

  @override
  State<BudgetSplitterScreen> createState() => _BudgetSplitterScreenState();
}

class _BudgetSplitterScreenState extends State<BudgetSplitterScreen> {
  final _totalController = TextEditingController(text: '12000');
  final List<TextEditingController> _names = [
    TextEditingController(text: 'Traveller 1'),
    TextEditingController(text: 'Traveller 2'),
    TextEditingController(text: 'Traveller 3'),
  ];
  final List<double> _weights = [1, 1, 1];

  @override
  void dispose() {
    _totalController.dispose();
    for (final c in _names) {
      c.dispose();
    }
    super.dispose();
  }

  double get _total => double.tryParse(_totalController.text.trim()) ?? 0;
  double get _weightSum => _weights.fold(0.0, (a, b) => a + b);

  double _shareOf(int i) => _weightSum == 0 ? 0 : _total * _weights[i] / _weightSum;

  void _addPerson() {
    setState(() {
      _names.add(TextEditingController(text: 'Traveller ${_names.length + 1}'));
      _weights.add(1);
    });
  }

  void _removePerson(int i) {
    if (_names.length <= 1) return;
    setState(() {
      _names.removeAt(i).dispose();
      _weights.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Budget Splitter')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPerson,
        icon: const Icon(Icons.person_add),
        label: const Text('Add person'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          TextField(
            controller: _totalController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Total trip cost (₹)',
              prefixIcon: Icon(Icons.currency_rupee),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          Card(
            color: scheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _stat('People', '${_names.length}', scheme),
                  _stat('Equal share',
                      '₹${(_names.isEmpty ? 0 : _total / _names.length).toStringAsFixed(0)}',
                      scheme),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('Adjust the slider to give someone a bigger or smaller share.'),
          ),
          for (int i = 0; i < _names.length; i++)
            Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _names[i],
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: false,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Text('₹${_shareOf(i).toStringAsFixed(0)}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: scheme.primary)),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => _removePerson(i),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Share'),
                        Expanded(
                          child: Slider(
                            value: _weights[i],
                            min: 0,
                            max: 3,
                            divisions: 12,
                            label: '${_weights[i]}x',
                            onChanged: (v) => setState(() => _weights[i] = v),
                          ),
                        ),
                        Text('${_weights[i].toStringAsFixed(2)}x'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _stat(String label, String value, ColorScheme scheme) => Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: scheme.onPrimaryContainer)),
          Text(label, style: TextStyle(color: scheme.onPrimaryContainer)),
        ],
      );
}
