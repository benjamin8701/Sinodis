/**************************************************************************************************
 * Name           : Account_Trigger
 * Object         : Account
 * Requirement    : 
 * Target         : 
 * Refer classes  :
 * Author         : Qiu Chen
 * Create Date    : 2021-04-29
 * Modify History : 
 **************************************************************************************************/
trigger Account_Trigger on Account (before insert, after insert, after update, before update,before delete) {
    if(Untils.isTriggerEnabled() && Constants.ACCOUNT_TRIGGER_ON) {
        Triggers triggersObj = new Triggers();
        if(Context.ApplyTo(Constants.CN_Code) && Constants.CN_ACCOUNT_TRIGGER_ON) {
            if(Constants.CN_ACCOUNT_GENERATE_SHIPTO_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.afterinsert, new CN_Account_Generate_ShipTo_Handler());
            }
            if(Constants.CN_ACCOUNT_SYNC_SALESPERSON_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.BeforeUpdate, new CN_Account_Populate_Fields_Handler());
                triggersObj.bind(Triggers.Evt.BeforeInsert, new CN_Account_Populate_Fields_Handler());
            }
            if(Constants.CN_ACCOUNT_POPULATE_APPROVER_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.beforeInsert, new CN_Account_Populate_Approver_Handler());
                triggersObj.bind(Triggers.Evt.beforeUpdate, new CN_Account_Populate_Approver_Handler());
            }
            if(Constants.CN_ACCOUNT_PREVENT_DELETE_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.BeforeDelete, new CN_Account_Prevent_Delete_Handler());
            }
            if(Constants.CN_ACCOUNT_APPROVE_AGING_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.BeforeUpdate, new CN_Account_Approve_Aging_Handler());
            }
            if(Constants.CN_ACCOUNT_GENERATE_DOCUMENTS_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.AfterInsert, new CN_Account_Generate_Documents_Handler());
                triggersObj.bind(Triggers.Evt.AfterUpdate, new CN_Account_Generate_Documents_Handler());
            }
            if(Constants.CN_ACCOUNT_ADDRESS_CHANGE_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.BeforeInsert, new CN_Account_Address_Change_Handler());
                triggersObj.bind(Triggers.Evt.BeforeUpdate, new CN_Account_Address_Change_Handler());
            }
            //CR05 – Tm report by Shuqi - start
            if(Constants.CN_ACCOUNT_TM_REPORT_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.BeforeUpdate, new CN_Account_TM_REPORT_Handler());
            }
            //CR05 – Tm report by Shuqi - end
            //20211130 – CR By  Dezheng - start
            if(Constants.CN_ACCOUNT_PREVENT_EDIT_APPROVED_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.BeforeUpdate, new CN_Account_Prevent_Edit_Approved_Handler());
            }
            //20211130 – CR By  Dezheng - endt

            //add by Leo Dicaprio 2023-04-07 start
            if(Constants.CN_ACCOUNT_SEND_MG_MARK_HANDLER_TRIGGER_ON){
                triggersObj.bind(Triggers.Evt.BeforeInsert,new CN_Account_Send_MG_Mark_Handler());
                triggersObj.bind(Triggers.Evt.BeforeUpdate,new CN_Account_Send_MG_Mark_Handler());
            }
            //add by Leo Dicaprio 2023-04-07 end
        }
        triggersObj.execute(); 
    }
}