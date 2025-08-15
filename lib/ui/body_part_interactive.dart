import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BodyPartInteractive extends StatefulWidget {
  final String svgAssetPath;
  const BodyPartInteractive({Key? key, required this.svgAssetPath})
      : super(key: key);

  @override
  _BodyPartInteractiveState createState() => _BodyPartInteractiveState();
}

class _BodyPartInteractiveState extends State<BodyPartInteractive> {
  List<Offset> contactPoints = []; // Lista de pontos onde o usuário clicou
  String? svgData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  @override
  void didUpdateWidget(BodyPartInteractive oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.svgAssetPath != widget.svgAssetPath) {
      _loadSvg();
    }
  }

  Future<void> _loadSvg() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      print('Tentando carregar SVG via rootBundle: ${widget.svgAssetPath}');
      final data = await rootBundle.loadString(widget.svgAssetPath);
      setState(() {
        svgData = data;
        isLoading = false;
      });
      print('SVG carregado com sucesso: ${data.length} bytes');
    } catch (e) {
      print('Erro ao carregar SVG via rootBundle: $e');
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          contactPoints.add(details.localPosition);
        });
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (errorMessage != null)
            Container(
              color: Colors.red[100],
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        'Erro ao carregar SVG: ${widget.svgAssetPath}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else if (svgData != null)
            SvgPicture.string(
              svgData!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ...contactPoints.map((point) => Positioned(
                left: point.dx - 5,
                top: point.dy - 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
