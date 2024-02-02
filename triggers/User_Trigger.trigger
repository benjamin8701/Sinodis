/**************************************************************************************************
 * Name           : User_Trigger
 * Object         : 
 * Requirement    : 
 * Target         : 
 * Refer classes  :
 * Author         : Zhang ZhiHao
 * Create Date    : 2024-01-24
 * Modify History : 
 **************************************************************************************************/
trigger User_Trigger on User (before update,after update) {
    if(Untils.isTriggerEnabled() && Constants.USER_TRIGGER_ON) {
        Triggers triggersObj = new Triggers();
        if(Context.ApplyTo(Constants.CN_Code) && Constants.USER_TRIGGER_ON) {
            if(Constants.CN_USER_FIELD_EDIT_EMAIL_HANDLER_TRIGGER_ON) {
                triggersObj.bind(Triggers.Evt.beforeUpdate, new CN_User_Field_Edit_Email_Handler());
                triggersObj.bind(Triggers.Evt.afterUpdate, new CN_User_Field_Edit_Email_Handler());
            }
        }
        triggersObj.execute(); 
    }
}