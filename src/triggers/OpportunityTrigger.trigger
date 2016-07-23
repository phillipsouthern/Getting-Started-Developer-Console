trigger OpportunityTrigger on Opportunity (before insert, before update) 
{
    //figure out order number
	OpportunityUtility.createOrderNumber(trigger.new, trigger.oldmap);
}