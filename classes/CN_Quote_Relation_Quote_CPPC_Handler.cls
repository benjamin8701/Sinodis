/*
 * ************************************************************************************************
 * Name : CN_Quote_Relation_Quote_CPPC_Handler
 * Description : 
 * Object :
 * Requirement :
 * Target :
 * Refer classes :
 * Author : Zhang ZhiHao
 * Create Date : 2024/2/23
 * Modify History :
 * ************************************************************************************************
 */
public without sharing class CN_Quote_Relation_Quote_CPPC_Handler implements Triggers.Handler{
    public void handle() {
		if(Trigger.isAfter && Trigger.isInsert){
			afterInsertHandle();
		}
	}
    public void afterInsertHandle() {
        Set<Id> accountIds = new Set<Id>();
        List<Quote> quotes = new List<Quote>();
        Set<Id> opportunityIds = new Set<Id>();
        for(Quote quote: (List<Quote>)Trigger.new) {
            Id opportunityId = quote.OpportunityId;
            opportunityIds.add(opportunityId);
        }

        Map<Id, Opportunity> mapOpportunities = new Map<Id, Opportunity>([SELECT Id, AccountId FROM Opportunity WHERE Id IN :opportunityIds]);

        for (Quote quote : (List<Quote>)Trigger.new) {
            Id opportunityId = quote.OpportunityId;
            opportunityIds.add(opportunityId);
        
            if (mapOpportunities.containsKey(opportunityId)) {
                Id accountId = mapOpportunities.get(opportunityId).AccountId;
                accountIds.add(accountId);
            }
        }
        Map<Id, List<Id>> quoteByAccountId = new Map<Id, List<Id>>();
        
        for (CN_Competitor_Product_Price_to_Customer__c cppc : [SELECT Id, CN_Account_Name__c FROM CN_Competitor_Product_Price_to_Customer__c WHERE CN_Account_Name__c IN :accountIds]) {
            if (!quoteByAccountId.containsKey(cppc.CN_Account_Name__c)) {
                quoteByAccountId.put(cppc.CN_Account_Name__c, new List<Id>());
            }
            quoteByAccountId.get(cppc.CN_Account_Name__c).add(cppc.Id);
        }
    
    
        List<CN_CPPC_Quote__c> recordsToInsert = new List<CN_CPPC_Quote__c>();
        for (Quote quote : (List<Quote>) Trigger.new) {
            Id accountId = mapOpportunities.get(quote.OpportunityId).AccountId;
            List<Id> cppIds = quoteByAccountId.get(accountId);
                if(cppIds != null){
                    for (Id cppId : cppIds) {
                        CN_CPPC_Quote__c record = new CN_CPPC_Quote__c(
                                CN_Competitor_Product_Price_for_Customer__c = cppId,
                                CN_Quote__c = quote.id,
                                CN_Account__c = accountId
                            );
                        recordsToInsert.add(record);
                    }
                } 
            }
        if (!recordsToInsert.isEmpty()) {
            insert recordsToInsert;
        }
    }
}