import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart' as wheel;
import 'package:circularlist/chracter.dart';
import 'package:circularlist/result.dart';
import 'package:flutter/material.dart';

class CircularListPage extends StatefulWidget {
  @override
  _CircularListPageState createState() => _CircularListPageState();
}

class _CircularListPageState extends State<CircularListPage> {
  wheel.FixedExtentScrollController _controller;

  _listListener() {
    setState(() {});
  }

  @override
  void initState() {
    _controller = wheel.FixedExtentScrollController();
    _controller.addListener(_listListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listListener);
    _controller.dispose();
    super.dispose();
  }

  int indexOfItem = 0;
  double itemExtent = 120;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F6FE0),
      appBar: AppBar(
        title: Text("Circular List"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          wheel.CircleListScrollView.useDelegate(
            onSelectedItemChanged: (index) {
              indexOfItem = index;
            },
            childDelegate: wheel.CircleListChildBuilderDelegate(
              builder: (context, index) {
                int currentIndex = 0;
                try {
                  currentIndex = _controller.selectedItem;
                } catch (_) {}
                final resizeFactor = (1 -
                    (((currentIndex - index).abs() * 0.3).clamp(0.0, 1.0)));
                return CircleListItem(
                  resizeFactor: resizeFactor,
                  character: characters[index],
                );
              },
              childCount: characters.length,
            ),
            physics: wheel.CircleFixedExtentScrollPhysics(),
            controller: _controller,
            axis: Axis.vertical,
            itemExtent: itemExtent,
            radius: MediaQuery.of(context).size.width * 0.8,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Result(index: indexOfItem), // the next page
                ),
              );
            },
            child: SizedBox(
              height: itemExtent,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleListItem extends StatelessWidget {
  final double resizeFactor;
  final Character character;

  const CircleListItem({Key key, this.resizeFactor, this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              character.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22 * resizeFactor,
              ),
            ),
          ),
          Container(
            width: 120 * resizeFactor,
            height: 120 * resizeFactor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
