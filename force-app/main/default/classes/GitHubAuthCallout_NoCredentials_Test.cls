@IsTest
public with sharing class GitHubAuthCallout_NoCredentials_Test {
    @isTest
    private static void callGitHub_Test(){
        GitHubAuthCallout_NoCredential.callGitHub();
    }
}
