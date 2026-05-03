import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/kos_provider.dart';
import '../../widgets/filter_bottom_sheet.dart';
import '../../widgets/kos_card.dart';
import '../auth/login_screen.dart';
import 'privacy_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Keluar",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Apakah anda yakin ingin keluar dari akun?",
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Batal", style: GoogleFonts.inter(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: Text("Keluar", style: GoogleFonts.inter(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final provider = context.read<KosProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FilterBottomSheet(
          initialLocation: provider.selectedLocation,
          initialType: provider.selectedType,
          initialPriceRanges: provider.selectedPriceRanges,
          onApply: (location, type, priceRanges) {
            provider.applyFilters(
              location: location,
              type: type,
              priceRanges: priceRanges,
            );
          },
          onClear: () {
            provider.clearFilters();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Kos",
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(Icons.home_work_rounded, color: Colors.orange.shade800),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onSelected: (value) {
              if (value == 'pusat_bantuan') {
                // No action needed yet
              } else if (value == 'kebijakan_privasi') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyScreen()),
                );
              } else if (value == 'keluar') {
                _showLogoutDialog(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'pusat_bantuan',
                child: Text('Pusat Bantuan'),
              ),
              const PopupMenuItem(
                value: 'kebijakan_privasi',
                child: Text('Kebijakan Privasi'),
              ),
              const PopupMenuItem(
                value: 'keluar',
                child: Text(
                  'Keluar / Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Search Bar and Filter
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        context.read<KosProvider>().updateSearchQuery(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Cari kost anda",
                        hintStyle: GoogleFonts.inter(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade800,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white),
                    onPressed: () => _showFilterBottomSheet(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<KosProvider>(
                builder: (context, provider, child) {
                  final kosList = provider.filteredKosList;
                  if (kosList.isEmpty) {
                    return const Center(
                      child: Text('Tidak ada Kos yang sesuai'),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: kosList.length,
                    itemBuilder: (context, index) {
                      final kos = kosList[index];
                      return KosCard(kos: kos);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
