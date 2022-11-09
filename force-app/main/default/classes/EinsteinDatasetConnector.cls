public with sharing class EinsteinDatasetConnector {

    public void syncContactsWithNetSuite(String datasetName, String contactIdColumn, String netsuiteColumn) {
        // Build and execute query
        Wave.ProjectionNode[] projections = new Wave.ProjectionNode[]{
                Wave.QueryBuilder.get('\'' + String.escapeSingleQuotes(contactIdColumn) + '\'')
                        .alias(Contact.Id.getDescribe().getName()),
                Wave.QueryBuilder.get('\'' + String.escapeSingleQuotes(netsuiteColumn) + '\'')
                        .alias(Contact.NetSuite_Custom_Field__c.getDescribe().getName())
        };
        ConnectApi.LiteralJson result = Wave.QueryBuilder.loadByDeveloperName(datasetName)
                .foreach(projections)
                .cap(Limits.getLimitDmlStatements())
                .execute('q');
        String response = result.json;
        // Parse JSON response
        List<Contact> records = MyUtility.jsonParseOutContactData(response);
        // Update all records
        Database.update(records, false);
    }
}