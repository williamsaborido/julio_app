import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:julio_app/services/sharing.dart';
import 'package:julio_app/services/pdf_service.dart';

class ImpressaoView extends StatefulWidget {
  const ImpressaoView({super.key});

  @override
  State<ImpressaoView> createState() => _ImpressaoViewState();
}

class _ImpressaoViewState extends State<ImpressaoView> {
  final GlobalKey _printKey = GlobalKey();
  bool _isSharing = false;
  late final PdfService _pdfService;
  late final SharingService _sharingService;

  @override
  void initState() {
    super.initState();
    _pdfService = context.read<PdfService>();
    _sharingService = context.read<SharingService>();
  }

  Future<void> _sharePdf() async {
    setState(() => _isSharing = true);
    
    try {
      final bytes = await _pdfService.captureWidgetToPdf(_printKey);
      await _sharingService.shareBytes(bytes, 'relatorio_julio_app.pdf');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao gerar ou compartilhar PDF: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('Impressão de Relatório'),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView(
            child: RepaintBoundary(
              key: _printKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.print, size: 100, color: Colors.grey),
                    SizedBox(height: 20),
                    Text(
                      'Simulação de visualização de impressão',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        'Esta tela agora permite capturar seu conteúdo e transformá-lo em um PDF para compartilhamento.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _isSharing ? null : _sharePdf,
            child: _isSharing 
              ? const CircularProgressIndicator(color: Colors.white)
              : const Icon(Icons.share),
          ),
        );
  }
}
