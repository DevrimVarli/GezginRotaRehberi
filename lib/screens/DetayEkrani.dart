import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_tasarim/model/Imkanlar.dart';
import 'package:yeni_tasarim/model/Restorantlar.dart';
import 'package:yeni_tasarim/repository/IconRepo.dart';
import '../model/oteller.dart';

class DetayEkrani extends StatefulWidget {
  Oteller? secilenOtel;
  Restorantlar? secilenRestorant;
  DetayEkrani({super.key, this.secilenOtel, this.secilenRestorant});

  @override
  State<DetayEkrani> createState() => _DetayEkraniState();
}

class _DetayEkraniState extends State<DetayEkrani> {
  List<Imkanlar>imkanList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IconRepo().imkanlar(imkanList);

  }
  @override
  Widget build(BuildContext context) {
    double ekranYuksekligi = MediaQuery.sizeOf(context).height;
    double ekranGenisligi = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children:[ Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Arka plan resim
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: ekranGenisligi,
                        height: 380,
                        child: widget.secilenOtel != null
                            ? Image.asset(
                          "assets/${widget.secilenOtel!.otel_resim}",
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          "assets/${widget.secilenRestorant!.restoran_resim}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Geri butonu (sol üst)
                    Positioned(
                      top: 20,
                      left: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Colors.white,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios, size: 18, color: Colors.grey),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),

                    // Favori butonu (sağ alt, biraz dışarı taşıyor)
                    Positioned(
                      bottom: -20,
                      right: 20,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.favorite, color: Colors.red, size: 30),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0,bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 👈 tüm çocukları sola hizalar
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.secilenOtel != null
                                ? widget.secilenOtel!.otel_ad
                                : widget.secilenRestorant!.restoran_ad,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Show map",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          SizedBox(width: 4),
                          Text(
                            widget.secilenOtel != null
                                ? widget.secilenOtel!.otel_yazi.toString()
                                : widget.secilenRestorant!.restoran_puan.toString(),
                            style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "(355 Reviews)",
                            style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        widget.secilenOtel != null
                            ? "${widget.secilenOtel!.otelAciklama}"
                            : "${widget.secilenRestorant!.restoranAciklama}",
                        style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey.shade900),
                      ),
                      SizedBox(height: 4),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Read more",
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, color: Colors.blue),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Facilities",style: GoogleFonts.roboto(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 100, // sabit yükseklik veriyoruz çünkü ListView yatay olacak
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal, // 👈 bunu ekle
                        itemCount: imkanList.length,
                        itemBuilder: (context, indeks) {
                          Imkanlar imkan = imkanList[indeks];
                          return Container(
                            width: ekranGenisligi/4.6,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                imkan.icon,
                                SizedBox(height: 4),
                                Text(imkan.imkanAdi),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: ekranGenisligi,
                  height: 80,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: GoogleFonts.roboto(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.secilenOtel != null
                                ? "€${widget.secilenOtel!.otelFiyat.toString()}"
                                : "€${widget.secilenRestorant!.restoranFiyat}",
                            style: GoogleFonts.roboto(fontSize: 32, color: Colors.greenAccent.shade700, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: ekranGenisligi/2,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: Text(
                            "Book Now ->",
                            style: GoogleFonts.roboto(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),

    ]
      ),
    );
  }
}
