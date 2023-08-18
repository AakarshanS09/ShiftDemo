@isTest
public class OppRemainderTest {
    @isTest
    public static void testScheduleJob(){
        List<Opportunity> opplist = new List<Opportunity>();
        String sch = '20 5 21 6 4 ? 2023';
        
        for(Integer i=1;i<=5;i++){
            opportunity opp = new opportunity();
                opp.Name = 'OppTest'+i;
             opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today().addDays(-7);
            opplist.add(opp);
            }
        
        if(!opplist.isEmpty()){
            insert opplist;
        }
        Set<id> oppIds = new Set<id>();
        for(opportunity opp : opplist){
            oppIds.add(opp.Id);
        }
        Test.startTest();
        String jobId = system.schedule('Create Task', sch,new OppRemainder());
        Test.stopTest();
        
        List<Task> Tasklist = [SELECT Id FROM task WHERE WhatId IN: oppIds];
        system.assertEquals(5, Tasklist.size());
        
        }
            
            
    }