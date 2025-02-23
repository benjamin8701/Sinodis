/**************************************************************************************************
 * Name           : CN_Complaint_Closed_LC_Ctrl
 * Object         : 
 * Requirement    : 
 * Target         : 
 * Refer classes  :
 * Author         : Dezheng Du
 * Create Date    : 2021-08-17
 * Modify History : 
 **************************************************************************************************/
public without sharing class CN_Complaint_Closed_LC_Ctrl {
    @auraEnabled
    public static Map<String, Object> updateStatusToClosed(String recordId,String feedBack) {
        String errorMessage = '';

        if(String.isBlank(recordId)) {
            throw new AuraHandledException(System.Label.CN_Complaint_Not_Found);
        }
        Boolean hasCreatePermission = Untils.checkObjectCreatePermission('Case');
        if(!hasCreatePermission) {
            throw new AuraHandledException(System.Label.CN_Complaint_No_Permission);
        }
        List<Case> compList = [SELECT Id,
                                        //Add by Zhang Zhihao 2023/1/14  Query submitter
                                        CN_Submitter__c,
                                        //Add by Zhang Zhihao 2023/1/14  Query submitter
                                        CreatedById,
                                        Status,
                                        CN_Closed_Button__c
                                    FROM Case
                                    WHERE Id =: recordId];
        if(compList.isEmpty()) {
            throw new AuraHandledException(System.Label.CN_Complaint_Not_Found);
        }
        Case caseToUpdate = compList[0];
        //Add by Zhang Zhihao 2023/1/14  The current user is the committer
        //Add by He Peng 2023/1/23  rejected => closed
        if( (Constants.CN_CA_STATUS_RESOLVED.equals(caseToUpdate.Status) ||
        Constants.CN_CA_STATUS_REJECTED.equals(caseToUpdate.Status))
            && userinfo.getUserId() == caseToUpdate.CN_Submitter__c) 
            //&& userinfo.getUserId() == caseToUpdate.CreatedById)
        {
            caseToUpdate.Status = Constants.CN_CA_STATUS_CLOSED;
            caseToUpdate.CN_Closed_Button__c = true;
            caseToUpdate.CN_CS_Feedback__c = feedBack;
        }else{
            throw new AuraHandledException(System.Label.CN_Complaint_Can_Not_Closed);
        }
        try{
            update caseToUpdate;
        }catch(exception ex){
            throw new AuraHandledException(ex.getMessage());
        }
        
        return new Map<String, Object>{
            'errorMessage' => errorMessage
        };
    }
    
}