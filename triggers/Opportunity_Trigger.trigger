/**************************************************************************************************
 * Name           : Opportunity_Trigger
 * Object         : 
 * Requirement    : 
 * Target         : 
 * Refer classes  :
 * Author         : Du Dezheng
 * Create Date    : 2021-08-23
 * Modify History : 
 **************************************************************************************************/
//Add pre-delete quotation trigger and post-add quotation trigger 2024/2/23 by Zhang zhi hao
trigger Opportunity_Trigger on Opportunity (before insert,after insert,before delete) {
    //Add pre-delete quotation trigger and post-add quotation trigger 2024/2/23 by Zhang zhi hao
        if(Untils.isTriggerEnabled() && Constants.OP_TRIGGER_ON) {
            Triggers triggersObj = new Triggers();
            if(Context.ApplyTo(Constants.CN_Code) && Constants.CN_OP_TRIGGER_ON) {
                if(Constants.CN_OP_POPULATE_FIELDS_HANDLER_TRIGGER_ON) {
                    triggersObj.bind(Triggers.Evt.BeforeInsert, new CN_Opportunity_Populate_Fields_Handler());
                }
                //Add triggers for offers and business opportunities by Zhang zhi hao 2024/2/23
                if(Constants.CN_OP_RELATION_OPPTY_CPPC_HANDLER_TRIGGER_ON){
                    triggersObj.bind(Triggers.Evt.BeforeDelete, new CN_Oppty_Relation_Oppty_CPPC_Handler());
                    triggersObj.bind(Triggers.Evt.AfterInsert, new CN_Oppty_Relation_Oppty_CPPC_Handler());
                }
                //Add triggers for offers and business opportunities by Zhang zhi hao 2024/2/23
            }
            triggersObj.execute(); 
        }
    }