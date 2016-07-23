@isTest
public class Test_OpportunityUtility 
{
    @isTest static void testCreateOrderNumber_Insert()
    {
        Account a = new Account();
        a.Name = 'test Account';
        insert a;
        
        test.starttest();
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer x = 1; x <= 250; x++)
        {
            Opportunity o = new Opportunity();
            o.Name = 'Test Opp ' + String.valueof(x);
            o.AccountId = a.Id;
            o.CloseDate = system.now().date().addDays(90);
            o.StageName = 'Closed Won';
            o.Amount = 100;
            opps.add(o);
        }
        
        insert opps;
        test.stoptest();
        
        system.assertEquals(250, [select count() from Opportunity Where Order_Number__c != null]);
    }
    
    @isTest static void testCreateOrderNumber_Update()
    {
        Account a = new Account();
        a.Name = 'test Account';
        insert a;
        
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer x = 1; x <= 250; x++)
        {
            Opportunity o = new Opportunity();
            o.Name = 'Test Opp ' + String.valueof(x);
            o.AccountId = a.Id;
            o.CloseDate = system.now().date().addDays(90);
            o.StageName = 'Prospecting';
            o.Amount = 100;
            opps.add(o);
        }
        
        insert opps;
        
        system.assertEquals(0, [select count() from Opportunity Where Order_Number__c != null]);
        
        test.starttest();
        for(Opportunity o : opps)
        {
            o.StageName = 'Closed Won';
        }
        
        update opps;
        test.stoptest();
        
        system.assertEquals(250, [select count() from Opportunity Where Order_Number__c != null]);
    }

}