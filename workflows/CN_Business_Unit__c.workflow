<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CN_BU_Clear_SyncTime</fullName>
        <field>CN_Sync_Time__c</field>
        <name>CN_BU_Clear_SyncTime</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_BU_Clear_Sync_Error</fullName>
        <field>CN_Sync_Error_Message__c</field>
        <name>CN_BU_Clear_Sync_Error</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_BU_Clear_Sync_Status</fullName>
        <field>CN_Sync_Status__c</field>
        <name>CN_BU_Clear_Sync_Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>CN_BU_Clear_Sync_Fields</fullName>
        <actions>
            <name>CN_BU_Clear_SyncTime</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CN_BU_Clear_Sync_Error</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CN_BU_Clear_Sync_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When edit the business unit ,clear sync fields.</description>
        <formula>AND(
  $Setup.Trigger_Switcher_Setting__c.EnableFlow__c, 
  RecordType.DeveloperName = &quot;CN_Business_Unit&quot;,
  NOT(ISNEW()), 
  NOT(ISBLANK(TEXT(CN_Sync_Status__c) )),
   OR( 
ISCHANGED(Name),
ISCHANGED(CN_City_API__c)
)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
