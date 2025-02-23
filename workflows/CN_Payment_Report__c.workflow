<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CN_PayReport_Populate_AR_Update_Date</fullName>
        <field>CN_AR_Update_Date__c</field>
        <formula>TODAY()</formula>
        <name>CN_PayReport_Populate_AR_Update_Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_PayReport_Populate_Account_Reminder</fullName>
        <field>CN_Sent_Reminder_Level__c</field>
        <formula>TEXT(CN_Sent_Reminder_Level__c)</formula>
        <name>CN_PayReport_Populate_Account_Reminder</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>CN_Customer__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_Payment_Report_Set_Transport_Date</fullName>
        <field>CN_Transport_Date__c</field>
        <formula>TODAY()</formula>
        <name>CN_Payment_Report_Set_Transport_Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>CN_PayReport_Populate_Account_Reminder_Level</fullName>
        <actions>
            <name>CN_PayReport_Populate_Account_Reminder</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(   $Setup.Trigger_Switcher_Setting__c.EnableFlow__c,    RecordType.DeveloperName = &apos;CN_Payment_Report&apos;,    OR(     AND(       ISNEW(),        NOT( ISBLANK(TEXT(CN_Sent_Reminder_Level__c) ) )     ),     ISCHANGED(CN_Sent_Reminder_Level__c)   ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CN_Payment_Report_Set_AR_Update_Date</fullName>
        <actions>
            <name>CN_PayReport_Populate_AR_Update_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(   $Setup.Trigger_Switcher_Setting__c.EnableValidationRule__c,   $Profile.Name = &quot;CN Finance AR&quot;,   NOT(ISNEW()) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CN_Payment_Report_Set_Transport_Date</fullName>
        <actions>
            <name>CN_Payment_Report_Set_Transport_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND($Setup.Trigger_Switcher_Setting__c.EnableValidationRule__c,  $Profile.Name = &quot;System Integration&quot; )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
