import 'package:acudia/app_localizations.dart';
import 'package:acudia/components/list-items/data_item.dart';
import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HospitalAssignmentItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final Function onTap;
  final List<Assignment> items;
  int _current = 0;

  HospitalAssignmentItem({Key key, this.title, this.subtitle, this.items, this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HospitalAssignmentItemState();
  }
}

class HospitalAssignmentItemState extends State<HospitalAssignmentItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline3,
                )),
                SizedBox(height: 6),
                Text(
                    "${widget.items.length > 1 ? translate(context, 'num_assignments') : translate(context, 'num_assignment')}"
                        .replaceAll("{{num}}", widget.items.length.toString()),
                    style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor)),
                SizedBox(height: 32),
                CarouselSlider(
                  options: CarouselOptions(
                      height: 324,
                      viewportFraction: 0.9,
                      onPageChanged: (index, reason) {
                        setState(() {
                          widget._current = index;
                        });
                      }),
                  items: widget.items.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () => widget.onTap(item, widget.items.indexOf(item)),
                          child: Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              margin: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Column(children: [
                                AcudiaDataItem(label: "Fecha de cominezo", value: dateFormat.format(item.from)),
                                AcudiaDataItem(label: "Fecha de fin", value: dateFormat.format(item.to)),
                                AcudiaDataItem(
                                    label: "Horario",
                                    value:
                                        '${normalizeTime(item.startHour.hour)}:${normalizeTime(item.startHour.minute)} ${translate(context, "to")} ${normalizeTime(item.endHour.hour)}:${normalizeTime(item.endHour.minute)}'),
                                AcudiaDataItem(label: "Tarifa", value: "${item.fare} €/h"),
                                if (item.from.millisecondsSinceEpoch < new DateTime.now().millisecondsSinceEpoch)
                                  Container(
                                      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        color: Theme.of(context).highlightColor,
                                      )),
                                      child: Text(
                                        translate(context, 'active'),
                                        style: TextStyle(color: Theme.of(context).highlightColor),
                                      ))
                              ])),
                        );
                      },
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.items.map((url) {
                    int index = widget.items.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget._current == index ? Theme.of(context).primaryColor : Color.fromRGBO(0, 0, 0, 0.2),
                      ),
                    );
                  }).toList(),
                ),
              ]),
        ));
  }
}
