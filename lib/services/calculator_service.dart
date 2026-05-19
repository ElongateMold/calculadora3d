import '../data/printer_data.dart'; // Importamos los datos base configurados

class CalculatorService {
  // Usamos 'static' para poder usar la función directamente sin instanciar la clase
  static double calculateTotal(double grams, double hours) {
    // 1. Costo del plástico
    double pricePerGram = AppData.pricePerKg / 1000;
    double filamentCost = grams * pricePerGram;

    // 2. Costo por hora (Luz + Desgaste de máquina) * Margen de error
    double energyHourCost = (AppData.wattsConsume / 1000) * AppData.kWhCost;
    double realHourCost = (energyHourCost + AppData.machineWearHour) * AppData.marginError;
    double totalHoursCost = hours * realHourCost;

    // 3. Costo Base y Precio de Venta Final
    double baseCost = filamentCost + totalHoursCost;
    return baseCost * AppData.gainsMultiplier;
  }
}