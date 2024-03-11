/*
 * ************************************************************************************************
 * Name : CN_CPP_Relation_CPPC_Quote_Handler
 * Description : 
 * Object :
 * Requirement :
 * Target :             
 * Refer classes :
 * Author : Zhang ZhiHao
 * Create Date : 2024/2/22
 * Modify History :
 * ************************************************************************************************
 */
public without sharing class CN_CPP_Relation_CPPC_Quote_Handler implements Triggers.Handler{
    public void handle() {
		if(Trigger.isBefore && Trigger.isDelete) {
			beforeDeleteHandle();
		}
		if(Trigger.isAfter && Trigger.isInsert){
			afterInsertHandle();
		}
	}


    public void afterInsertHandle() {
        Set<Id> accountIds = new Set<Id>();
        List<CN_Competitor_Product_Price_to_Customer__c> cpps = new List<CN_Competitor_Product_Price_to_Customer__c>();
        for(CN_Competitor_Product_Price_to_Customer__c cpp: (List<CN_Competitor_Product_Price_to_Customer__c>)Trigger.new) {
            Id accountId = cpp.CN_Account_Name__c;
            accountIds.add(accountId);
        }
    
        Map<Id, List<Id>> quoteIdsByAccountId = new Map<Id, List<Id>>();
        
        for (Quote q : [SELECT Id, AccountId FROM Quote WHERE AccountId IN :accountIds ]) {
            if (!quoteIdsByAccountId.containsKey(q.AccountId)) {
                quoteIdsByAccountId.put(q.AccountId, new List<Id>());
            }
            quoteIdsByAccountId.get(q.AccountId).add(q.Id);
        }
    
    
        List<CN_CPPC_Quote__c> recordsToInsert = new List<CN_CPPC_Quote__c>();
        for (CN_Competitor_Product_Price_to_Customer__c cpp : (List<CN_Competitor_Product_Price_to_Customer__c>) Trigger.new) {
            Id accountId = cpp.CN_Account_Name__c;
            List<Id> quoteIds = quoteIdsByAccountId.get(accountId);
                if(quoteIds != null){
                    for (Id quoteId : quoteIds) {
                        CN_CPPC_Quote__c record = new CN_CPPC_Quote__c(
                                CN_Competitor_Product_Price_for_Customer__c = cpp.Id,
                                CN_Quote__c = quoteId,
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

    public void beforeDeleteHandle(){
        List<CN_CPPC_Quote__c> recordsToDelete = new List<CN_CPPC_Quote__c>();

        for (CN_Competitor_Product_Price_to_Customer__c deletedRecord : (List<CN_Competitor_Product_Price_to_Customer__c>)Trigger.old) {
            Id deletedCppId = deletedRecord.Id;
            List<CN_CPPC_Quote__c> relatedRecords = [SELECT Id FROM CN_CPPC_Quote__c WHERE CN_Competitor_Product_Price_for_Customer__c = :deletedCppId];
    
            for (CN_CPPC_Quote__c record : relatedRecords) {
                recordsToDelete.add(record);
            }
        }
        if (!recordsToDelete.isEmpty()) {
            delete recordsToDelete;
        }
    }
}