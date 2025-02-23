/*
 * ************************************************************************************************
 * Name : CN_CR_Contact_Auto_Processing_Batch
 * Object :
 * Requirement :
 * Target :
 * Refer classes :
 * Author : Leo Dicaprio
 * Create Date : 2023/5/4
 * Modify History :
 * ************************************************************************************************
 */
global class CN_CR_Contact_Auto_Processing_Batch implements Database.Batchable<SObject>, Database.Stateful {

	public void execute(Database.BatchableContext bc, List<SObject> data) {
		List<CN_Change_Request__c> crs = (List<CN_Change_Request__c>)data;
		for (CN_Change_Request__c next : crs) {
		try{
			for(CN_Change_Request__c item:crs){
			item.CN_External_Id__c = item.CN_Contact__c;
		}
		if(crs.size()>0){
			update crs;
		}
	   }
		catch (Exception e){
			System.debug('error approval');
			System.debug(e.getMessage());
		}
			submitAndProcessApprovalRequest(next);
		}
	}

	public void finish(Database.BatchableContext bc) {

	}

	public Iterable<SObject> start(Database.BatchableContext bc) {
        RecordType recordType = [SELECT ID FROM RecordType WHERE DeveloperName = :Constants.CN_CR_RT_API_NAME_UPDATE_CONTACT].get(0);

        RecordType recordTypeAPPD = [SELECT ID FROM RecordType WHERE DeveloperName = :Constants.CN_CR_RT_API_NAME_APPD_UPDATE_CONTACT].get(0);
        
        List<CN_Change_Request__c> unapprovedCRsList  =[SELECT CN_Contact__c,Id FROM CN_Change_Request__c WHERE RecordTypeId = :recordType.ID AND CN_CR_Source__c = 'E-Commerce' AND CN_Change_Request_Status__c != 'Approved' ORDER BY CreatedDate ASC];
		
        Map<String,List<CN_Change_Request__c>> unapprovedCRsMap = new Map<String,List<CN_Change_Request__c>>();
        for(CN_Change_Request__c item :unapprovedCRsList){
				if(!(String.isEmpty(item.CN_Contact__c))){

					if(unapprovedCRsMap.get(item.CN_Contact__c)==null){
						unapprovedCRsMap.put(item.CN_Contact__c,new List<CN_Change_Request__c>());
					}
				unapprovedCRsMap.get(item.CN_Contact__c).add(item);
			}
        }
        List<CN_Change_Request__c> crsNotSyncedToSAPList = [SELECT Id, CN_Contact__c FROM CN_Change_Request__c WHERE RecordTypeId = :recordTypeAPPD.id
                                                AND CN_Change_Request_Status__c = 'Approved' 
												// add by Zhangzhihao Modify filter 2024/3/21
                                                AND CN_External_Id__c  != null 
												// add by Zhangzhihao Modify filter 2024/3/21
                                                AND CN_Contact__c = :unapprovedCRsMap.keySet()
                                                ];

        Map<String,List<CN_Change_Request__c>> crsNotSyncedToSAPMap = new Map<String,List<CN_Change_Request__c>>();
        for(CN_Change_Request__c item :crsNotSyncedToSAPList){
			if(!(String.isEmpty(item.CN_Contact__c))){
            if(crsNotSyncedToSAPMap.get(item.CN_Contact__c)==null){
                crsNotSyncedToSAPMap.put(item.CN_Contact__c,new List<CN_Change_Request__c>());
            }
            crsNotSyncedToSAPMap.get(item.CN_Contact__c).add(item);
        }
	}

	public static void  submitAndProcessApprovalRequest(CN_Change_Request__c cr) {
		// Insert an account

		// Create an approval request for the account
		try {
			System.debug('create approval');
			Approval.ProcessSubmitRequest req =
					new Approval.ProcessSubmitRequest();
			req.setComments('Auto submitting request for approval.');
			req.setObjectId(cr.id);

			// Submit the record to specific process and skip the criteria evaluation
			req.setProcessDefinitionNameOrId('CN_CR_Approve_Process_Auto');
			req.setSkipEntryCriteria(true);

			//reset flag
			CN_CR_Generate_Contact_Handler.isTriggerRun = true;
			CN_CR_Generate_ShipTo_Handler.isTriggerRun = true;
			CN_CR_Update_Sync_Status_Handler.isTriggerRun = true;
			CN_CR_Write_Back_To_Account_Handler.isTriggerRun = true;
			CN_CR_Write_Back_To_Contact_Handler.isTriggerRun = true;
			CN_CR_Write_Back_To_Shipto_Handler.isTriggerRun = true;
			CN_Lead_Owner_Changed_Custom_Notify.isTriggerRun = true;

			// Submit the approval request for the account
			Approval.ProcessResult result = Approval.process(req);

			System.debug(result);

			System.debug('finish approval');
		} catch (Exception e){
			System.debug('error approval');
			System.debug(e.getMessage());
		}

/*
		// Verify the result
		System.assert(result.isSuccess());

		System.assertEquals(
				'Pending', result.getInstanceStatus(),
						'Instance Status' + result.getInstanceStatus());

		// Approve the submitted request
		// First, get the ID of the newly created item
		List<Id> newWorkItemIds = result.getNewWorkitemIds();

		// Instantiate the new ProcessWorkitemRequest object and populate it
		Approval.ProcessWorkitemRequest req2 =
				new Approval.ProcessWorkitemRequest();
		req2.setComments('Approving request.');
		req2.setAction('Approve');
		req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});

		// Use the ID from the newly created item to specify the item to be worked
		req2.setWorkitemId(newWorkItemIds.get(0));

		// Submit the request for approval
		Approval.ProcessResult result2 = Approval.process(req2);

		// Verify the results
		System.assert(result2.isSuccess(), 'Result Status:' + result2.isSuccess());

		System.assertEquals(
				'Approved', result2.getInstanceStatus(),
						'Instance Status' + result2.getInstanceStatus());*/
	}
}