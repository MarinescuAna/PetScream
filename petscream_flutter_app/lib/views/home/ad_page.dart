import 'package:flutter/material.dart';
import 'package:petscream_flutter_app/locator/locator.dart';
import 'package:petscream_flutter_app/models/ad_rec_model.dart';
import 'package:petscream_flutter_app/models/login_model.dart';
import 'package:petscream_flutter_app/services/ad_service.dart';
import 'package:petscream_flutter_app/services/user_service.dart';
import 'package:petscream_flutter_app/singleton/singleton_keeper.dart';
import 'package:petscream_flutter_app/toast/toaster.dart';
import 'package:petscream_flutter_app/views/home/found_page.dart';
import 'package:petscream_flutter_app/views/home/home.dart';
import 'package:petscream_flutter_app/views/home/image.dart';

class AdPage extends StatefulWidget {
  AdRecModel model;

  AdPage(this.model);

  @override
  _AdPage createState() => _AdPage(this.model);
}

class _AdPage extends State<AdPage> {
  AdRecModel model;
  AdService _adService = locator<AdService>();
  Future<String> myFuture;

  _AdPage(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Row(
          children: [Text("PetScream", style: TextStyle(color: Colors.white))],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          children: <Widget>[
            headerSelection(),
            Container(child: new ShowImage(model.contentImage)),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: _showRow("Status", model.status)),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: textSelection()),
            _showFounder(),
            SizedBox(
              height: 30,
            ),
            _showButtons(),
            _showDeleteButton(),
            _showFoundButton(),
            _Back()
          ],
        ),
      ),
    );
  }

  Column textSelection() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          model.petDescription == null
              ? _showMessage("The description is missing!")
              : _showRow("Description", model.petDescription),
          model.lostDatetime == null
              ? _showMessage("The date when the pet was lose is missing!")
              : _showRow(
                  "The date when the pet was lost",
                  model.lostDatetime.split('T')[0] +
                      ' ' +
                      model.lostDatetime.split('T')[1].split('.')[0]),
          model.lostPlaceAddress == null
              ? _showMessage("The place where the pet was lose is missing!")
              : _showRow(
                  "The aria where the pet can be", model.lostPlaceAddress),
          model.name == null
              ? _showMessage("The owner's name is missing!")
              : _showRow("Owner name", model.name),
          model.ownerAddress == null
              ? _showMessage("The owner's address is missing!")
              : _showRow("Owner address", model.ownerAddress),
          model.phone == null
              ? _showMessage("The owner's phone number is missing!")
              : _showRow("Owner phone number", model.phone),
          model.userEmail == null
              ? _showMessage("The owner's email is missing!")
              : _showRow("Owner email", model.userEmail),
        ]);
  }

  Container _showRow(String tag, String value) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tag + " : ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(value, textAlign: TextAlign.left)
          ],
        ));
  }

  Widget _showFounder() {
    return Visibility(
        visible: SingletonKeeper.IsLogged() &&
            model.founderName != null &&
            SingletonKeeper.GetEmail() == model.userEmail,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            _showMessageGreen("Founder name",
                model.founderName == null ? "" : model.founderName),
            _showMessageGreen("Founder address",
                model.founderAddress == null ? "" : model.founderAddress),
            _showMessageGreen(
                "The date when was found",
                model.foundDatetime != null
                    ? model.foundDatetime.split('T')[0] +
                        ' ' +
                        model.foundDatetime.split('T')[1].split('.')[0]
                    : ""),
            _showMessageGreen("Founder phone number",
                model.founderPhone == null ? "" : model.founderPhone)
          ],
        ));
  }

  Widget _showDeleteButton() {
    return Visibility(
        visible: SingletonKeeper.IsLogged() &&
            SingletonKeeper.GetEmail() == model.userEmail,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.red.shade400),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            ),
            child: Text("Delete",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          onPressed: () {
            setState(() {
              myFuture =
                  _adService.DeletePost(model.postID).then((value) async {
                    if (value == "Success") {
                      ShowToastComponent.showDialogSuccess("Success!", context);
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                    } else {
                      ShowToastComponent.showDialogError(value, context);
                    }
                  });
            });
          },
          ));
  }

  Widget _showButtons() {
    return Visibility(
        visible: SingletonKeeper.IsLogged() &&
            model.status == "Lost" &&
            model.founderName!=null &&
            SingletonKeeper.GetEmail() == model.userEmail,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
          ),
          child: Text("Mark as found",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          onPressed: () {
            setState(() {
              myFuture =
                  _adService.MarkAsFound(model.postID).then((value) async {
                if (value == "Success") {
                  ShowToastComponent.showDialogSuccess("Success!", context);
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()));
                } else {
                  ShowToastComponent.showDialogError(value, context);
                }
              });
            });
          },
        ));
  }

  Widget _showFoundButton() {
    return Visibility(
        visible: model.status == "Lost" &&
            SingletonKeeper.GetEmail() != model.userEmail,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            child: Text("I found the pet",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Found(model.postID)));
            }));
  }

  Widget _Back() {
    return Container(
        width: 0.005,
        height: 50.0,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black)),
            child: Text("Back",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
            }));
  }

  Text _showMessage(String message) {
    return Text(message, style: TextStyle(color: Colors.red));
  }

  Row _showMessageGreen(String tag, String message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tag + " : ",
          overflow: TextOverflow.clip,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
        Text(
          message,
          style: TextStyle(color: Colors.green),
        )
      ],
    );
  }

  Center headerSelection() {
    return Center(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Text(
        model.title.toUpperCase(),
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
