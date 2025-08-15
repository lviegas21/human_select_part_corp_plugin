import 'dart:ui';

class BodyPart {
  final String name;
  final Rect
      area; // Definindo a área de cada parte do corpo em coordenadas (x, y, largura, altura)

  BodyPart({required this.name, required this.area});
}

List<BodyPart> getBodyParts() {
  return [
    BodyPart(name: 'head', area: Rect.fromLTWH(100, 50, 150, 150)),
    BodyPart(name: 'torso', area: Rect.fromLTWH(120, 200, 100, 200)),
    // Adicione outras partes aqui
  ];
}
