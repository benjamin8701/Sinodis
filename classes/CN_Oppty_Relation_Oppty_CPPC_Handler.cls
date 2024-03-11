/*
 * ************************************************************************************************
 * Name : CN_Oppty_Relation_Oppty_CPPC_Handler
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
public without sharing class CN_Oppty_Relation_Oppty_CPPC_Handler implements Triggers.Handler{
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
        List<Opportunity> opps = new List<Opportunity>();
        for(Opportunity opp: (List<Opportunity>)Trigger.new) {
            Id accountId = opp.AccountId;
            accountIds.add(accountId);
        }
    
 
        Map<Id, List<Id>> cppByAccountId = new Map<Id, List<Id>>();
        
        for (CN_Competitor_Product_Price_to_Customer__c cppc : [SELECT Id, CN_Account_Name__c FROM CN_Competitor_Product_Price_to_Customer__c WHERE CN_Account_Name__c IN :accountIds]) {
            if (!cppByAccountId.containsKey(cppc.CN_Account_Name__c)) {
                cppByAccountId.put(cppc.CN_Account_Name__c, new List<Id>());
            }
            cppByAccountId.get(cppc.CN_Account_Name__c).add(cppc.Id);
        }
    
    
        List<CN_CPPC_Oppty__c> recordsToInsert = new List<CN_CPPC_Oppty__c>();
        for (Opportunity opp : (List<Opportunity>) Trigger.new) {
            Id accountId = opp.AccountId;
            List<Id> cppIds = cppByAccountId.get(accountId);
                if(cppIds != null){
                    for (Id cppId : cppIds) {
                        CN_CPPC_Oppty__c record = new CN_CPPC_Oppty__c(
                                CN_Competitor_Product_Price_for_Customer__c = cppId,
                                CN_Opportunity__c = opp.id,
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

        for (Opportunity deletedRecord : (List<Opportunity>)Trigger.old) {
            Id deletedCppId = deletedRecord.Id;
            List<CN_CPPC_Oppty__c> relatedRecords = [SELECT Id FROM CN_CPPC_Oppty__c WHERE CN_Opportunity__c = :deletedCppId];
    
            for (CN_CPPC_Oppty__c record : relatedRecords) {
                recordsToDelete.add(record);
            }
        }
        if (!recordsToDelete.isEmpty()) {
            delete recordsToDelete;
        }
    }
   
}