import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/qrcode/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class QRPage extends StatefulWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  QRBloc _qrBloc = QRBloc();
  @override
  void initState() {
    _qrBloc.add(FetchQRStarted());
    super.initState();
  }

  Future<String> _createFileFromString({required String img}) async {
    final encodedStr = img;
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpg");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  _decodImage(String img) {
    Uint8List? _bytes;
    _bytes = Base64Decoder().convert(img);
    print(img);
    print(_bytes);
    return _bytes;
  }
  _decodeBytesImage()async{
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "QR page"),
      body: BlocBuilder(
          bloc: _qrBloc,
          builder: (context, state) {
            if (state is ErrorFetchingQR) {
              return Center(
                child: Text(state.error.toString()),
              );
            }
            if (state is FetchedQR) {
             
              return Container(
                child: Column(
                  children: [
                    Image.memory(_decodImage(state.img)),
                    // Container(
                    //   width: 100,
                    //   height: 40,
                    //   child: RaisedButton(
                    //       color: Colors.green,
                    //       child: Text("Download"),
                    //       onPressed: () async{
                    //         await Share.shareFiles(_decodImage(state.img));
                    //       //  File decodedimgfile = await File("image.jpg").writeAsBytes(_decodImage(state.img));
                    //       //  print(decodedimgfile);
                    //       }),
                    // ),
                  ],
                ),
              );
            }
            return Center(
              // child: CircularProgressIndicator(),
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          }),
    );
  }
}
