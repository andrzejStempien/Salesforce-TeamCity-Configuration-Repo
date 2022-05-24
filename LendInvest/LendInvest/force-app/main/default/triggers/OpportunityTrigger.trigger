trigger OpportunityTrigger on Opportunity (before insert, before update) {
    Contact twilloNumber = [SELECT Id, Phone FROM Contact WHERE LastName = 'Twillo' LIMIT 1];

	for(Opportunity opp : Trigger.New) {
        //if (opp.StageName == 'Closed Won') { //opp.Account.CustomerLoyaltyRating__c == 'GOLD' && 
            TwilioSF.TwilioApiClient client = new TwilioSF.TwilioApiClient();

            client.addParam('To','+447719299511');
            client.addParam('From', '+441274015694');
            client.addParam('Body','Opportunity with Id ' + opp.Id + ' is Closed Won');

            TwilioSF.TwilioApiClientResponse response = client.doPut();
            system.debug(response.hasError());
            system.debug(response.getErrorMessage());
        //}
    }

    

}