import 'package:flutter/material.dart';
import 'sos_contact.dart';

class EmergencyScreen extends StatelessWidget {
  static const routeName = '/emergency';
  const EmergencyScreen({super.key});

  List<SOSContact> _contacts() => const [
        SOSContact(
            name: 'Campus Security', phone: '555-100', shareLocation: true),
        SOSContact(name: 'Health Center', phone: '555-200'),
      ];

  void _callContact(BuildContext context, SOSContact contact) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Call ${contact.name}?'),
        content: Text(
            'Dial ${contact.phone}${contact.shareLocation ? ' and share your location.' : '.'}'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Call')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contacts = _contacts();

    return Scaffold(
      appBar: AppBar(title: const Text('Emergency')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Share live location on SOS'),
                subtitle: const Text(
                    'Optional: include GPS link when contacting security'),
                trailing: Switch(
                  value: contacts.first.shareLocation,
                  onChanged: (_) {},
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: Semantics(
                  label: 'Send emergency SOS to campus security',
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(120),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Emergency'),
                          content: const Text(
                              'Would you like to call campus security and share your location?'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancel')),
                            ElevatedButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Call')),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.warning, size: 40),
                    label: const Text('SOS', style: TextStyle(fontSize: 28)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...contacts.map(
              (c) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  tileColor: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: const Icon(Icons.phone),
                  title: Text(c.name),
                  subtitle: Text(
                      '${c.phone}${c.shareLocation ? ' • shares location' : ''}'),
                  trailing: ElevatedButton(
                    onPressed: () => _callContact(context, c),
                    child: const Text('Call'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
