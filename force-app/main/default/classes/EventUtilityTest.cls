@isTest
public class EventUtilityTest {
    @isTest
    private Static void test(){
        String res = EventUtility.eventPriority('IND');
        System.assertEquals(null, res);
    }
    @isTest
    private Static void testHighPri(){
        String res = EventUtility.eventPriority('CA');
        System.assertEquals('High', res);
    }
     @isTest
    private Static void testMedPri(){
        String res = EventUtility.eventPriority('NA');
        System.assertEquals('Medium', res);
    }

}