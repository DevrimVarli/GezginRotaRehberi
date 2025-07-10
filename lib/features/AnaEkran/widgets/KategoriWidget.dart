import 'package:flutter/material.dart';
class KategoriWidget extends StatefulWidget {
  List<String>basliklar;
  int selectedIndex;
  final Function(int) onCategorySelected;
  KategoriWidget(this.basliklar,this.selectedIndex,this.onCategorySelected);

  @override
  State<KategoriWidget> createState() => _KategoriWidgetState();
}
//KATEGORİLERİ GÖSTERİLİYOR
class _KategoriWidgetState extends State<KategoriWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.basliklar.length,
        itemBuilder: (context, index) {
          final isSelected = widget.selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                   widget.selectedIndex = index;
                });
                widget.onCategorySelected(index);
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFFE8F0FE) : Colors.transparent,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  widget.basliklar[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: isSelected ? Colors.blue : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
