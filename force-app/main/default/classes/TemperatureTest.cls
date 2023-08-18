@isTest
public class TemperatureTest {
    @isTest
    private Static void warmTemTest(){
        Decimal res = Temperature.FtoC(70);
        system.assertEquals(21.11, res);
    }
@isTest
    private Static void coldTemTest(){
        Decimal res = Temperature.FtoC(32);
        system.assertEquals(0, res);
    }
}