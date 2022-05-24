public without sharing class LwcController{

    @AuraEnabled
    public static void sendMessage(String textValue, Id recordId){
        try {
            System.debug('textValue ' + textValue);
            System.debug('recordId ' + recordId);

            TwilioSF.TwilioApiClient client = new TwilioSF.TwilioApiClient();
            Account acc = [SELECT Id, Phone FROM Account WHERE Id = :recordId];

            System.debug('acc.Phone ' + acc.Phone);

            client.addParam('To', acc.Phone);
            client.addParam('From', '+441274015694');
            client.addParam('Body', textValue);

            TwilioSF.TwilioApiClientResponse response = client.doPut();
            system.debug(response.hasError());
            system.debug(response.getErrorMessage());
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}