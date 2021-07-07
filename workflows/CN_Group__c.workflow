<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CN_Group_Clear_Sync_Error</fullName>
        <field>CN_Sync_Error_Message__c</field>
        <name>CN_Group_Clear_Sync_Error</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_Group_Clear_Sync_Status</fullName>
        <field>CN_Sync_Status__c</field>
        <name>CN_Group_Clear_Sync_Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_Group_Clear_Sync_Time</fullName>
        <field>CN_Sync_Time__c</field>
        <name>CN_Group_Clear_Sync_Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_Group_Populate_Search_Key</fullName>
        <field>CN_Sales_Team_Code_Name__c</field>
        <formula>CN_Sales_Team__r.CN_Sales_Team_Code__c + &apos; &apos; + CN_Sales_Team__r.Name</formula>
        <name>CN_Group_Populate_Search_Key</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>CN_Group_Clear_Sync_Fields</fullName>
        <actions>
            <name>CN_Group_Clear_Sync_Error</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CN_Group_Clear_Sync_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CN_Group_Clear_Sync_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
  $Setup.Trigger_Switcher_Setting__c.EnableFlow__c, 
  RecordType.DeveloperName = &quot;CN_Group&quot;,
  NOT(ISNEW()), 
  NOT(ISBLANK(TEXT(CN_Sync_Status__c) )),
  OR(
    ISCHANGED(Name), 
    ISCHANGED( CN_Sales_Team__c ), 
    ISCHANGED( CN_City_API__c )
  )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CN_Group_Populate_Fields</fullName>
        <actions>
            <name>CN_Group_Populate_Search_Key</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISNEW() ||  ISCHANGED( CN_Sales_Team__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
