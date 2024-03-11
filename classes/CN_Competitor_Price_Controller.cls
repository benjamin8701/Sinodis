/*
 * ************************************************************************************************
 * Name : CN_Competitor_Price_Controller
 * Description :
 * Object :
 * Requirement :
 * Target :
 * Refer classes :
 * Author : Leo Dicaprio
 * Create Date : 2023/8/28
 * Modify History :
 * ************************************************************************************************
 */
public  class CN_Competitor_Price_Controller {

	@AuraEnabled
	public static String getRelatedPrice(String recordId) {
		//add by ZhangZhihao  Retrieves the set of permissions that can be viewed 2024/2/29
		Set<String> salesProfileSet = new Set<String>(Constants.CN_PROFILE_NAME_SALES_STRING_LIST.split(','));
		//add by ZhangZhihao Retrieves the set of permissions that can be viewed 2024/2/29
		//add by ZhangZhihao  Marketing does not see the List Price 2024/3/1
		Set<String> marketingNotVisibleChannels = new Set<String>(Constants.CN_MARKETING_OUT_CHANNEL.split(','));
		//add by ZhangZhihao  Marketing does not see the List Price 2024/3/1
		List<Profile> profileList = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
		String userProfileName = profileList[0].Name;
		
		CN_Sales_Team__c salesTeam = new CN_Sales_Team__c();
		//add by ZhangZhihao  See if it contains 2024/2/29
		if (salesProfileSet.contains(userProfileName)) {
			//add by ZhangZhihao  See if it contains 2024/2/29
			User user = [SELECT Id, CN_Sales_Team__c,Name FROM User WHERE Id = :UserInfo.getUserId()];
			if(user != null && user.CN_Sales_Team__c != null){
				List<CN_Sales_Team__c> salesTeamList = [SELECT Id, CN_Sales_Team_Code__c,Name FROM CN_Sales_Team__c WHERE CN_Sales_Team_Code__c = :user.CN_Sales_Team__c];
				if (salesTeamList != null && salesTeamList.size() > 0) {
					salesTeam = salesTeamList.get(0);
				}

			}

		}
		System.debug(JSON.serialize(salesTeam));
		System.debug(salesTeam.Name);

		//
		List<CompetitorProductPrice> listResult = new List<CompetitorProductPrice>();

		Map<String, List<CN_Competitor_Product__c>> cppMap = new Map<String, List<CN_Competitor_Product__c>>();

		List<CN_Competitor_Product__c> l = [SELECT Id, Name, CN_Product__r.Name, CN_Product__c FROM CN_Competitor_Product__c WHERE Id = :recordId];

		List<String> productIdList = new List<String>();
		for (CN_Competitor_Product__c next : l) {
			List<CN_Competitor_Product__c> productMap = cppMap.get(next.Id);
			if (productMap == null) {
				cppMap.put(next.CN_Product__c, new List<CN_Competitor_Product__c>());
				productMap = cppMap.get(next.CN_Product__c);
			}
			productMap.add(next);
			productIdList.add(next.CN_Product__c);
		}

		//add by Zhange ZhiHao 2024/3/8
		List<PricebookEntry> pricebookEntryList = [SELECT Id, Pricebook2.CN_Channel__c,Pricebook2.Name, UnitPrice, CN_Discount_Price__c, Product2Id FROM PricebookEntry WHERE Product2Id IN :productIdList];
		//add by Zhange ZhiHao 2024/3/8
		for (PricebookEntry item : pricebookEntryList) {
			List<CN_Competitor_Product__c> lists = cppMap.get(item.Product2Id);
			if (lists == null) {
				continue;
			}

			if (salesTeam.Name == null || item.Pricebook2.CN_Channel__c == salesTeam.Name) {
				for (CN_Competitor_Product__c next : lists) {
					CompetitorProductPrice cpp = new CompetitorProductPrice();
					//add by Zhange ZhiHao 2024/3/8
					cpp.Channel = item.Pricebook2.Name;
					//add by Zhange ZhiHao 2024/3/8
					cpp.Price = String.valueOf(item.UnitPrice);
					//add by ZhangZhihao  Marketing does not see the List Price 2024/3/1
					if(Constants.CN_PROFILE_NAME_MKT.equals(userProfileName)&&marketingNotVisibleChannels.contains(cpp.Channel)){
						continue;
					}
					//add by ZhangZhihao  Marketing does not see the List Price 2024/3/1
					listResult.add(cpp);
				}
			}
		}
		System.debug('listResult==>'+listResult);
		return JSON.serialize(listResult);
		
	}

	private class CompetitorProductPrice{
		String Channel;
		String Price;
		String Alert;
		String Priority;
	}

}