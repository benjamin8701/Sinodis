<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CN_SR_Approved</fullName>
        <description>CN_SR_Approved</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CN_Email_Folder/CN_Sample_Request_Approved</template>
    </alerts>
    <alerts>
        <fullName>CN_SR_Approved_Process_CS</fullName>
        <description>CN_SR_Approved_Process_CS</description>
        <protected>false</protected>
        <recipients>
            <field>CN_CS_Team_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CN_Email_Folder/CN_Sample_Request_Approved_Process_CS</template>
    </alerts>
    <alerts>
        <fullName>CN_SR_Rejected</fullName>
        <description>CN_SR_Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CN_Email_Folder/CN_Sample_Request_Rejected</template>
    </alerts>
    <alerts>
        <fullName>CN_Sample_Request_Approval</fullName>
        <description>CN_Sample_Request_Approval</description>
        <protected>false</protected>
        <recipients>
            <field>CN_Approver1_CCE__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CN_Email_Folder/CN_Sample_Request_Submit</template>
    </alerts>
    <alerts>
        <fullName>CN_Sample_Request_Approved_Cancelled</fullName>
        <description>CN_Sample_Request_Approved_Cancelled</description>
        <protected>false</protected>
        <recipients>
            <field>CN_CCE_Team_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>CN_CS_Team_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CN_Email_Folder/CN_Sample_Request_Approved_Cancelled</template>
    </alerts>
    <alerts>
        <fullName>CN_Sample_Request_Approved_Process_CCE</fullName>
        <description>CN_Sample_Request_Approved_Process_CCE</description>
        <protected>false</protected>
        <recipients>
            <field>CN_CCE_Team_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CN_Email_Folder/CN_Sample_Request_Approved_Process_CCE</template>
    </alerts>
    <fieldUpdates>
        <fullName>CN_SR_Update_Approved_Date</fullName>
        <field>CN_Approved_Date__c</field>
        <formula>NOW()</formula>
        <name>CN_SR_Update_Approved_Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_SR_Update_Status_Approved</fullName>
        <field>CN_Sample_Request_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>CN_SR_Update_Status_Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_SR_Update_Status_Recalled</fullName>
        <field>CN_Sample_Request_Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>CN_SR_Update_Status_Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_SR_Update_Status_Rejected</fullName>
        <field>CN_Sample_Request_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>CN_SR_Update_Status_Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_SR_Update_Status_Submit</fullName>
        <field>CN_Sample_Request_Status__c</field>
        <literalValue>Submitted for Approval</literalValue>
        <name>CN_SR_Update_Status_Submit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>CN_SR_Populate_Approver1_CCE1</fullName>
        <active>false</active>
        <formula>AND($Setup.Trigger_Switcher_Setting__c.EnableFlow__c, NOT(ISBLANK(CN_Account_Name__c)), 
ISCHANGED(CN_Account_Name__c), 
CN_Account_Name__r.CN_Sales_Team_UI__r.Name == &apos;KA&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
