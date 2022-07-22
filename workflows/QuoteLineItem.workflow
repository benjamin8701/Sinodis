<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>CN_QuoteItem_Clear_DenyReason</fullName>
        <field>CN_Denied_Reason__c</field>
        <name>CN_QuoteItem_Clear_DenyReason</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_QuoteItem_Populate_Channel_Price_VAT</fullName>
        <field>CN_Channel_Price_VAT__c</field>
        <formula>CN_Channel_Price__c * ( 1 + VALUE(LEFT(CN_Tax_Formula__c,LEN(CN_Tax_Formula__c)-1))/100)</formula>
        <name>CN_QuoteItem_Populate_Channel_Price_VAT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_QuoteItem_Populate_ExternalId</fullName>
        <field>CN_External_Id__c</field>
        <formula>CASESAFEID(Product2Id)   &amp; &apos;-&apos; &amp;  CASESAFEID(QuoteId)</formula>
        <name>CN_QuoteItem_Populate_ExternalId</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_QuoteItem_Populate_List_Price_VAT</fullName>
        <field>CN_List_Price_VAT__c</field>
        <formula>CN_List_Price__c * ( 1 + VALUE(LEFT(CN_Tax_Formula__c,LEN(CN_Tax_Formula__c)-1))/100)</formula>
        <name>CN_QuoteItem_Populate_List_Price_VAT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_QuoteItem_Populate_Origin</fullName>
        <field>CN_Origin_PDF__c</field>
        <formula>Text(Product2.CN_Origin__c)</formula>
        <name>CN_QuoteItem_Populate_Origin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_QuoteItem_Populate_QTYPerCTN</fullName>
        <field>CN_QTY_PER_CTN_PDF__c</field>
        <formula>Product2.CN_Qty_per_Carton_PDF__c</formula>
        <name>CN_QuoteItem_Populate_QTYPerCTN</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CN_QuoteItem_Populate_Tax</fullName>
        <field>CN_Tax__c</field>
        <formula>CN_Tax_Formula__c</formula>
        <name>CN_QuoteItem_Populate_Tax</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>CN_QuoteItem_Clear_DenyReason</fullName>
        <actions>
            <name>CN_QuoteItem_Clear_DenyReason</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(   $Setup.Trigger_Switcher_Setting__c.EnableFlow__c ,    ISCHANGED( CN_Customer_Acceptance__c ),   ISPICKVAL(CN_Customer_Acceptance__c , &quot;Accepted&quot;) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CN_QuoteItem_Populate_Origin</fullName>
        <actions>
            <name>CN_QuoteItem_Populate_Origin</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(   $Setup.Trigger_Switcher_Setting__c.EnableFlow__c  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>CN_QuoteItem_Populate_Price</fullName>
        <actions>
            <name>CN_QuoteItem_Populate_Channel_Price_VAT</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>CN_QuoteItem_Populate_List_Price_VAT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(   $Setup.Trigger_Switcher_Setting__c.EnableFlow__c  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>CN_QuoteItem_Populate_QTYPerCTN</fullName>
        <actions>
            <name>CN_QuoteItem_Populate_QTYPerCTN</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( $Setup.Trigger_Switcher_Setting__c.EnableFlow__c )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>CN_QuoteItem_Populate_Tax</fullName>
        <actions>
            <name>CN_QuoteItem_Populate_Tax</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(   $Setup.Trigger_Switcher_Setting__c.EnableFlow__c  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>CN_QuoteItem_Prevent_Dupilcate</fullName>
        <actions>
            <name>CN_QuoteItem_Populate_ExternalId</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(        $Setup.Trigger_Switcher_Setting__c.EnableFlow__c,     OR(         ISNEW(),         AND(           NOT(ISNEW()),           ISCHANGED( Product2Id )         )     ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
