/**************************************************************************************************
 * Name           : CN_Chefs_Assigned_Trigger
 * Object         : 
 * Requirement    : 
 * Target         : 
 * Refer classes  :
 * Author         : Qiu Chen
 * Create Date    : 2021-07-28
 * Modify History : 
 **************************************************************************************************/
trigger CN_Chefs_Assigned_Trigger on CN_Chefs_Assigned__c (after insert, after update, before delete, after delete, after undelete) {
    if(Untils.isTriggerEnabled() && Constants.CHEFS_ASSIGNED_TRIGGER_ON) {
        Triggers triggersObj = new Triggers();
        if(Context.ApplyTo(Constants.CN_Code) && Constants.CN_CHEFS_ASSIGNED_TRIGGER_ON) {
            if(Constants.CN_CHEFS_ASSIGNED_PREVENT_DELETE_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.BeforeDelete, new CN_Chefs_Assigned_Prevent_Delete_Handler());
            }
            if(Constants.CN_CHEFS_ASSIGNED_RESET_WORKDATE_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.AfterUpdate, new CN_Chef_Assigned_Reset_WorkDate_Handler());
            }
            if(Constants.CN_CHEFS_ASSIGNED_CHEF_UT_OFF_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.AfterInsert, new CN_Chefs_Assigned_Chef_UT_OFF_Handler());
                triggersObj.bind(Triggers.Evt.AfterDelete, new CN_Chefs_Assigned_Chef_UT_OFF_Handler());
                triggersObj.bind(Triggers.Evt.AfterUndelete, new CN_Chefs_Assigned_Chef_UT_OFF_Handler());
            }
            if(Constants.CN_CHEFS_ASSIGNED_CHEF_UT_ITEM_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.AfterInsert, new CN_Chefs_Assigned_Chef_UT_Item_Handler());
                triggersObj.bind(Triggers.Evt.AfterUpdate, new CN_Chefs_Assigned_Chef_UT_Item_Handler());
                triggersObj.bind(Triggers.Evt.BeforeDelete, new CN_Chefs_Assigned_Chef_UT_Item_Handler());
                triggersObj.bind(Triggers.Evt.AfterUndelete, new CN_Chefs_Assigned_Chef_UT_Item_Handler());
            }
        }
        triggersObj.execute(); 
    }
}