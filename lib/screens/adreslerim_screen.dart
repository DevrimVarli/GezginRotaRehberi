import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:yeni_tasarim/model/Konum.dart';
import 'package:yeni_tasarim/model/kullanici_konum_freezed.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/adres_ekleme_screen.dart';
import 'package:yeni_tasarim/screens/location_screen.dart';

class AdresScreen extends ConsumerWidget {

const AdresScreen({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
     Box<KullaniciKonumFreezed> box=Hive.box<KullaniciKonumFreezed>('konumlar');
    List<KullaniciKonumFreezed> konumlar=box.values.toList();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Teslimat Adresi',style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),),
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        leading:IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: colorScheme.onSurface,)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Düzenle butonuna basarak konumunu ve adres bilgilerini düzenleyebilir veya adresini silebilirsin',style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface), ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                  ),
                    onPressed: (){},
                    label:const Text('Mevcut Konumu Kullan',style: TextStyle(color: Colors.white),),
                    icon: const Icon(Icons.zoom_in_map,color: Colors.white,), ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                  ),
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute<Widget>(builder: (BuildContext context)=>const KonumSecPage()));
                  },
                  label: const Text('Yeni Konum Seç',style: TextStyle(color: Colors.white),),
                  icon: const Icon(Icons.location_on,color: Colors.white,),
                ),
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: konumlar.length,
                    itemBuilder:(BuildContext context,int indeks){
                      KullaniciKonumFreezed konum=konumlar[indeks];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                          onTap: (){
                            ref.read(secilemKonumStateProvider.notifier).state=Konum(konum.sehirAdi, konum.ilceAdi) ;
                            Navigator.pop(context);
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: colorScheme.surface,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text(konum.adresBasligi,style: textTheme.titleLarge,),
                                    const Spacer(),
                                    TextButton(
                                        onPressed: (){
                                          Navigator.pushReplacement(context, MaterialPageRoute<Widget>(builder: (BuildContext context)=>AdresScreenDetay(kullaniciKonum: konum,)));

                                          //Navigator.push(context, MaterialPageRoute<Widget>(builder: (context)=>AdresScreenDetay()));
                                        },
                                        child: const Row(
                                          children: <Widget>[
                                            Icon(Icons.edit),
                                            Text('Düzenle'),
                                          ],
                                        ),

                                     ),
                                  ],),
                                  Text('${konum.mahalleAdi} Mah / ${konum.sehirAdi} / ${konum.ilceAdi}',style: textTheme.titleMedium,),
                                  Text('${konum.mahalleAdi} Mah / ${konum.sokakAdi} Sokak ',style: textTheme.titleSmall?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.8),),),
                                  Text('Bina No:${konum.binaNo}  / Kat:${konum.katNo} / Daire: ${konum.daireNo} ',style: textTheme.titleSmall,),
                                  Text(konum.cepTelefonu,style: textTheme.titleSmall,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
