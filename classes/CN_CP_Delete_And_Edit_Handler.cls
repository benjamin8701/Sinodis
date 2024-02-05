/**************************************************************************************************
 * Name           : CN_CP_Delete_And_Edit_Handler
 * Object         : 
 * Requirement    : 
 * Target         : 
 * Refer classes  :
 * Author         : Zhang ZhiHao
 * Create Date    : 2024-1-31
 * Modify History : 
 **************************************************************************************************/
public without sharing class CN_CP_Delete_And_Edit_Handler implements Triggers.Handler {
    public void handle() {
		if(Trigger.isBefore && Trigger.isUpdate) {
            handleBeforeUpdate();
        }
        if(Trigger.isBefore && Trigger.isDelete){
            handleBeforeDelete();
        }
    }

    public void handleBeforeUpdate(){
        for (CN_Competitor_Product__c cp : (List<CN_Competitor_Product__c>) Trigger.new) {
            if (cp.OwnerId != UserInfo.getUserId()) {
                cp.addError(system.Label.CN_Competitor_Product_Update_Message);
            }
    }
}

    public void handleBeforeDelete(){
        for (CN_Competitor_Product__c cp : (List<CN_Competitor_Product__c>) Trigger.old) {
        Set<Id> priceToCustomerIds = new Set<Id>();
        for (CN_Competitor_Product_Price_to_Customer__c priceToCustomer : [SELECT Id FROM CN_Competitor_Product_Price_to_Customer__c
                                                                           WHERE CN_Competitor__c = :cp.id]){
            priceToCustomerIds.add(priceToCustomer.Id);
        }
        if (!priceToCustomerIds.isEmpty()){
            cp.AddError(system.Label.CN_Competitor_Product_Delte_Message  );
        }
    }


}
}