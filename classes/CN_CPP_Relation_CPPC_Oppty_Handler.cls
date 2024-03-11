/*
 * ************************************************************************************************
 * Name : CN_CPP_Relation_CPPC_Oppty_Handler
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
public without sharing class CN_CPP_Relation_CPPC_Oppty_Handler implements Triggers.Handler{
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
    
        Map<Id, List<Id>> oppIdsByAccountId = new Map<Id, List<Id>>();
        for (Opportunity opp : [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :accountIds]) {
            if (!oppIdsByAccountId.containsKey(opp.AccountId)) {
                oppIdsByAccountId.put(opp.AccountId, new List<Id>());
            }
            oppIdsByAccountId.get(opp.AccountId).add(opp.Id);
        }
    
    
        List<CN_CPPC_Oppty__c> recordsToInsert = new List<CN_CPPC_Oppty__c>();
        for (CN_Competitor_Product_Price_to_Customer__c cpp : (List<CN_Competitor_Product_Price_to_Customer__c>) Trigger.new) {
            Id accountId = cpp.CN_Account_Name__c;
            List<Id> oppIds = oppIdsByAccountId.get(accountId);
                if(oppIds != null){
                    for (Id opportunityId : oppIds) {
                        CN_CPPC_Oppty__c record = new CN_CPPC_Oppty__c(
                            CN_Competitor_Product_Price_for_Customer__c = cpp.Id,
                            CN_Opportunity__c = opportunityId,
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
        List<CN_CPPC_Oppty__c> recordsToDelete = new List<CN_CPPC_Oppty__c>();

        for (CN_Competitor_Product_Price_to_Customer__c deletedRecord : (List<CN_Competitor_Product_Price_to_Customer__c>)Trigger.old) {
            Id deletedCppId = deletedRecord.Id;
            List<CN_CPPC_Oppty__c> relatedRecords = [SELECT Id FROM CN_CPPC_Oppty__c WHERE CN_Competitor_Product_Price_for_Customer__c = :deletedCppId];
    
            for (CN_CPPC_Oppty__c record : relatedRecords) {
                recordsToDelete.add(record);
            }
        }
        if (!recordsToDelete.isEmpty()) {
            delete recordsToDelete;
        }
    }
}