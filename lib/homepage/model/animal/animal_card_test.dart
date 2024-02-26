// import 'package:flutter/material.dart';
// import '../../../model/animal_model.dart';
// import 'edit_animal.dart';
//
// class BezierImageClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height - 50);
//     var controlPoint = Offset(50, size.height);
//     var endPoint = Offset(size.width / 2, size.height);
//     path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
//
// class AnimalCard extends StatelessWidget {
//   final AnimalModel animal;
//
//   const AnimalCard({Key? key, required this.animal}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Card(
//         elevation: 4,
//         margin: const EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(16),
//               child: Text(
//                 'Hayvan Bilgileri',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             ClipPath(
//               clipper: BezierImageClipper(),
//               child: Container(
//                 width: double.infinity,
//                 height: 200,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage('assets/images/sığır.jpg'), // Değişecek
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         showModalBottomSheet<void>(
//                           isScrollControlled: true, // Yukarı doğru kaydırma ve giriş animasyonu için
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AnimatedPadding(
//                               duration: const Duration(milliseconds: 300), // Animasyon süresi
//                               curve: Curves.easeOut, // Animasyon eğrisi
//                               padding: EdgeInsets.only(
//                                 bottom: MediaQuery.of(context).viewInsets.bottom,
//                               ),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     _buildBottomSheetItem(context, 'Yem Bilgileri'),
//                                     _buildBottomSheetItem(context, 'Tartım Bilgileri'),
//                                     _buildBottomSheetItem(context, 'Tedavi Bilgileri'),
//                                     _buildBottomSheetItem(context, 'Transfer Bilgileri'),
//                                     _buildBottomSheetItem(context, 'Maliyet Bilgileri'),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.green, // Butonun arka plan rengi
//                         onPrimary: Colors.white, // Buton metin rengi
//                         shape: RoundedRectangleBorder( // Butonun şekli ve kavisleri
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text('Bilgiler'),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Hayvan Türü: ${animal.animalTypeDescription ?? ''}',
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 12),
//                   //Text('Bölüm Açıklaması: ${animal.sectionDescription ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Bölüm ID: ${animal.sectionId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   Text('Küpe Numarası : ${animal.earringNumber.toString().split('.').last}'),
//                   const SizedBox(height: 12),
//                   Text('Giriş Tarihi: ${_formatDate(animal.farmInsertDate)}'),
//                   const SizedBox(height: 12),
//                   //Text('Cinsiyet: ${_formatGender(animal.animalGender)}'),
//                   //const SizedBox(height: 12),
//                   //Text('Doğum Tarihi: ${_formatDate(animal.birthDate)}'),
//                   //const SizedBox(height: 12),
//                   Text('Durum: ${animal.animalStatus.toString().split('.').last}'),
//                   const SizedBox(height: 12),
//                   //Text('Görsel: ${animal.image ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Hayvan Irkı ID: ${animal.animalRaceId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Hayvan Türü Açıklaması: ${animal.animalTypeDescription ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Hayvan Türü ID: ${animal.animalTypeId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('İzleme Kullanıcı: ${animal.trackingUser ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('İzleme Kullanıcı ID: ${animal.trackingUserId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   Text('Menşeii : ${animal.origin ?? ''}'),
//                   const SizedBox(height: 12),
//                   Text('Padok : ${animal.paddockDescription ?? ''}'),
//                   const SizedBox(height: 12),
//                   //Text('Padok ID: ${animal.paddockId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('RFID : ${animal.rfid ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Ölüm Tarihi: ${_formatDate(animal.exDate)}'),
//                   //const SizedBox(height: 12),
//                   //Text('Yapı Açıklaması: ${animal.buildDescription ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Yapı ID: ${animal.buildId ?? ''}'),
//                   //const SizedBox(height: 12),
//                   //Text('Bulaşıcı Hastalık : ${animal.isInfectious ?? false}'),
//                   //const SizedBox(height: 12),
//                   //Text('Takip Ediliyor : ${animal.isTracking ?? false}'),
//                   //const SizedBox(height: 12),
//
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               // Aşı uygula butonuna basıldığında yapılacak işlemler
//                             },
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.green, // Butonun arka plan rengi
//                               onPrimary: Colors.white, // Buton metin rengi
//                               shape: RoundedRectangleBorder( // Butonun şekli ve kavisleri
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: const Text('Aşı uygula'),
//                           ),
//                           const SizedBox(height: 8),
//                           ElevatedButton(
//                             onPressed: () {
//                               // İhbar et butonuna basıldığında yapılacak işlemler
//                             },
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.red, // Butonun arka plan rengi
//                               onPrimary: Colors.white, // Buton metin rengi
//                               shape: RoundedRectangleBorder( // Butonun şekli ve kavisleri
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: const Text('İhbar et'),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               // Tedavi başlat butonuna basıldığında yapılacak işlemler
//                             },
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.orange, // Butonun arka plan rengi
//                               onPrimary: Colors.white, // Buton metin rengi
//                               shape: RoundedRectangleBorder( // Butonun şekli ve kavisleri
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: const Text('Tedavi başlat'),
//                           ),
//                           const SizedBox(height: 8),
//                           ElevatedButton(
//                             onPressed: () {
//                               // Transfer et butonuna basıldığında yapılacak işlemler
//                             },
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.blue, // Butonun arka plan rengi
//                               onPrimary: Colors.white, // Buton metin rengi
//                               shape: RoundedRectangleBorder( // Butonun şekli ve kavisleri
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: const Text('Transfer et'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => EditAnimalPage(animal: animal,)),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.amber, // Butonun arka plan rengi
//                       onPrimary: Colors.white, // Buton metin rengi
//                       shape: RoundedRectangleBorder( // Butonun şekli ve kavisleri
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text('Düzenle'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomSheetItem(BuildContext context, String text) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ListTile(
//         title: Text(text),
//         onTap: () {
//           Navigator.pop(context); // Bottom sheet'i kapat
//           // İlgili işlemleri yap
//         },
//       ),
//     );
//   }
//
//   String _formatDate(DateTime? date) {
//     return date != null ? date.toString().split(' ')[0] : '';
//   }
//
//   String _formatGender(AnimalGender? gender) {
//     switch (gender) {
//       case AnimalGender.Male:
//         return 'Erkek';
//       case AnimalGender.Female:
//         return 'Dişi';
//       default:
//         return '';
//     }
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/animal_model.dart';
import 'edit_animal.dart';

class BezierImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var controlPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class AnimalCard extends StatefulWidget {
  final AnimalModel animal;

  const AnimalCard({Key? key, required this.animal}) : super(key: key);

  @override
  _AnimalCardState createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> with SingleTickerProviderStateMixin {
  File? _image;
  final picker = ImagePicker();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _image = null;
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipPath(
              clipper: BezierImageClipper(),
              child: Stack(
                children: [
                  _image == null
                      ? Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/sığır.jpg'),
                      ),
                    ),
                  )
                      : Image.file(
                    _image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: ElevatedButton(
                      onPressed: getImage,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        onPrimary: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditAnimalPage(animal: widget.animal)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber, // Butonun arka plan rengi
                        onPrimary: Colors.white, // Buton metin rengi
                        shape: RoundedRectangleBorder( // Butonun şekli ve kavisleri
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Düzenle'),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Hayvan Türü: ${widget.animal.animalTypeDescription ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Küpe Numarası : ${widget.animal.earringNumber.toString().split('.').last}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Giriş Tarihi: ${_formatDate(widget.animal.farmInsertDate)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Padok : ${widget.animal.paddockDescription ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Menşei : ${widget.animal.origin ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Durum: ${widget.animal.animalStatus.toString().split('.').last}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _showVaccineListBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Aşı uygula'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _showTreatmentOptionsBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Tedavi başlat'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _showNotifyBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('İhbar et'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _showTransferBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text('Transfer et'),
                  ),
                  const SizedBox(height: 16),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Maliyet'),
                      Tab(text: 'Yem'),
                      Tab(text: 'Tartım'),
                      Tab(text: 'Tedavi'),
                      Tab(text: 'Transfer'),
                    ],
                    labelColor: Colors.white, // Seçili sekmenin metin rengi
                    unselectedLabelColor: Colors.black87, // Seçilmemiş sekmenin metin rengi
                    indicator: BoxDecoration( // Aktif sekmenin altındaki gösterge
                      color: Colors.blue, // Gösterge rengi
                      borderRadius: BorderRadius.circular(50), // Gösterge kenar yuvarlaklığı
                    ),
                    labelPadding: EdgeInsets.symmetric(horizontal: 20), // Başlık içeriği ile kenar arasındaki boşluk
                    isScrollable: true, // Sekmelerin kaydırılabilir olması
                    labelStyle: const TextStyle(fontSize: 14), // Başlık metni stilini ayarla
                  ),
                  SizedBox(
                    height: 200, // TabBarView yüksekliği
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Maliyet sekmesi içeriği
                        Container(
                          alignment: Alignment.center,
                          child: Text('Maliyet Bilgileri'),
                        ),
                        // Yem sekmesi içeriği
                        Container(
                          alignment: Alignment.center,
                          child: Text('Yem Bilgileri'),
                        ),
                        // Tartım sekmesi içeriği
                        Container(
                          alignment: Alignment.center,
                          child: Text('Tartım Bilgileri'),
                        ),
                        // Tedavi sekmesi içeriği
                        Container(
                          alignment: Alignment.center,
                          child: Text('Tedavi Bilgileri'),
                        ),
                        // Transfer sekmesi içeriği
                        Container(
                          alignment: Alignment.center,
                          child: Text('Transfer Bilgileri'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showVaccineListBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Aşı Listesi'),
              // Buraya aşı listesinin görüntülendiği widgetler eklenebilir
            ],
          ),
        );
      },
    );
  }

  void _showTreatmentOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Tedavi Seçenekleri'),
              // Buraya tedavi seçeneklerinin görüntülendiği widgetler eklenebilir
            ],
          ),
        );
      },
    );
  }

  void _showNotifyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              // İhbar et işlemi gerçekleştirilebilir
              Navigator.pop(context); // Bottom sheet'i kapat
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            child: const Text('İhbar Et'),
          ),
        );
      },
    );
  }

  void _showTransferBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Transfer Et'),
              // Buraya padok numaralarının listelendiği widgetler eklenecek
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime? date) {
    return date != null ? date.toString().split(' ')[0] : '';
  }
}
