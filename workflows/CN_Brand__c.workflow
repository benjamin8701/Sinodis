<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CN_Brand_Clear_Sync_Error</fullName>
        <field>CN_Sync_Error_Message__c</field>
        <name>CN_Brand_Clear_Sync_Error</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_Brand_Clear_Sync_Status</fullName>
        <field>CN_Sync_Status__c</field>
        <name>CN_Brand_Clear_Sync_Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_Brand_Clear_Sync_Time</fullName>
        <field>CN_Sync_Time__c</field>
        <name>CN_Brand_Clear_Sync_Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_Brand_Populate_Fields</fullName>
        <field>CN_Group_Code_Name__c</field>
        <formula>CN_Group__r.CN_Group_Code__c  + &apos; &apos; +  CN_Group__r.Name</formula>
        <name>CN_Brand_Populate_Fields</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>CN_Brand_Clear_Sync_Fields</fullName>
        <actions>
            <name>CN_Brand_Clear_Sync_Error</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CN_Brand_Clear_Sync_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CN_Brand_Clear_Sync_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
  $Setup.Trigger_Switcher_Setting__c.EnableFlow__c, 
  RecordType.DeveloperName = &quot;CN_Brand&quot;,
  NOT(ISNEW()), 
  NOT(ISBLANK(TEXT(CN_Sync_Status__c) )),
  OR(
    ISCHANGED(Name), 
    ISCHANGED( CN_Group__c ), 
    ISCHANGED( CN_City_API__c )
  )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CN_Brand_Populate_Fields</fullName>
        <actions>
            <name>CN_Brand_Populate_Fields</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISNEW() || ISCHANGED( CN_Group__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
