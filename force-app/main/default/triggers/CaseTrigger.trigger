trigger CaseTrigger on Case (after insert) {
    CaseTriggerHandler.updateAccLatestCasNum(Trigger.New);

}