@isTest
private class LoggerServiceTest {

    @isTest
    static void itLogsInfoMessagesWithoutError() {
        Test.startTest();
        LoggerService.info('LoggerServiceTest', 'Sample info message');
        Test.stopTest();

        // No assertion target other than confirming no exception is thrown,
        // since this utility only writes debug statements.
        System.assert(true, 'info() should execute without throwing');
    }

    @isTest
    static void itLogsErrorMessagesWithException() {
        Exception dummy;
        try {
            Integer x = 1 / 0;
        } catch (Exception e) {
            dummy = e;
        }

        Test.startTest();
        LoggerService.error('LoggerServiceTest', 'Sample error message', dummy);
        Test.stopTest();

        System.assert(true, 'error() should execute without throwing');
    }
}
