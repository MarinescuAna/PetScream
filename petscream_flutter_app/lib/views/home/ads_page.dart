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
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),

        child: FutureBuilder<List<AdRecModel>>(
            future: _adService.getAds(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  {
                    return AlertDialog(title: Text("No internet connection!"));
                  }
                case ConnectionState.waiting:
                  {
                    return Container(
                        color: Colors.white,
                        height: 60.0,
                        width: 60.0,
                        child: Center(child: CircularProgressIndicator()));
                  }
                case ConnectionState.done:
                  {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount:
                            snapshot.data == null ? 0 : snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return snapshot.data == null ? null:Card(
                            color: Colors.grey.shade200,
                              child: ListTile(
                            title: Ad(snapshot.data[index]),
                          ));
                        },
                      );
                    } else {
                      if (snapshot.hasError) {
                        return AlertDialog(
                            title: Text(snapshot.error.toString()));
                      }
                    }
                    break;
                  }
                case ConnectionState.active:
                  {
                    return AlertDialog(
                      title: Text("Connection is active?!"),
                    );
                  }
              }
              return Container(
                  color: Colors.white,
                  height: 60.0,
                  width: 60.0,
                  child: Center(child: CircularProgressIndicator()));
            }));
  }
}
