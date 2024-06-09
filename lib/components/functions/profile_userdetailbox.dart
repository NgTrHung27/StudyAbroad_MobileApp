import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';

// ignore: must_be_immutable
class LegendBox extends StatefulWidget {
  final String title;
  String value;
  final bool isEditable;
  final Color color;

  LegendBox({
    super.key,
    required this.title,
    required this.value,
    this.isEditable = false,
    this.color = Colors.white,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LegendBoxState createState() => _LegendBoxState();
}

class _LegendBoxState extends State<LegendBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            height: 65.0,
            constraints: const BoxConstraints(minWidth: double.infinity),
            padding: const EdgeInsets.only(top: 12.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextMonserats(
                    widget.value,
                    color: widget.value == 'APPROVED'
                        ? Colors.green
                        : widget.value == 'DENIED'
                            ? Colors.red
                            : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 15.0,
            child: Container(
              color: widget.color,
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: TextMonserats(
                widget.title,
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (widget.isEditable)
            Positioned(
              top: 15.0,
              right: 15.0,
              child: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final TextEditingController controller =
                      TextEditingController(text: widget.value);
                  final newValue = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Edit ${widget.title}'),
                      content: TextField(
                        controller: controller,
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Save'),
                          onPressed: () {
                            Navigator.of(context).pop(controller.text);
                          },
                        ),
                      ],
                    ),
                  );
                  if (newValue != null) {
                    setState(() {
                      widget.value = newValue;
                    });
                    // Call API to save the new value
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
