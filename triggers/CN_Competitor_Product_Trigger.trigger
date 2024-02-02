/**************************************************************************************************
 * Name           : Competitor_Product_Trigger
 * Object         : 
 * Requirement    : 
 * Target         : 
 * Refer classes  :
 * Author         : Zhang Zhihao
 * Create Date    : 2024-01-17
 * Modify History : 
 **************************************************************************************************/
trigger CN_Competitor_Product_Trigger on 	CN_Competitor_Product__c (before update,before insert,after update ,after insert,before delete) {
    if(Untils.isTriggerEnabled() && Constants.CN_COMPETITOR_PRODUCT_TRIGGER_ON) {
        Triggers triggersObj = new Triggers();
        if(Context.ApplyTo(Constants.CN_Code) && Constants.CN_COMPETITOR_PRODUCT_TRIGGER_ON) {
            if(Constants.CN_COMPETITOR_PRODUCT_FIELD_CHECK_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.afterUpdate, new CN_CP_Field_Check_Handler());
                triggersObj.bind(Triggers.Evt.afterInsert, new CN_CP_Field_Check_Handler());
            }
            if(Constants.CN_COMPETITOR_PRODUCT_DELETE_AND_EDIT_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.beforeDelete, new CN_CP_Delete_And_Edit_Handler());
                triggersObj.bind(Triggers.Evt.beforeUpdate, new CN_CP_Delete_And_Edit_Handler());
            }
        }
        triggersObj.execute(); 
    }
}