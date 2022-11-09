public with sharing class unparsedJsonDto {

    public String action;
    public String responseId;
    public Result results;

    public class Result {
        public List<LeadRecord> records;
    }
}