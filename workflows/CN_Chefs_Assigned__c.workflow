<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CN_Chefs_Assigned_Set_Unique_Id</fullName>
        <field>CN_External_Id__c</field>
        <formula>CASESAFEID( CN_Chef_Request__c ) + &quot;-&quot; +  CASESAFEID( CN_Chef__c )</formula>
        <name>CN_Chefs_Assigned_Set_Unique_Id</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>CN_Chefs_Assigned_Set_Unique_ID</fullName>
        <actions>
            <name>CN_Chefs_Assigned_Set_Unique_Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND($Setup.Trigger_Switcher_Setting__c.EnableFlow__c , 
 OR(ISNEW() || ISCHANGED(  CN_Chef__c ) )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
