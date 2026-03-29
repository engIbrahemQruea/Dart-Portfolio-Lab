//Declaring Enums With Fields and Constructors
enum Color {
  red(0xFF0000),
  green(0x00FF00),
  blue(0x0000FF);

  final int hexValue;

  const Color(this.hexValue);
}

enum Status {
  success(200),
  notFound(404),
  internalServerError(500);

  final int code;

  const Status(this.code);
}

enum Difficulty {
  easy(1),
  medium(2),
  hard(3);

  final int level;

  const Difficulty(this.level);
}

enum Weather {
  sunny,
  rainy,
  cloudy,
  snowy,
  stormy;

  bool isGoodForPicnic(Weather weather) {
    switch (weather) {
      case Weather.sunny:
        return true;
      case Weather.rainy:
      case Weather.stormy:
        return false;
      case Weather.cloudy:
      case Weather.snowy:
        return true;
    }
  }

  bool allowOutdoorActivities(Weather weather) {
    return weather != Weather.stormy;
  }
}

/// Adding Custom Methods to Enums
enum TrafficLight {
  red,
  yellow,
  green;

  int get waitTime {
    switch (this) {
      case TrafficLight.red:
        return 60;
      case TrafficLight.yellow:
        return 5;
      case TrafficLight.green:
        return 0;
    }
  }

  String get description {
    switch (this) {
      case TrafficLight.red:
        return 'Stop';
      case TrafficLight.yellow:
        return 'Caution';
      case TrafficLight.green:
        return 'Go';
    }
  }
}

enum TemperatureUnit {
  celsius,
  fahrenheit,
  kelvin;

  double convert(double value) {
    switch (this) {
      case TemperatureUnit.celsius:
        return value;
      case TemperatureUnit.fahrenheit:
        return value * 9 / 5 + 32;
      case TemperatureUnit.kelvin:
        return value + 273.15;
    }
  }

  String format(double value) {
    switch (this) {
      case TemperatureUnit.celsius:
        return '$value °C';
      case TemperatureUnit.fahrenheit:
        return '$value °F';
      case TemperatureUnit.kelvin:
        return '$value K';
    }
  }
}

/// Implementing Interfaces in Enums
abstract class Describable {
  String get description;
}

enum PaymentStatus implements Describable {
  pending('Payment is pending'),
  completed('Payment is completed'),
  failed('Payment has failed');

  final String description;

  const PaymentStatus(this.description);
}

void logDescription(Describable item) {
  print(item.description);
}

// Enhanced enum
enum Direction {
  north('↑'),
  south('↓'),
  east('→'),
  west('←');

  final String symbol;
  const Direction(this.symbol);
}

extension DirectionHelper on Direction {
  bool isVertical() => this == Direction.north || this == Direction.south;
}

///Enums as Switch Expressions and Pattern Matches
enum ConnectionState { connected, disconnected, connecting, disconnecting }

String connectionMessage(ConnectionState state) {
  switch (state) {
    case ConnectionState.connected:
      return 'You are connected.';
    case ConnectionState.disconnected:
      return 'You are disconnected.';
    case ConnectionState.connecting:
      return 'Connecting...';
    case ConnectionState.disconnecting:
      return 'Disconnecting...';
  }
}

void main() {
  logDescription(PaymentStatus.completed);
}
