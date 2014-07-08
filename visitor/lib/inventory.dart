library inventory;

abstract class Inventory {
  String name;
  Inventory(this.name);

  double netPrice;
  double discountPrice() => netPrice;

  void accept(vistor);
}

class InventoryCollection {
  String name;
  List<Inventory> stuff = [];
  InventoryCollection(this.stuff);

  String names() =>
    stuff.map((i) => i.name).join('\n');

  void accept(visitor) {
    stuff.forEach((thing) { thing.accept(visitor); });
  }
}

abstract class Equipment extends Inventory {
  Equipment(name): super(name);
  int watt;
}

App app(name, {price: 0}) => new App(name)..netPrice = price;

class App extends Inventory {
  App(name): super(name);
  void accept(visitor) { visitor.visitApp(this); }
}

abstract class EquipmentWithApps extends Equipment {
  EquipmentWithApps(name): super(name);
  List<App> apps = [];
}

class Mobile extends EquipmentWithApps {
  Mobile(): super('Mobile Phone');
  double netPrice = 350.00;
  void accept(visitor) {
    apps.forEach((app) { app.accept(visitor); });
    visitor.visitMobile(this);
  }
}

class Tablet extends EquipmentWithApps {
  Tablet(): super('Tablet');
  double netPrice = 400.00;
  void accept(visitor) {
    apps.forEach((app) { app.accept(visitor); });
    visitor.visitTablet(this);
  }
}

class Laptop extends Equipment {
  Laptop(): super('Laptop');
  double netPrice = 1000.00;
  double discountPrice() => netPrice * .9;
  void accept(visitor) { visitor.visitLaptop(this); }
}
