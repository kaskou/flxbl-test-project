/**
 * Minimal logging utility used across domain packages.
 * Kept intentionally simple for demo/test purposes.
 */
public with sharing class LoggerService {

    public static void info(String source, String message) {
        System.debug(LoggingLevel.INFO, '[' + source + '] ' + message);
    }

    public static void error(String source, String message, Exception ex) {
        String detail = message;
        if (ex != null) {
            detail += ' | Exception: ' + ex.getMessage();
        }
        System.debug(LoggingLevel.ERROR, '[' + source + '] ' + detail);
    }
}
