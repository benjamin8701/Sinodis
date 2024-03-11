/**************************************************************************************************
 * Name           : CPP_Trigger
 * Object         : 
 * Requirement    : 
 * Target         : 
 * Refer classes  :
 * Author         : Zhang Zhihao
 * Create Date    : 2024-01-17
 * Modify History : 
 **************************************************************************************************/
trigger CN_CPP_Trigger on 	CN_Competitor_Product_Price_to_Customer__c (before update,before insert,after update ,after insert,before delete) {
    if(Untils.isTriggerEnabled() && Constants.CPP_TRIGGER_ON) {
        Triggers triggersObj = new Triggers();
        if(Context.ApplyTo(Constants.CN_Code) && Constants.CN_CPP_TRIGGER_ON) {
            if(Constants.CN_CPP_ACCOUNT_NAME_ASSIGNMENT_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.beforeUpdate, new CN_CPP_Acount_Name_Assignment_Handler());
                triggersObj.bind(Triggers.Evt.beforeInsert, new CN_CPP_Acount_Name_Assignment_Handler());
            }
            if(Constants.CN_CPP_FIELD_CHECK_HANDLER_TRIGGER_ON){
                triggersObj.bind(Triggers.Evt.AfterUpdate, new CN_CPP_Field_Check_Handler());
                triggersObj.bind(Triggers.Evt.AfterInsert, new CN_CPP_Field_Check_Handler());
            }
            //add by Zhang Zhihao Operation intermediate table by 2024/2/24
            if(Constants.CN_CPP_Relation_CPPC_Oppty_Handler_TRIGGER_ON){
                triggersObj.bind(Triggers.Evt.BeforeDelete, new CN_CPP_Relation_CPPC_Oppty_Handler());
                triggersObj.bind(Triggers.Evt.AfterInsert, new CN_CPP_Relation_CPPC_Oppty_Handler());
            }
            if(Constants.CN_CPP_Relation_CPPC_Quote_Handler_TRIGGER_ON){
                triggersObj.bind(Triggers.Evt.BeforeDelete, new CN_CPP_Relation_CPPC_Quote_Handler());
                triggersObj.bind(Triggers.Evt.AfterInsert, new CN_CPP_Relation_CPPC_Quote_Handler());
            }
           //add by Zhang Zhihao Operation intermediate table by 2024/2/24
        }
        triggersObj.execute(); 
    }
}