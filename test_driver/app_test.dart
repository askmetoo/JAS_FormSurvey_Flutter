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
      print("Check..!!");
    });

    test("check drawer", () async{
      final SerializableFinder locateDrawer = find.byTooltip("Open navigation menu");
      await driver.tap(locateDrawer);
      await driver.tap(find.byValueKey("addFormMenu"));
      await driver.tap(locateDrawer);
      await driver.tap(find.byValueKey("homeMenu"));
      print("Check..!!");
    }); 

    test("fill survey form without device and cable", () async {
      final SerializableFinder locateDrawer = find.byTooltip("Open navigation menu");
      await driver.tap(find.byValueKey('fabForm'));
      await driver.tap(find.byValueKey('keyLocation'));
      await driver.enterText("Fasilkom-TI");
      await driver.tap(find.byValueKey("keyAdminName"));
      await driver.enterText("Irshad");
      await driver.waitFor(find.text("Irshad"));
      await driver.tap(find.byValueKey("keyClientName"));
      await driver.enterText("Romi");
      await driver.waitFor(find.text("Romi"));
      await driver.tap(locateDrawer);
      await driver.tap(find.byValueKey("homeMenu"));
      print("Check..!!");
    });

    test("fill survey form with devices but no cables", ()async{
      final SerializableFinder locateDrawer = find.byTooltip("Open navigation menu");
      await driver.tap(find.byValueKey('fabForm'));
      await driver.tap(find.byValueKey('keyDateField'));
      await driver.tap(find.text('20'));
      print('date selected: 20 November 2019');
      await driver.tap(find.text("OK"));
      await driver.tap(find.byValueKey('keyLocation'));
      await driver.enterText("Farmasi");
      
      await driver.tap(find.byValueKey("deviceAdd"));

      //device 1
      await driver.tap(find.byValueKey('btnToDeviceForm'));
      await driver.tap(find.byValueKey('deviceType'));
      await driver.tap(find.text('Switch Component'));
      await driver.tap(find.byValueKey("vendorComp"));
      await driver.enterText("Switch_vendor");
      await driver.tap(find.byValueKey("asetNumComp"));
      await driver.enterText("switch_aset_number");
      await driver.tap(find.byValueKey("valueComp"));
      await driver.enterText("2");
      await driver.waitFor(find.text("2"));
      await driver.tap(find.byValueKey('addComponentSubmitBtn'));
      print('device added');

      //device 2
      await driver.tap(find.byValueKey('btnToDeviceForm'));
      await driver.tap(find.byValueKey('deviceType'));
      await driver.tap(find.text('Hardware Device'));
      await driver.tap(find.byValueKey("vendorComp"));
      await driver.enterText("Laptop ASUS Zenbook");
      await driver.tap(find.byValueKey("asetNumComp"));
      await driver.enterText("2.4.1 2019.3");
      await driver.tap(find.byValueKey("valueComp"));
      await driver.enterText("1");
      await driver.waitFor(find.text("1"));
      await driver.tap(find.byValueKey('addComponentSubmitBtn'));
      print('device added');
      
      //device 3
      await driver.tap(find.byValueKey('btnToDeviceForm'));
      await driver.tap(find.byValueKey('deviceType'));
      await driver.tap(find.text('Wireless Component'));
      await driver.tap(find.byValueKey("vendorComp"));
      await driver.enterText("wireless_component");
      await driver.tap(find.byValueKey("asetNumComp"));
      await driver.enterText("wireless_aset_number");
      await driver.tap(find.byValueKey("valueComp"));
      await driver.enterText("5");
      await driver.waitFor(find.text("5"));
      await driver.tap(find.byValueKey('addComponentSubmitBtn'));
      print('device added');

      await driver.tap(find.byValueKey('saveCompBtn'));

      await driver.tap(find.byValueKey("keyAdminName"));
      await driver.enterText("Nasrun");
      await driver.waitFor(find.text("Nasrun"));
      await driver.tap(find.byValueKey("keyClientName"));
      await driver.enterText("Anisa");
      await driver.waitFor(find.text("Anisa"));
      await driver.tap(locateDrawer);
      await driver.tap(find.byValueKey("homeMenu"));
      print('Form Complete, Check..!!');
    });

    test("fill survey form with cables but no devices", ()async{
      final SerializableFinder locateDrawer = find.byTooltip("Open navigation menu");
      await driver.tap(find.byValueKey('fabForm'));
      await driver.tap(find.byValueKey('keyDateField'));
      await driver.tap(find.text('24'));
      print('date selected: 24 November 2019');
      await driver.tap(find.text("OK"));
      await driver.tap(find.byValueKey('keyLocation'));
      await driver.enterText("Biro Rektor USU");

      await driver.tap(find.byValueKey("cableAdd"));

      // cable 1
      await driver.tap(find.byValueKey('btnToCableForm'));
      await driver.tap(find.byValueKey('cableType'));
      await driver.tap(find.text('Listrik'));
      await driver.tap(find.byValueKey("cableLength"));
      await driver.enterText("10");
      await driver.tap(find.byValueKey('addCableSubmitBtn'));
      print('cable 1 added');

      // cable 2
      await driver.tap(find.byValueKey('btnToCableForm'));
      await driver.tap(find.byValueKey('cableType'));
      await driver.tap(find.text('FO'));
      await driver.tap(find.byValueKey("cableLength"));
      await driver.enterText("5");
      await driver.tap(find.byValueKey('addCableSubmitBtn'));
      print('cable 2 added');

      // cable 3
      await driver.tap(find.byValueKey('btnToCableForm'));
      await driver.tap(find.byValueKey('cableType'));
      await driver.tap(find.text('UTP'));
      await driver.tap(find.byValueKey("cableLength"));
      await driver.enterText("30");
      await driver.tap(find.byValueKey('addCableSubmitBtn'));
      print('cable 3 added');

      await driver.tap(find.byValueKey('saveCableBtn'));
      
      await driver.tap(find.byValueKey("keyAdminName"));
      await driver.enterText("rendra");
      await driver.waitFor(find.text("rendra"));
      await driver.tap(find.byValueKey("keyClientName"));
      await driver.enterText("Staff WR 2");
      await driver.waitFor(find.text("Staff WR 2"));
      await driver.tap(locateDrawer);
      await driver.tap(find.byValueKey("homeMenu"));
      print('Form complete, Check..!!');
    });

    test("Test if form not filled, will show error validation", () async{
        final SerializableFinder locateDrawer = find.byTooltip("Open navigation menu");
        await driver.tap(find.byValueKey('fabForm'));

        //tes cable form with empty field
        await driver.tap(find.byValueKey("cableAdd"));
        await driver.tap(find.byValueKey('btnToCableForm'));
        await driver.tap(find.byValueKey('addCableSubmitBtn'));
        print("error validation is showing");
        await driver.tap(find.byTooltip('Back'));
        await driver.tap(find.byValueKey('saveCableBtn'));
        
        //tes device form with empty field
        await driver.tap(find.byValueKey('deviceAdd'));
        await driver.tap(find.byValueKey('btnToDeviceForm'));
        await driver.tap(find.byValueKey('addComponentSubmitBtn'));
        print("error validation is showing");
        await driver.tap(find.byTooltip('Back'));
        await driver.tap(find.byValueKey('saveCompBtn'));

        await driver.scrollIntoView(find.byValueKey('submitFormBtn'));
        await driver.tap(find.byValueKey('submitFormBtn'));
        print('validation warning was appeared');
        await driver.tap(locateDrawer);
        await driver.tap(find.byValueKey("homeMenu"));
        print("Check..!!");
    });
  });
}