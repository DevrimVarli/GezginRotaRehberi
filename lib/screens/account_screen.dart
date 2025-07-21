import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yeni_tasarim/model/hesap_kategori.dart';
import 'package:yeni_tasarim/providers/all_providers.dart';
import 'package:yeni_tasarim/screens/profile_screen.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final hesapKategori=ref.watch(hesapKategoriProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Açık mavi arka plan
      appBar: AppBar(
        title: Text("Hesabım", style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: user == null
          ? Center(child: Text("Kullanıcı bilgisi bulunamadı."))
          :Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Merhaba",style: TextStyle(color: Colors.grey.shade800,fontSize: 20,fontWeight: FontWeight.w500),),
                      SizedBox(width: 10,),
                      Text(user.displayName ?? "",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                  itemCount: hesapKategori.length,
                  itemBuilder: (context,index){
                    HesapKategori kategori=hesapKategori[index];
                    return GestureDetector(
                      onTap:() {
                        if(kategori.kategori_ad=="Çıkış Yap"){
                          FirebaseAuth.instance.signOut();
                        }else if(kategori.kategori_ad=="Profilim"){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                        }

                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.zero,
                          color: Colors.white,
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(kategori.kategori_icon.icon,color: Colors.grey.shade700,),
                              SizedBox(width: 10,),
                              Text(kategori.kategori_ad,style: TextStyle(color: Colors.grey.shade700,fontSize: 20,fontWeight: FontWeight.w500),),
                              Spacer(),
                              IconButton(onPressed: (){
                                if(kategori.kategori_ad=="Çıkış Yap"){
                                  FirebaseAuth.instance.signOut();
                                }
                              },
                              icon:Icon(Icons.arrow_forward_ios,color: Colors.grey.shade700,size: 18,)
                              )

                            ],
                          ),
                        ) ,
                      ),
                    );

                  }),
                ),
              ],
            ),
          )
    );
  }

  // Kart oluşturucu fonksiyon
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      color: Colors.blue[100],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[800]),
        title: Text(title, style: TextStyle(color: Colors.blue[900])),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.blue[700])),
      ),
    );
  }
}
