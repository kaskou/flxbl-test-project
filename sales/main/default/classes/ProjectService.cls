/**
 * Domain service for the sales package. Depends on the core-crm package
 * (Project__c) and the frameworks package (LoggerService), demonstrating
 * cross-package dependencies in a flxbl mono-repo.
 */
public with sharing class ProjectService {

    public static List<Project__c> createProjects(List<String> projectNames) {
        List<Project__c> projects = new List<Project__c>();

        for (String name : projectNames) {
            projects.add(new Project__c(
                Name = name,
                Status__c = 'Planning'
            ));
        }

        try {
            insert projects;
            LoggerService.info('ProjectService', 'Created ' + projects.size() + ' project(s)');
        } catch (DmlException ex) {
            LoggerService.error('ProjectService', 'Failed to create projects', ex);
            throw ex;
        }

        return projects;
    }

    public static void markCompleted(Id projectId) {
        Project__c project = new Project__c(
            Id = projectId,
            Status__c = 'Completed'
        );

        try {
            update project;
            LoggerService.info('ProjectService', 'Marked project ' + projectId + ' as Completed');
        } catch (DmlException ex) {
            LoggerService.error('ProjectService', 'Failed to update project ' + projectId, ex);
            throw ex;
        }
    }
}
