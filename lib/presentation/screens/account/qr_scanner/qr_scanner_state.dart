part of 'qr_scanner_cubit.dart';

class QrScannerState extends Equatable {
  final LoadStatus loadStatus;
  final String message;
  final String qrCode;

  const QrScannerState({
    this.loadStatus = LoadStatus.initial,
    this.message = '',
    this.qrCode = '',
  });

  QrScannerState copyWith({
    LoadStatus? loadStatus,
    String? message,
    String? qrCode,
  }) {
    return QrScannerState(
      loadStatus: loadStatus ?? this.loadStatus,
      message: message ?? this.message,
      qrCode: qrCode ?? this.qrCode,
    );
  }

  @override
  List<Object> get props => [
        loadStatus,
        message,
        qrCode,
      ];
}
