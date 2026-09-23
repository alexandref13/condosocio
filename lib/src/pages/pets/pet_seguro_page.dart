import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/pets_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

const _termoPetSeguroUrl = 'https://condosocio.com.br/termo-pet-seguro.html';

// Public Key de PRODUÇÃO — app condosocioPagamentos, conta PJ ALVO COMUNICACAO
// LTDA (App ID 7568171194552744). Precisa ser do mesmo par do Access Token
// usado no backend (pet_seguro_assinar.php).
const _mpPublicKey = 'APP_USR-699e00c0-f7ba-41ef-b36e-55e21f1a9e87';

class PetSeguroPage extends StatefulWidget {
  final String idpet;

  const PetSeguroPage({super.key, required this.idpet});

  @override
  State<PetSeguroPage> createState() => _PetSeguroPageState();
}

class _PetSeguroPageState extends State<PetSeguroPage> {
  final _formKey = GlobalKey<FormState>();

  // campos cartão
  final _cardNumberCtrl = TextEditingController();
  final _holderNameCtrl = TextEditingController();
  final _expiryMonthCtrl = TextEditingController();
  final _expiryYearCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();

  // campos comuns
  final _emailCtrl = TextEditingController();
  final _docCtrl = TextEditingController();

  // campo exclusivo do pix (cartão usa _holderNameCtrl como nome do pagador)
  final _payerNameCtrl = TextEditingController();

  String _paymentMethod = 'cartao'; // 'cartao' | 'pix'
  int _installments = 1;

  bool _loading = false;
  String? _errorMsg;
  bool _aceitouTermos = false;

  // estado de sucesso
  bool _cardSuccess = false;
  bool _pixPending = false;
  bool _pixConfirmed = false;
  String? _pixQrCode;
  String? _pixQrCodeBase64;
  Timer? _pixPollTimer;

  // taxas (petseguro_taxas)
  bool _loadingTaxas = true;
  String? _taxasError;
  bool _taxasIndisponivel = false;
  double _valor = 0;
  double _valorPix = 0;
  int _maxParcelas = 1;

  bool get _pixTemDesconto => _valorPix < _valor;

  @override
  void initState() {
    super.initState();
    _loadTaxas();
  }

  Future<void> _loadTaxas() async {
    setState(() {
      _loadingTaxas = true;
      _taxasError = null;
      _taxasIndisponivel = false;
    });

    try {
      final idcond = Get.find<LoginController>().idcond.value;
      final resp = await http.get(
        Uri.parse(
            'https://www.condosocio.com.br/flutter/pet_seguro_taxas.php?idcond=$idcond'),
      );

      if (resp.statusCode == 409) {
        final data = jsonDecode(resp.body);
        setState(() {
          _taxasIndisponivel = true;
          _taxasError = data['error'] ??
              'A aquisição da assinatura do pet seguro está indisponível no momento.';
          _loadingTaxas = false;
        });
        return;
      }

      if (resp.statusCode != 200) {
        throw Exception('status ${resp.statusCode}');
      }

      final data = jsonDecode(resp.body);
      final valor = double.tryParse(data['valor'].toString());
      final valorPix = double.tryParse(data['valor_pix'].toString());
      final maxParcelas = int.tryParse(data['max_parcelas'].toString());

      if (valor == null || valor <= 0 || maxParcelas == null || maxParcelas < 1) {
        throw Exception('dados inválidos');
      }

      setState(() {
        _valor = valor;
        _valorPix = valorPix ?? valor;
        _maxParcelas = maxParcelas;
        _installments = 1;
        _loadingTaxas = false;
      });
    } catch (_) {
      setState(() {
        _taxasError =
            'Não foi possível carregar o valor da assinatura. Tente novamente.';
        _loadingTaxas = false;
      });
    }
  }

  @override
  void dispose() {
    _pixPollTimer?.cancel();
    _cardNumberCtrl.dispose();
    _holderNameCtrl.dispose();
    _expiryMonthCtrl.dispose();
    _expiryYearCtrl.dispose();
    _cvvCtrl.dispose();
    _emailCtrl.dispose();
    _docCtrl.dispose();
    _payerNameCtrl.dispose();
    super.dispose();
  }

  Color get _primary => Theme.of(context).primaryColor;
  Color get _textColor =>
      Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

  // ── Detecta bandeira ────────────────────────────────────────────────────────
  String _detectCardBrand(String digits) {
    if (digits.startsWith('4')) return 'visa';
    final n =
        int.tryParse(digits.length >= 4 ? digits.substring(0, 4) : digits) ?? 0;
    final n2 =
        int.tryParse(digits.length >= 2 ? digits.substring(0, 2) : digits) ?? 0;
    if ((n2 >= 51 && n2 <= 55) || (n >= 2221 && n <= 2720)) return 'master';
    if (n2 == 34 || n2 == 37) return 'amex';
    if (n2 == 36 || n2 == 38 || (n2 >= 30 && n2 <= 35)) return 'diners';
    if (digits.startsWith('606282') || digits.startsWith('3841'))
      return 'hipercard';
    const eloPrefixes = [
      '401178',
      '401179',
      '431274',
      '438935',
      '451416',
      '457393',
      '457631',
      '457632',
      '504175',
      '627780',
      '636297',
      '636368'
    ];
    final bin6 = digits.length >= 6 ? digits.substring(0, 6) : '';
    if (eloPrefixes.contains(bin6)) return 'elo';
    return 'master';
  }

  // ── Pagamento via Cartão ────────────────────────────────────────────────────
  Future<void> _subscribeCard() async {
    setState(() {
      _loading = true;
      _errorMsg = null;
    });

    try {
      // 1. Tokeniza o cartão
      final tokenResp = await http.post(
        Uri.parse(
            'https://api.mercadopago.com/v1/card_tokens?public_key=$_mpPublicKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'card_number': _cardNumberCtrl.text.replaceAll(' ', ''),
          'expiration_month': int.parse(_expiryMonthCtrl.text.trim()),
          'expiration_year': int.parse(_expiryYearCtrl.text.trim()),
          'security_code': _cvvCtrl.text.trim(),
          'cardholder': {
            'name': _holderNameCtrl.text.trim(),
            'identification': {
              'type': 'CPF',
              'number': _docCtrl.text.replaceAll(RegExp(r'[.\-]'), ''),
            },
          },
        }),
      );

      if (kDebugMode) {
        debugPrint(
            '[PetSeguro] card_tokens status=${tokenResp.statusCode} body=${tokenResp.body}');
      }

      if (tokenResp.statusCode != 200 && tokenResp.statusCode != 201) {
        setState(() {
          _errorMsg = _mapTokenError(tokenResp.body);
          _loading = false;
        });
        return;
      }

      final cardToken = (jsonDecode(tokenResp.body)['id'] as String);
      final brand = _detectCardBrand(_cardNumberCtrl.text.replaceAll(' ', ''));
      if (kDebugMode) {
        debugPrint('[PetSeguro] bandeira detectada localmente: $brand');
      }

      // 2. Envia ao backend
      final resp = await http.post(
        Uri.parse(
            'https://www.condosocio.com.br/flutter/pet_seguro_assinar.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': cardToken,
          'email': _emailCtrl.text.trim(),
          'cpf': _docCtrl.text.replaceAll(RegExp(r'[.\-]'), ''),
          'amount': _valor.toStringAsFixed(2),
          'payment_method_id': brand,
          'installments': _installments,
          'payer_first_name': _holderNameCtrl.text.trim(),
          'idusu': Get.find<LoginController>().id.value,
          'idpet': widget.idpet,
          'idcond': Get.find<LoginController>().idcond.value,
        }),
      );

      final data = jsonDecode(resp.body);
      if (kDebugMode) {
        debugPrint(
            '[PetSeguro] pet_seguro_assinar.php status=${resp.statusCode} body=${resp.body}');
        if (data['debug'] != null) {
          debugPrint('[PetSeguro] debug MP: ${jsonEncode(data['debug'])}');
        }
      }
      if (resp.statusCode == 200 && data['status'] == 'processed') {
        setState(() {
          _cardSuccess = true;
          _loading = false;
        });
        _refreshPetsList();
      } else {
        setState(() {
          _errorMsg =
              'Pagamento não aprovado: ${data['status_detail'] ?? 'Tente novamente.'}';
          _loading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) debugPrint('[PetSeguro] exceção no fluxo de cartão: $e');
      setState(() {
        _errorMsg =
            'Erro de conexão. Verifique sua internet e tente novamente.';
        _loading = false;
      });
    }
  }

  // ── Pagamento via PIX ───────────────────────────────────────────────────────
  Future<void> _subscribePix() async {
    setState(() {
      _loading = true;
      _errorMsg = null;
    });

    try {
      final resp = await http.post(
        Uri.parse(
            'https://www.condosocio.com.br/flutter/pet_seguro_assinar.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'payment_method_id': 'pix',
          'email': _emailCtrl.text.trim(),
          'cpf': _docCtrl.text.replaceAll(RegExp(r'[.\-]'), ''),
          'amount': _valorPix.toStringAsFixed(2),
          'payer_first_name': _payerNameCtrl.text.trim(),
          'idusu': Get.find<LoginController>().id.value,
          'idpet': widget.idpet,
          'idcond': Get.find<LoginController>().idcond.value,
        }),
      );

      final data = jsonDecode(resp.body);
      if (kDebugMode) {
        debugPrint(
            '[PetSeguro] pet_seguro_assinar.php (pix) status=${resp.statusCode} body=${resp.body}');
        if (data['debug'] != null) {
          debugPrint('[PetSeguro] debug MP: ${jsonEncode(data['debug'])}');
        }
      }
      if (resp.statusCode == 200 && data['status'] == 'pix_pending') {
        setState(() {
          _pixPending = true;
          _pixQrCode = data['qr_code'];
          _pixQrCodeBase64 = data['qr_code_base64'];
          _loading = false;
        });
        _startPixStatusPolling();
      } else {
        setState(() {
          _errorMsg =
              data['status_detail'] ?? 'Erro ao gerar PIX. Tente novamente.';
          _loading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) debugPrint('[PetSeguro] exceção no fluxo de pix: $e');
      setState(() {
        _errorMsg =
            'Erro de conexão. Verifique sua internet e tente novamente.';
        _loading = false;
      });
    }
  }

  // ── Aguarda a confirmação do Pix (via webhook -> pet_seguro_status.php) ─────
  void _startPixStatusPolling() {
    _pixPollTimer?.cancel();
    var tentativas = 0;
    const maxTentativas = 90; // ~6 minutos (90 x 4s)

    _pixPollTimer = Timer.periodic(const Duration(seconds: 4), (timer) async {
      tentativas++;
      if (tentativas > maxTentativas) {
        timer.cancel();
        return;
      }

      try {
        final resp = await http.get(Uri.parse(
            'https://www.condosocio.com.br/flutter/pet_seguro_status.php'
            '?idpet=${widget.idpet}'
            '&idusu=${Get.find<LoginController>().id.value}'));

        if (kDebugMode) {
          debugPrint('[PetSeguro] pet_seguro_status.php body=${resp.body}');
        }

        final data = jsonDecode(resp.body);
        if (data['status'] == 'approved' && mounted) {
          timer.cancel();
          setState(() => _pixConfirmed = true);
          _refreshPetsList();
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('[PetSeguro] erro ao consultar status do pix: $e');
        }
      }
    });
  }

  void _refreshPetsList() {
    if (Get.isRegistered<PetsController>()) {
      Get.find<PetsController>().getPets();
    }
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    if (!_aceitouTermos) {
      setState(() {
        _errorMsg =
            'Você precisa ler e aceitar o Termo de Adesão e Condições de Uso para continuar.';
      });
      return;
    }
    if (_paymentMethod == 'cartao') {
      _subscribeCard();
    } else {
      _subscribePix();
    }
  }

  Future<void> _abrirTermoModal() async {
    final aceitou = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      builder: (_) => const _TermoBottomSheet(url: _termoPetSeguroUrl),
    );

    if (aceitou == true) {
      setState(() {
        _aceitouTermos = true;
        _errorMsg = null;
      });
    }
  }

  String _mapTokenError(String body) {
    try {
      final raw = (jsonDecode(body)['message'] ?? '').toString();
      if (raw.contains('public_key') || raw.contains('not found')) {
        return 'Chave de integração não configurada. Contate o suporte.';
      }
      if (raw.contains('card_number')) return 'Número do cartão inválido.';
      if (raw.contains('security_code')) return 'CVV inválido.';
      if (raw.contains('expiration')) return 'Data de validade inválida.';
      return raw.isNotEmpty ? raw : 'Erro ao processar cartão.';
    } catch (_) {
      return 'Erro ao processar cartão. Tente novamente.';
    }
  }

  String _installmentLabel(int n) {
    final perInstallment = _valor / n;
    return '${n}x de R\$ ${perInstallment.toStringAsFixed(2).replaceAll('.', ',')} sem juros';
  }

  // ── Build ───────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Pet Seguro',
          style: GoogleFonts.montserrat(
              fontSize: 16, color: _textColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: _loadingTaxas
          ? Center(
              child: CircularProgressIndicator(color: _primary),
            )
          : _taxasError != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_taxasIndisponivel) ...[
                          Icon(Icons.pause_circle_outline,
                              size: 48,
                              color: _textColor.withValues(alpha: 0.6)),
                          const SizedBox(height: 12),
                        ],
                        Text(
                          _taxasError!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: _textColor),
                        ),
                        const SizedBox(height: 16),
                        if (_taxasIndisponivel)
                          _backButton()
                        else
                          ElevatedButton(
                            onPressed: _loadTaxas,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _primary),
                            child: Text(
                              'Tentar novamente',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ServiceBanner(
                primary: _primary, textColor: _textColor, valor: _valor),
            const SizedBox(height: 24),

            // ── Tela de sucesso (cartão ou pix confirmado) ─────────────────────
            if (_cardSuccess || _pixConfirmed) ...[
              _SuccessBanner(
                textColor: _textColor,
                msg: _pixConfirmed
                    ? 'Pagamento via Pix confirmado!\nEm breve você receberá o pingente com QR Code.'
                    : 'Assinatura realizada com sucesso!\nEm breve você receberá o pingente com QR Code.',
              ),
              const SizedBox(height: 16),
              _backButton(),
            ]

            // ── Tela PIX aguardando pagamento ─────────────────────────────────
            else if (_pixPending) ...[
              _PixPendingScreen(
                qrCode: _pixQrCode ?? '',
                qrCodeBase64: _pixQrCodeBase64 ?? '',
                textColor: _textColor,
                primary: _primary,
              ),
              const SizedBox(height: 16),
              _backButton(),
            ]

            // ── Formulário ────────────────────────────────────────────────────
            else ...[
              // Seletor de método de pagamento
              _PaymentMethodToggle(
                selected: _paymentMethod,
                primary: _primary,
                textColor: _textColor,
                showPixDiscountBadge: _pixTemDesconto,
                onChanged: (v) => setState(() {
                  _paymentMethod = v;
                  _errorMsg = null;
                }),
              ),
              if (_paymentMethod == 'pix' && _pixTemDesconto) ...[
                const SizedBox(height: 12),
                _PixDiscountBanner(
                  valor: _valor,
                  valorPix: _valorPix,
                  textColor: _textColor,
                ),
              ],
              const SizedBox(height: 20),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Campos exclusivos do cartão ───────────────────────────
                    if (_paymentMethod == 'cartao') ...[
                      _sectionLabel('Dados do Cartão'),
                      const SizedBox(height: 12),
                      _buildField(
                        controller: _cardNumberCtrl,
                        label: 'Número do Cartão',
                        hint: '0000 0000 0000 0000',
                        icon: Icons.credit_card,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          _CardNumberFormatter(),
                        ],
                        validator: (v) {
                          if ((v?.replaceAll(' ', '') ?? '').length < 13)
                            return 'Número inválido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      _buildField(
                        controller: _holderNameCtrl,
                        label: 'Nome no Cartão',
                        hint: 'Como está impresso no cartão',
                        icon: Icons.person_outline,
                        textCapitalization: TextCapitalization.characters,
                        validator: (v) => (v == null || v.trim().length < 3)
                            ? 'Nome inválido'
                            : null,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: _buildField(
                              controller: _expiryMonthCtrl,
                              label: 'Mês',
                              hint: 'MM',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(2),
                              ],
                              validator: (v) {
                                final n = int.tryParse(v ?? '');
                                if (n == null || n < 1 || n > 12)
                                  return 'Inválido';
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildField(
                              controller: _expiryYearCtrl,
                              label: 'Ano',
                              hint: 'AAAA',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                              validator: (v) {
                                final n = int.tryParse(v ?? '');
                                final now = DateTime.now().year;
                                if (n == null || n < now || n > now + 20)
                                  return 'Inválido';
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildField(
                              controller: _cvvCtrl,
                              label: 'CVV',
                              hint: '000',
                              icon: Icons.lock_outline,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                              validator: (v) => (v == null || v.length < 3)
                                  ? 'Inválido'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Parcelamento
                      _sectionLabel('Parcelamento'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<int>(
                        initialValue: _installments,
                        dropdownColor: Theme.of(context).colorScheme.secondary,
                        decoration: _dropdownDecoration(),
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: _textColor),
                        items: List.generate(_maxParcelas, (i) => i + 1)
                            .map((n) {
                          return DropdownMenuItem(
                            value: n,
                            child: Text(
                              _installmentLabel(n),
                              style: GoogleFonts.montserrat(
                                  fontSize: 14, color: _textColor),
                            ),
                          );
                        }).toList(),
                        onChanged: (v) =>
                            setState(() => _installments = v ?? 1),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // ── Campos comuns (email + CPF) ───────────────────────────
                    _sectionLabel('Dados do Pagador'),
                    const SizedBox(height: 12),
                    if (_paymentMethod == 'pix') ...[
                      _buildField(
                        controller: _payerNameCtrl,
                        label: 'Nome do Pagador',
                        hint: 'Nome de quem está pagando',
                        icon: Icons.person_outline,
                        textCapitalization: TextCapitalization.words,
                        validator: (v) => (v == null || v.trim().length < 2)
                            ? 'Nome inválido'
                            : null,
                      ),
                      const SizedBox(height: 14),
                    ],
                    _buildField(
                      controller: _emailCtrl,
                      label: 'E-mail',
                      hint: 'seu@email.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => (v == null || !v.contains('@'))
                          ? 'E-mail inválido'
                          : null,
                    ),
                    const SizedBox(height: 14),
                    _buildField(
                      controller: _docCtrl,
                      label: 'CPF',
                      hint: '000.000.000-00',
                      icon: Icons.badge_outlined,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        _CpfFormatter(),
                      ],
                      validator: (v) {
                        final digits =
                            v?.replaceAll(RegExp(r'[.\-]'), '') ?? '';
                        if (digits.length != 11) return 'CPF inválido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // ── Termo de Adesão e Condições de Uso ────────────────────
                    _TermoAceiteButton(
                      aceito: _aceitouTermos,
                      textColor: _textColor,
                      primary: _primary,
                      onTap: _abrirTermoModal,
                    ),
                    const SizedBox(height: 24),

                    // Mensagem de erro
                    if (_errorMsg != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade700.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red.shade400),
                        ),
                        child: Text(
                          _errorMsg!,
                          style: GoogleFonts.montserrat(
                              fontSize: 13, color: Colors.red.shade700),
                        ),
                      ),

                    // Botão confirmar
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          disabledBackgroundColor:
                              _primary.withValues(alpha: 0.6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                        ),
                        child: _loading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2.5),
                              )
                            : Text(
                                _paymentMethod == 'pix'
                                    ? 'Gerar QR Code PIX'
                                    : 'Confirmar assinatura',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 0.4,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock,
                            size: 13, color: _textColor.withValues(alpha: 0.5)),
                        const SizedBox(width: 4),
                        Text(
                          'Pagamento seguro via Mercado Pago',
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            color: _textColor.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
  }

  Widget _backButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: Text(
            'Voltar',
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
      );

  Widget _sectionLabel(String text) => Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: _textColor.withValues(alpha: 0.75),
          letterSpacing: 0.5,
        ),
      );

  InputDecoration _dropdownDecoration() => InputDecoration(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.07),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _textColor.withValues(alpha: 0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _textColor.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _primary, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      );

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    String? hint,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      style: GoogleFonts.montserrat(fontSize: 14, color: _textColor),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null
            ? Icon(icon, size: 20, color: _textColor.withValues(alpha: 0.6))
            : null,
        labelStyle: GoogleFonts.montserrat(
            fontSize: 13, color: _textColor.withValues(alpha: 0.7)),
        hintStyle: GoogleFonts.montserrat(
            fontSize: 13, color: _textColor.withValues(alpha: 0.35)),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.07),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _textColor.withValues(alpha: 0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _textColor.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
      validator: validator,
    );
  }
}

// ── Toggle Cartão / PIX ───────────────────────────────────────────────────────

class _PaymentMethodToggle extends StatelessWidget {
  final String selected;
  final Color primary;
  final Color textColor;
  final bool showPixDiscountBadge;
  final ValueChanged<String> onChanged;

  const _PaymentMethodToggle({
    required this.selected,
    required this.primary,
    required this.textColor,
    required this.onChanged,
    this.showPixDiscountBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: textColor.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          _tab('cartao', Icons.credit_card, 'Cartão de Crédito'),
          _tab('pix', Icons.pix, 'PIX', showDiscountBadge: showPixDiscountBadge),
        ],
      ),
    );
  }

  Widget _tab(String value, IconData icon, String label,
      {bool showDiscountBadge = false}) {
    final active = selected == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 18,
                  color:
                      active ? Colors.white : textColor.withValues(alpha: 0.6)),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  color:
                      active ? Colors.white : textColor.withValues(alpha: 0.6),
                ),
              ),
              if (showDiscountBadge) ...[
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: active
                        ? Colors.white.withValues(alpha: 0.25)
                        : Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'desconto',
                    style: GoogleFonts.montserrat(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : Colors.green.shade400,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Termo de Adesão e Condições de Uso ────────────────────────────────────────

class _TermoAceiteButton extends StatelessWidget {
  final bool aceito;
  final Color textColor;
  final Color primary;
  final VoidCallback onTap;

  const _TermoAceiteButton({
    required this.aceito,
    required this.textColor,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (aceito) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.green.shade700.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green.shade600.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, size: 18, color: Colors.green.shade400),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Termo de Adesão e Condições de Uso aceito',
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
              Text(
                'Ver termo',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textColor.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: textColor.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.description_outlined, size: 21, color: textColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Aceitar Termo de Adesão e\nCondições de Uso',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Folha com o termo (WebView interna) + botão Aceitar fixo ──────────────────

class _TermoBottomSheet extends StatefulWidget {
  final String url;

  const _TermoBottomSheet({required this.url});

  @override
  State<_TermoBottomSheet> createState() => _TermoBottomSheetState();
}

class _TermoBottomSheetState extends State<_TermoBottomSheet> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _podeAceitar = false;
  double? _maxScrollY;

  static const _thresholdPx = 24;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) async {
            setState(() => _isLoading = false);
            await _checkScrollBounds();
          },
          onWebResourceError: (_) => setState(() => _isLoading = false),
        ),
      )
      ..setOnScrollPositionChange((change) => _onScroll(change.y))
      ..loadRequest(Uri.parse(widget.url));
  }

  // Se o conteúdo já cabe na tela (sem necessidade de rolar), libera direto.
  Future<void> _checkScrollBounds() async {
    try {
      final raw = await _controller.runJavaScriptReturningResult(
        'document.documentElement.scrollHeight - window.innerHeight',
      );
      final maxScrollY = double.tryParse(raw.toString()) ?? 0;
      _maxScrollY = maxScrollY;
      if (maxScrollY <= _thresholdPx && mounted) {
        setState(() => _podeAceitar = true);
      }
    } catch (_) {
      // Se não conseguir medir, não bloqueia indefinidamente.
      if (mounted) setState(() => _podeAceitar = true);
    }
  }

  void _onScroll(double y) {
    final maxScrollY = _maxScrollY;
    if (maxScrollY == null || _podeAceitar) return;
    if (y >= maxScrollY - _thresholdPx) {
      setState(() => _podeAceitar = true);
    }
  }

  Widget _buildWebView() {
    // Android < 13 tem um bug no backend SurfaceProducer que impede renderização.
    // Hybrid Composition contorna isso ao embutir a AndroidView na hierarquia nativa.
    if (Platform.isAndroid) {
      return WebViewWidget.fromPlatformCreationParams(
        params: AndroidWebViewWidgetCreationParams(
          controller: _controller.platform,
          displayWithHybridComposition: true,
        ),
      );
    }
    return WebViewWidget(controller: _controller);
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
    final primary = Theme.of(context).primaryColor;
    final bgColor = Theme.of(context).colorScheme.secondary;
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.92,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Termo de Adesão e Condições de Uso',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: textColor),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                _buildWebView(),
                if (_isLoading)
                  Center(child: CircularProgressIndicator(color: primary)),
              ],
            ),
          ),
          if (!_podeAceitar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_downward,
                      size: 14, color: textColor.withValues(alpha: 0.6)),
                  const SizedBox(width: 6),
                  Text(
                    'Role até o final para habilitar o aceite',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: textColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      _podeAceitar ? () => Navigator.of(context).pop(true) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    disabledBackgroundColor: textColor.withValues(alpha: 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: _podeAceitar
                          ? BorderSide.none
                          : BorderSide(color: textColor.withValues(alpha: 0.2)),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Aceitar',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _podeAceitar
                          ? Colors.white
                          : textColor.withValues(alpha: 0.35),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Banner de desconto PIX ──────────────────────────────────────────────────

class _PixDiscountBanner extends StatelessWidget {
  final double valor;
  final double valorPix;
  final Color textColor;

  const _PixDiscountBanner({
    required this.valor,
    required this.valorPix,
    required this.textColor,
  });

  String _fmt(double v) => 'R\$ ${v.toStringAsFixed(2).replaceAll('.', ',')}';

  @override
  Widget build(BuildContext context) {
    final economia = valor - valorPix;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green.shade700.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green.shade600.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(Icons.local_offer, size: 16, color: Colors.green.shade400),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Pagando com PIX sai por ${_fmt(valorPix)} — economia de ${_fmt(economia)} em relação ao cartão.',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                height: 1.4,
                color: textColor.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tela PIX aguardando ───────────────────────────────────────────────────────

class _PixPendingScreen extends StatelessWidget {
  final String qrCode;
  final String qrCodeBase64;
  final Color textColor;
  final Color primary;

  const _PixPendingScreen({
    required this.qrCode,
    required this.qrCodeBase64,
    required this.textColor,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.green.shade700.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.green.shade600),
          ),
          child: Column(
            children: [
              const Icon(Icons.pix, color: Colors.green, size: 44),
              const SizedBox(height: 10),
              Text(
                'PIX gerado com sucesso!',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textColor),
              ),
              const SizedBox(height: 6),
              Text(
                'Escaneie o QR Code ou copie o código abaixo para pagar.',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 13,
                    height: 1.5,
                    color: textColor.withValues(alpha: 0.85)),
              ),
              const SizedBox(height: 20),

              // QR Code image
              if (qrCodeBase64.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    base64Decode(qrCodeBase64),
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),

              const SizedBox(height: 20),

              // Código copia-e-cola
              if (qrCode.isNotEmpty) ...[
                Text(
                  'Código PIX (copia e cola)',
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textColor.withValues(alpha: 0.7)),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: qrCode));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Código PIX copiado!',
                          style: GoogleFonts.montserrat(fontSize: 13),
                        ),
                        backgroundColor: Colors.green.shade700,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(12),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade400),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            qrCode,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                color: textColor.withValues(alpha: 0.8)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.copy,
                            size: 18, color: Colors.green.shade400),
                      ],
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 14),
              Text(
                'Após o pagamento sua assinatura será confirmada automaticamente.',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: textColor.withValues(alpha: 0.6),
                    height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Banner do serviço ─────────────────────────────────────────────────────────

class _ServiceBanner extends StatelessWidget {
  final Color primary;
  final Color textColor;
  final double valor;

  const _ServiceBanner({
    required this.primary,
    required this.textColor,
    required this.valor,
  });

  double get _valorMensal => valor / 12;

  String get _valorMensalFormatado =>
      'R\$ ${_valorMensal.toStringAsFixed(2).replaceAll('.', ',')}';

  String get _valorAnualFormatado =>
      'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, primary.withValues(alpha: 0.82)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.22),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pets_rounded,
                  color: Colors.white.withValues(alpha: 0.85), size: 18),
              const SizedBox(width: 8),
              Text(
                'PET SEGURO',
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.white.withValues(alpha: 0.85)),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _valorMensalFormatado,
                style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing: -0.5,
                    color: Colors.white),
              ),
              const SizedBox(width: 6),
              Text(
                '/mês',
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.75)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Identificação e tranquilidade para o seu pet',
            style: GoogleFonts.montserrat(
                fontSize: 13,
                height: 1.4,
                color: Colors.white.withValues(alpha: 0.75)),
          ),
          const SizedBox(height: 24),
          _BenefitItem(
            text:
                'Pingente com QR Code na 1ª assinatura, com as suas informações de contato.',
          ),
          const SizedBox(height: 10),
          _BenefitItem(
            text:
                'Qualquer pessoa que encontrar seu pet pode escanear e falar com você.',
          ),
          const SizedBox(height: 20),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.15)),
          const SizedBox(height: 14),
          Text(
            'Assinatura anual: $_valorAnualFormatado',
            style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.6)),
          ),
        ],
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final String text;

  const _BenefitItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 4,
          margin: const EdgeInsets.only(top: 7),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                fontSize: 13,
                height: 1.4,
                color: Colors.white.withValues(alpha: 0.85)),
          ),
        ),
      ],
    );
  }
}

// ── Banner de sucesso ─────────────────────────────────────────────────────────

class _SuccessBanner extends StatelessWidget {
  final String msg;
  final Color textColor;

  const _SuccessBanner({required this.msg, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade700.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade600),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 48),
          const SizedBox(height: 12),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: 14, height: 1.5, color: textColor),
          ),
        ],
      ),
    );
  }
}

// ── Formatadores ──────────────────────────────────────────────────────────────

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length && i < 16; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(text[i]);
    }
    final formatted = buffer.toString();
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _CpfFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length && i < 11; i++) {
      if (i == 3 || i == 6) buffer.write('.');
      if (i == 9) buffer.write('-');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
