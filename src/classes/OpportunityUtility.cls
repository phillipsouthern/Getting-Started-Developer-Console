public class OpportunityUtility 
{
    public static void createOrderNumber(List<Opportunity> records, Map<Id,Opportunity> oldmap)
	{  
        
        if(trigger.isUpdate)
        {
            String debugMessage = '';
            debugMessage = 'Hey! this is an update!';
            system.debug(debugMessage);
		}
        
        boolean addaNumber = false;
        
        for(Opportunity o : records)
        {
            if(o.StageName == 'Closed Won'
               && o.Order_Number__c == null
               && (trigger.isInsert || o.StageName != oldmap.get(o.Id).StageName))
            {
                addaNumber = true;
                break;
            }
        }
        
        if(!addaNumber) return;
        
		List<Opportunity> opps = [Select Id, Name, Order_Number__c from Opportunity 
                                  Where Order_Number__c != null ORDER BY Order_Number__c DESC LIMIT 1];
		Integer counter = 0;
        
        if(opps.isEmpty())
        {
            counter = 1;
        }else
        {
            counter = Integer.valueof(opps[0].Order_Number__c) + 1;
        }
        
        system.debug('Order number started at: ' + counter);
        
		for(Opportunity op : records)
		{
            if(op.StageName == 'Closed Won'
               && op.Order_Number__c == null
               && (trigger.isInsert || op.StageName != oldmap.get(op.Id).StageName))
            {
                op.Order_Number__c = counter; 
				counter++;
                
                system.debug('Opportunity: ' + op.Name + ' given Order Number of: ' + op.Order_Number__c);
            }
		}
	}

}






 /*
        if(trigger.isUpdate)
        {
            String debugMessage = '';
            debugMessage = 'Hey! this is an update!';
            system.debug(debugMessage);
		}
        */