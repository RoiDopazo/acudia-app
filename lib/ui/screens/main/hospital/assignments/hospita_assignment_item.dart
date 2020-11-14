import 'package:acudia/app_localizations.dart';
import 'package:acudia/colors.dart';
import 'package:acudia/components/list-items/date_range_item.dart';
import 'package:acudia/core/entity/assignment_entity.dart';
import 'package:acudia/utils/helpers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';

// ignore: must_be_immutable
class HospitalAssignmentItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final Function onTap;
  final List<Assignment> items;
  int _current = 0;

  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
  HospitalAssignmentItem({Key key, this.title, this.subtitle, this.items, this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HospitalAssignmentItemState();
  }
}

class HospitalAssignmentItemState extends State<HospitalAssignmentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SimpleFoldingCell.create(
        key: widget._foldingCellKey,
        frontWidget: _buildFrontWidget(context),
        innerWidget: _buildInnerWidget(context, widget._current),
        cellSize: Size(MediaQuery.of(context).size.width, 180),
        padding: EdgeInsets.all(15),
        animationDuration: Duration(milliseconds: 300),
        borderRadius: 10,
      ),
    );
  }

  Widget _buildFrontWidget(context) {
    return GestureDetector(
        onTap: () => widget._foldingCellKey?.currentState?.toggleFold(),
        child: Container(
          color: aCPaletteAccent.shade100,
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.title,
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Text(
                        "Ver más",
                        style: TextStyle(color: aCWhite),
                      )),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildInnerWidget(context, value) {
    return Container(
      color: Color(0xFFecf2f9),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          GestureDetector(
              onTap: () => widget._foldingCellKey?.currentState?.toggleFold(),
              child: Container(
                color: aCPalette.shade600,
                width: MediaQuery.of(context).size.width,
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.title,
                        style: TextStyle(
                            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(
                      '${widget.items.length > 1 ? translate(context, 'num_assignments') : translate(context, 'num_assigment')}'
                          .replaceAll("{{num}}", widget.items.length.toString()),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              )),
          Column(children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 152.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      widget._current = index;
                    });
                  }),
              items: widget.items.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: aCPalette.shade100),
                        child: AcudiaDateRangeItem(
                            backgroundColor: aCPalette.shade50,
                            from: i.from,
                            to: i.to,
                            onTap: () {
                              widget.onTap(i, widget.items.indexOf(i));
                            },
                            children: [
                              Row(children: [
                                Icon(Icons.timer, size: 18),
                                SizedBox(width: 16),
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Column(children: [
                                        Text(
                                            '${normalizeTime(i.startHour.hour)}:${normalizeTime(i.startHour.minute)}',
                                            style: TextStyle(fontSize: 18)),
                                        SizedBox(width: 4),
                                        Text(translate(context, "to"),
                                            style: TextStyle(fontSize: 12)),
                                        SizedBox(width: 4),
                                        Text(
                                            '${normalizeTime(i.endHour.hour)}:${normalizeTime(i.endHour.minute)}',
                                            style: TextStyle(fontSize: 18))
                                      ])
                                    ]),
                              ]),
                              SizedBox(height: 16),
                              Row(children: [
                                Icon(Icons.attach_money, size: 18),
                                SizedBox(width: 16),
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text('${i.fare}', style: TextStyle(fontSize: 22)),
                                      SizedBox(width: 4),
                                      Text('€/h', style: TextStyle(fontSize: 12))
                                    ]),
                              ]),
                            ]));
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
                    color: value == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
          ])
        ],
      ),
    );
  }
}
