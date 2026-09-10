/**
 * Lightweight base class for implementing the Trigger Handler pattern.
 * Domain packages extend this class and override the relevant context
 * methods instead of writing logic directly inside trigger bodies.
 */
public virtual class TriggerHandler {

    public void run() {
        if (!Trigger.isExecuting) {
            return;
        }

        if (Trigger.isBefore && Trigger.isInsert) {
            beforeInsert(Trigger.new);
        } else if (Trigger.isBefore && Trigger.isUpdate) {
            beforeUpdate(Trigger.new, Trigger.oldMap);
        } else if (Trigger.isBefore && Trigger.isDelete) {
            beforeDelete(Trigger.old, Trigger.oldMap);
        } else if (Trigger.isAfter && Trigger.isInsert) {
            afterInsert(Trigger.new, Trigger.newMap);
        } else if (Trigger.isAfter && Trigger.isUpdate) {
            afterUpdate(Trigger.new, Trigger.newMap, Trigger.oldMap);
        } else if (Trigger.isAfter && Trigger.isDelete) {
            afterDelete(Trigger.old, Trigger.oldMap);
        }
    }

    protected virtual void beforeInsert(List<SObject> newRecords) {}
    protected virtual void beforeUpdate(List<SObject> newRecords, Map<Id, SObject> oldMap) {}
    protected virtual void beforeDelete(List<SObject> oldRecords, Map<Id, SObject> oldMap) {}
    protected virtual void afterInsert(List<SObject> newRecords, Map<Id, SObject> newMap) {}
    protected virtual void afterUpdate(List<SObject> newRecords, Map<Id, SObject> newMap, Map<Id, SObject> oldMap) {}
    protected virtual void afterDelete(List<SObject> oldRecords, Map<Id, SObject> oldMap) {}
}
