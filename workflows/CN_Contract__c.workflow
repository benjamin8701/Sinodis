<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CN_Contract_Populate_Account_Code</fullName>
        <field>CN_Account_Code__c</field>
        <formula>CN_Direct_Account_Name__r.CN_Customer_Code__c</formula>
        <name>CN_Contract_Populate_Account_Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_Contract_Populate_Account_Name</fullName>
        <field>CN_Account_Name__c</field>
        <formula>CN_Direct_Account_Name__r.Name</formula>
        <name>CN_Contract_Populate_Account_Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>CN_Contrat_Populate_AccountName</fullName>
        <actions>
            <name>CN_Contract_Populate_Account_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CN_Contract_Populate_Account_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(    $Setup.Trigger_Switcher_Setting__c.EnableFlow__c,   OR(     ISNEW(),     CN_If_Need_Populate_Account_Name__c   ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
