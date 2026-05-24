import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pangsitttto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: const HomeScreen(),
    );
  }
}

// ── DATA ──
final List<Map<String, String>> menuList = [
  {
    'gambar': 'assets/pangsit_rebus.jpg',
    'nama': 'Pangsit Rebus',
    'desc': 'Kulit tipis, isi daging sapi & udang, kuah bening gurih.',
  },
  {
    'gambar': 'assets/pangsit_goreng.jpg',
    'nama': 'Pangsit Goreng',
    'desc': 'Renyah keemasan, isi ayam & jamur, cocol saus pedas manis.',
  },
  {
    'gambar': 'assets/mie_pangsit.jpg',
    'nama': 'Mi Pangsit',
    'desc': 'Mi kenyal, topping pangsit rebus',
  },
  {
    'gambar': 'assets/pangsit_pedas.jpg',
    'nama': 'Pangsit Kuah Pedas',
    'desc': 'Kuah merah pedas menggoda, level 1–5.',
  },
  {
    'gambar': 'assets/es_teh.jpg',
    'nama': 'Es Teh',
    'desc': 'Teh segar tanpa pengawet.',
  },
];

// ── HOME SCREEN ──
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pangsitttto'),
        backgroundColor: Colors.red[800],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.red[50],
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text('🥟', style: TextStyle(fontSize: 48)),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pangsitttton',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text('Pangsit terenak se-Jagat Raya!'),

                    const SizedBox(height: 4),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[800],
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FormPesanScreen(),
                        ),
                      ),
                      child: const Text(
                        'Pesan Sekarang',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Menu Kami',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                final item = menuList[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  child: ListTile(
                    leading: Image.asset(
                      item['gambar']!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),

                    title: Text(
                      item['nama']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text(item['desc']!),

                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),

                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(item: item),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── DETAIL SCREEN ──
class DetailScreen extends StatelessWidget {
  final Map<String, String> item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['nama']!),
        backgroundColor: Colors.red[800],
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Image.asset(item['gambar']!, height: 180, fit: BoxFit.cover),

            const SizedBox(height: 16),

            Text(
              item['nama']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
              ),

              child: Text(
                item['desc']!,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                minimumSize: const Size(double.infinity, 48),
              ),

              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FormPesanScreen(namaMenu: item['nama']),
                ),
              ),

              icon: const Icon(Icons.shopping_cart, color: Colors.white),

              label: const Text(
                'Pesan Menu Ini',
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),

              onPressed: () => Navigator.pop(context),

              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

// ── FORM PESAN SCREEN ──
class FormPesanScreen extends StatefulWidget {
  final String? namaMenu;

  const FormPesanScreen({super.key, this.namaMenu});

  @override
  State<FormPesanScreen> createState() => _FormPesanScreenState();
}

class _FormPesanScreenState extends State<FormPesanScreen> {
  final _namaCtrl = TextEditingController();
  final _menuCtrl = TextEditingController();
  final _catatanCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _menuCtrl.text = widget.namaMenu ?? '';
  }

  void _kirimPesanan() {
    if (_namaCtrl.text.isEmpty || _menuCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama dan menu wajib diisi!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pesanan Masuk! 🎉'),

        content: Text(
          'Nama: ${_namaCtrl.text}\n'
          'Menu: ${_menuCtrl.text}\n'
          'Catatan: ${_catatanCtrl.text.isEmpty ? '-' : _catatanCtrl.text}',
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pesanan'),
        backgroundColor: Colors.red[800],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: _namaCtrl,

              decoration: const InputDecoration(
                labelText: 'Nama Kamu',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: _menuCtrl,

              decoration: const InputDecoration(
                labelText: 'Menu yang Dipesan',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.restaurant),
              ),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: _catatanCtrl,
              maxLines: 3,

              decoration: const InputDecoration(
                labelText: 'Catatan (opsional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                minimumSize: const Size(double.infinity, 50),
              ),

              onPressed: _kirimPesanan,

              child: const Text(
                'Kirim Pesanan',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
