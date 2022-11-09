global with sharing class updateLeadWithDatabrickBatch implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator( 'SELECT Id, City, Company, ZoomInfo_Databrick__c FROM Lead' );
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope){
        Map<Id, LeadRecord> leadRecordMap = setLeadRecords();

        List<Lead> leadsToUpdate = new List<Lead>();
        for (Lead lead : scope) {
            if (leadRecordMap.containsKey(lead.Id)) {
                lead.ZoomInfo_Databrick__c = '123';
                leadsToUpdate.add(lead);
            }
        }
        update leadsToUpdate;
    }

    global void finish(Database.BatchableContext bc) {}

    public Map<Id, LeadRecord> setLeadRecords() {
        Wave.ProjectionNode[] projs = new Wave.ProjectionNode[]{
                Wave.QueryBuilder.get('Id')};
        ConnectApi.LiteralJson result = Wave.QueryBuilder.loadByDeveloperName('LeadsWithDatabricks')
                .foreach(projs)
                .execute('q');
        String response = result.json;
        unparsedJsonDto aaa = (unparsedJsonDto)JSON.deserialize(response, unparsedJsonDto.class);

        Map<Id, LeadRecord> leadRecordMap = new Map<Id, LeadRecord>();
        for (LeadRecord leadRecord : aaa.results.records) {
            leadRecordMap.put(leadRecord.Id, leadRecord);
        }
        return leadRecordMap;
    }
}