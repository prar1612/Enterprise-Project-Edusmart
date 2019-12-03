<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Admit_Email_Alert</fullName>
        <description>Admit Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Student_Admit_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>Send_Login_Info_to_User</fullName>
        <description>Send Login Info to User</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Student_Login_Email</template>
    </alerts>
    <rules>
        <fullName>Send Admit Email to Student</fullName>
        <actions>
            <name>Admit_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Student__c.Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Send Mail to Student User</fullName>
        <actions>
            <name>Send_Login_Info_to_User</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(User__c), User__c != NULL)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
