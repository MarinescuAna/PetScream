import 'package:flutter/material.dart';
import 'package:petscream_flutter_app/models/ad_rec_model.dart';
import 'package:petscream_flutter_app/services/ad_service.dart';
import 'package:petscream_flutter_app/locator/locator.dart';
import 'package:petscream_flutter_app/views/home/ad.dart';

class Ads extends StatelessWidget {
  final AdService _adService = locator<AdService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0.0),
        child: FutureBuilder<List<AdRecModel>>(
            future: _adService.getAds(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return snapshot.data == null
                        ? null
                        : Card(
                            color: Colors.grey.shade200,
                            child: ListTile(
                              title: Ad(snapshot.data[index]),
                            ));
                  },
                );
              } else {
                if (snapshot.hasError) {
                  return AlertDialog(title: Text(snapshot.error.toString()));
                }
              }
              return Center(
                  child: Container(
                      color: Colors.grey,
                      height: 30.0,
                      width: 150.0,
                      child: Text(
                        "Please wait....",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )));
            }));
  }
}
