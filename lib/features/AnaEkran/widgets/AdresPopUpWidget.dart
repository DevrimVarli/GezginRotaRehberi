import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/Konum.dart';
import '../../../providers/all_providers.dart';

class AdresPopUpWidget extends ConsumerWidget {
  const AdresPopUpWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final konum = ref.watch(secilemKonumStateProvider);
    final konumList = ref.watch(konumlarProvider);

    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            color: colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 1),
          Text(
            "${konum.ilce_adi}, ${konum.sehir_adi}",
            style: GoogleFonts.roboto(
              fontSize: 15,
              color: colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 2),
          PopupMenuButton<Konum>(
            elevation: 3,
            shadowColor: colorScheme.shadow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: colorScheme.background,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 30,
              color: colorScheme.primary,
            ),
            itemBuilder: (BuildContext context) {
              final items = konumList.map((Konum konum) {
                return PopupMenuItem<Konum>(
                  value: konum,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${konum.ilce_adi}, ${konum.sehir_adi}",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ref.read(konumlarProvider.notifier).state.remove(konum);
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.delete, color: colorScheme.onSurfaceVariant),
                        )
                      ],
                    ),
                  ),
                );
              }).toList();

              // Yeni adres ekle butonu
              items.add(
                PopupMenuItem<Konum>(
                  height: 48,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      _showAddAddressDialog(context, ref);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Yeni Adres Ekle",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );

              return items;
            },
            onCanceled: () {
              debugPrint("Seçim iptal edildi");
            },
            onSelected: (Konum selectedKonum) {
              ref.read(secilemKonumStateProvider.notifier).state = selectedKonum;
              if (ref.read(seeAllStateProvider)) {
                ref.read(seeAllStateProvider.notifier).state = false;
              }
            },
          ),
        ],
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final TextEditingController cityController = TextEditingController();
    final TextEditingController districtController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorScheme.surfaceVariant.withOpacity(0.95),
          title: Text(
            "Yeni Adres Ekle",
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(color: colorScheme.onSurface),
                controller: cityController,
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.roboto(
                    fontSize: 18,
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 18,
                    color: colorScheme.onSurface.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                  labelText: "Şehir",
                  hintText: "Şehir adını giriniz",
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: TextStyle(color: colorScheme.onSurface),
                controller: districtController,
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.roboto(
                    fontSize: 18,
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 18,
                    color: colorScheme.onSurface.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                  labelText: "İlçe",
                  hintText: "İlçe adını giriniz",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "İptal",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
              ),
              onPressed: () {
                final newAddress = Konum(
                  cityController.text,
                  districtController.text,
                );
                ref.read(konumlarProvider.notifier).state.add(newAddress);
                Navigator.pop(context);
              },
              child: Text(
                "Ekle",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
