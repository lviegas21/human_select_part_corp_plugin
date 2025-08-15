import 'package:flutter/material.dart';
import 'package:human_select_part_corp/ui/body_part_interactive.dart';

class HumanSelectPartCorp extends StatefulWidget {
  @override
  _BodyPartSelectorState createState() => _BodyPartSelectorState();
}

class _BodyPartSelectorState extends State<HumanSelectPartCorp> {
  String currentImage =
      'packages/human_select_part_corp/assets/bitmap_front.svg'; // Caminho inicial

  void changeImage(String newImage) {
    setState(() {
      currentImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calcula altura disponível para o SVG
        final availableHeight =
            constraints.maxHeight * 0.7; // 70% da altura disponível

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Usa uma altura adaptável
            Expanded(
              child: BodyPartInteractive(svgAssetPath: currentImage),
            ),
            Wrap(
              spacing: 2.0,
              runSpacing: 2.0,
              alignment: WrapAlignment.center,
              children: [
                TextButton(
                    onPressed: () => changeImage(
                        'packages/human_select_part_corp/assets/bitmap_front.svg'),
                    child: Text('Frente')),
                TextButton(
                    onPressed: () => changeImage(
                        'packages/human_select_part_corp/assets/bitmap_back.svg'),
                    child: Text('Costa')),
                TextButton(
                    onPressed: () => changeImage(
                        'packages/human_select_part_corp/assets/bitmap_right.svg'),
                    child: Text('Lado Direito')),
                TextButton(
                    onPressed: () => changeImage(
                        'packages/human_select_part_corp/assets/bitmap_left.svg'),
                    child: Text('Lado Esquerdo')),
              ],
            ),
          ],
        );
      },
    );
  }
}
