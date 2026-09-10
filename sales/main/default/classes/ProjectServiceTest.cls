@isTest
private class ProjectServiceTest {

    @isTest
    static void itCreatesProjectsWithPlanningStatus() {
        Test.startTest();
        List<Project__c> created = ProjectService.createProjects(
            new List<String>{ 'Website Revamp', 'CRM Migration' }
        );
        Test.stopTest();

        System.assertEquals(2, created.size(), 'Should create two projects');

        List<Project__c> inserted = [
            SELECT Id, Name, Status__c
            FROM Project__c
            WHERE Id IN :created
        ];
        System.assertEquals(2, inserted.size(), 'Both projects should be persisted');
        for (Project__c p : inserted) {
            System.assertEquals('Planning', p.Status__c, 'New projects should default to Planning');
        }
    }

    @isTest
    static void itMarksAProjectAsCompleted() {
        Project__c project = new Project__c(Name = 'Data Cleanup', Status__c = 'In Progress');
        insert project;

        Test.startTest();
        ProjectService.markCompleted(project.Id);
        Test.stopTest();

        Project__c updated = [SELECT Status__c FROM Project__c WHERE Id = :project.Id];
        System.assertEquals('Completed', updated.Status__c, 'Project should be marked Completed');
    }
}
