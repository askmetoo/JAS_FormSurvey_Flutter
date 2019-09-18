

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Flutter Test, ", () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async{
      if(driver != null){
        await driver.close();
      }
    });

    test('Check flutter driver health', () async {
      Health health = await driver.checkHealth();
      // print(health.status);
      print(health.toJson());
    }); 

    test('Check location Field', () async {
      await driver.tap(find.byValueKey('keyLocation'));
      await driver.enterText('PSI');
      await driver.waitFor(find.text('PSI'));
      print('Location field has a value of PSI, Check');
    });

    test('Check Date Field', () async {
      await driver.waitFor(find.byValueKey('keyDateField'));
      await driver.tap(find.byValueKey('keyDateField'));
      print('DatePicker is found!, Check');
    });

    test('Check dateTime Field', () async {
      await driver.tap(find.byValueKey('KeyDateModal'));
      print('DatePicker clicked!, Check');
    });

  });

}