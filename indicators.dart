import 'dart:math';

List<double> ema(List<double> values, int period) {
  if (values.isEmpty) return [];
  double k = 2 / (period + 1);
  List<double> out = [];
  double prev = values.first;
  for (int i = 0; i < values.length; i++) {
    prev = values[i] * k + prev * (1 - k);
    out.add(prev);
  }
  return out;
}

List<double> rsi(List<double> closes, int period) {
  if (closes.length < period + 1) return List.filled(closes.length, 50.0);
  List<double> deltas = [];
  for (int i = 1; i < closes.length; i++) deltas.add(closes[i] - closes[i - 1]);
  double gain = 0, loss = 0;
  for (int i = 0; i < period; i++) {
    double d = deltas[i];
    if (d > 0) gain += d; else loss += -d;
  }
  List<double> out = List.filled(period + 1, 50.0);
  for (int i = period; i < deltas.length; i++) {
    gain = (gain * (period - 1) + (deltas[i] > 0 ? deltas[i] : 0)) / period;
    loss = (loss * (period - 1) + (deltas[i] < 0 ? -deltas[i] : 0)) / period;
    double rs = loss == 0 ? 0 : gain / loss;
    double rsiVal = loss == 0 ? 100 : 100 - (100 / (1 + rs));
    out.add(rsiVal);
  }
  return out;
}

List<double> atr(List<Map<String,double>> candles, int period){
  return List.filled(candles.length, 1.0);
}

Map<String,List<double>> macd(List<double> closes){
  return {'macd': List.filled(closes.length, 0.0), 'signal': List.filled(closes.length,0.0)};
}