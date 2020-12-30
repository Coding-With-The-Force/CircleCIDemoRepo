public with sharing class Org_Ultra_Related_List_Controller {
    private static Org_DataTable_Column_Wrapper actionsColumn = new Org_DataTable_Column_Wrapper();

    @AuraEnabled
    public static List<SObject> getTableDataController(Id recordId, String relatedObjectField, String objectType){
        List<SObject> tableData = new List<SObject>();
        /*try {
            String query = buildObjectQuery(objectType, relatedObjectField);
            System.debug('This was the query ::: ' + query);
            tableData = database.query(query);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }*/

        return tableData;
    }

    @AuraEnabled
    public static List<UE_Related_List_Page_Size__mdt> getTableSizeOptionsController(){
        List<UE_Related_List_Page_Size__mdt> columnSizeOptions = new List<UE_Related_List_Page_Size__mdt>();
        //columnSizeOptions = [SELECT Id, Label, Page_Size__c FROM UE_Related_List_Page_Size__mdt ORDER BY Page_Size__c LIMIT 1000];
        return columnSizeOptions;
    }
    
    @AuraEnabled
    public static List<Org_DataTable_Column_Wrapper> getDataTableColumnsController(String objectType){
        List<Org_DataTable_Column_Wrapper> columnData = new List<Org_DataTable_Column_Wrapper>();
        /*List<UE_Related_List_Column__mdt> columnMetadata = getRelatedListColumnMetadata(objectType);
        
        if(!columnMetadata.isEmpty()){
            columnData = buildColumnData(columnMetadata);
        }*/

        return columnData;
    }

    @AuraEnabled
    public static String saveTableDataToServer(String objectType, String tableDataJSON){
        String returnMsg = 'The update failed';
        /*List<Object> objectsReceived = (List<Object>)JSON.deserializeUntyped(tableDataJSON);
        List<SObject> convertedSObjects = new List<SObject>();

        for(Object val: objectsReceived){
            Map<String, Object> objectMap = (Map<String, Object>)val;
            Schema.SObjectType dataType = Schema.getGlobalDescribe().get(objectType);
            SObject convertedObject = dataType.newSObject();

            Map<String, Schema.SObjectField> fields = dataType.getDescribe().fields.getMap();
            for(String fieldName: objectMap.keySet())
            {
                Schema.SObjectField field = fields.get(fieldName);
                Schema.DisplayType fieldType = fields.get(fieldName).getDescribe().getType();
                if(field != null)
                {
                    System.debug('This is the field type ::: ' + fieldType + ' ::: This is the field ::: ' + objectMap.get(fieldName));
                    if(fieldType == Schema.DisplayType.CURRENCY || fieldType == Schema.DisplayType.LONG 
                        || fieldType == Schema.DisplayType.PERCENT || fieldType == Schema.DisplayType.DOUBLE){
                        convertedObject.put(fieldName, Double.valueOf(objectMap.get(fieldName)));
                    }
                    else if(fieldType == Schema.DisplayType.INTEGER){
                        convertedObject.put(fieldName, Integer.valueOf(objectMap.get(fieldName)));
                    }
                    else if(fieldType == Schema.DisplayType.DATE){
                        convertedObject.put(fieldName, (Date)JSON.deserialize((String)objectMap.get(fieldName), Date.class));
                    }
                    else if(fieldType == Schema.DisplayType.DATETIME){
                        convertedObject.put(fieldName, (Datetime)JSON.deserialize((String)objectMap.get(fieldName), Datetime.class));
                    }
                    else if(fieldType == Schema.DisplayType.BOOLEAN){
                        convertedObject.put(fieldName, Boolean.valueOf(objectMap.get(fieldName)));
                    }
                    else{
                        convertedObject.put(fieldName, String.valueOf(objectMap.get(fieldName)));
                    }
                }
            }

            convertedSObjects.add(convertedObject);
        }
        
        
        try{
            database.update(convertedSObjects, true);
            returnMsg = 'Successfully updated all records';
        }
        catch(Exception err){
            returnMsg = 'There was an error updating the records: ' + err.getMessage();
        }

        System.debug('This is the return message ::: ' + returnMsg);*/
        return returnMsg;
    }

    /*private static List<UE_Related_List_Column__mdt> getRelatedListColumnMetadata(String objectType){
        List<UE_Related_List_Column__mdt> dataColumns = new List<UE_Related_List_Column__mdt>();
        dataColumns = [SELECT Id, Label, Column_Order__c, Allow_Editing__c, Allow_Sorting__c, URL_Id__c, 
                       Allow_Text_Wrap__c, Column_Type__c, Field_Name__c, Initial_Column_Width__c, Object_Developer_Name__c
                       FROM UE_Related_List_Column__mdt WHERE Object_Developer_Name__c = :objectType ORDER BY Column_Order__c ASC LIMIT 1000];
        System.debug('This is the original list ::: ' + dataColumns);
        return dataColumns;
    }

    private static List<Org_DataTable_Column_Wrapper> buildColumnData(List<UE_Related_List_Column__mdt> columnMetadata)
    {
        List<Org_DataTable_Column_Wrapper> dataColumnObjectList = new List<Org_DataTable_Column_Wrapper>();
        for(UE_Related_List_Column__mdt column: columnMetadata){
            System.debug('This is the current column name ::: ' + column.Label);
            if(column.Column_Type__c == 'action'){
                buildActionColumn(column);
                continue;
            }
            Org_DataTable_Column_Wrapper dataColumn = new Org_DataTable_Column_Wrapper();
            dataColumn.editable = column.Allow_Editing__c;
            dataColumn.sortable = column.Allow_Sorting__c;
            dataColumn.label = column.Label;
            dataColumn.type = column.Column_Type__c;
            if(column.Column_Type__c == 'url'){
                dataColumn.fieldName = column.URL_Id__c;
            }
            else {
                dataColumn.fieldName = column.Field_Name__c;
            }
            dataColumn.typeAttributes = buildColumnTypeAttributes(column);
            dataColumnObjectList.add(dataColumn);

            System.debug('Final column output ::: ' + dataColumn);
        }

        dataColumnObjectList.add(actionsColumn);
        System.debug('This is the final actions column ::: ' + actionsColumn);
        //dataColumnObjectList = cleanUpRowActions(dataColumnObjectList);

        return dataColumnObjectList;
    }

    private static void buildActionColumn(UE_Related_List_Column__mdt actionsColumnMetadata){
        if(actionsColumn.typeAttributes?.rowActions == null){
            actionsColumn.type = actionsColumnMetadata.Column_Type__c;
            actionsColumn.fieldName = actionsColumnMetadata.Field_Name__c;
            actionsColumn.typeAttributes = buildColumnTypeAttributes(actionsColumnMetadata);
        }
        else{
            Org_DataTable_RowActions rowAction = new Org_DataTable_RowActions();
            rowAction.label = actionsColumnMetadata.Label;
            rowAction.name = actionsColumnMetadata.Field_Name__c;
            actionsColumn.typeAttributes.rowActions.add(rowAction);
        }

        System.debug('This is the current action column ::: ' + actionsColumn);
    }

    private static List<Org_DataTable_Column_Wrapper> cleanUpRowActions(List<Org_DataTable_Column_Wrapper> dataColumnObjectList){
        Integer loopCounter = 0;
        List<Org_DataTable_Column_Wrapper> cleanedColumnWrapperList= new List<Org_DataTable_Column_Wrapper>();
        for(Org_DataTable_Column_Wrapper column: dataColumnObjectList){
            if(column.type == 'action' && loopCounter == 0){
                column.fieldName = '';
                column.label = '';
                loopCounter++;
            }
            else if(column.type == 'action'){
                loopCounter++;
                continue;
            }

            cleanedColumnWrapperList.add(column);
        }
        return cleanedColumnWrapperList;
    }

    private static Org_DataTable_TypeAttributes_Wrapper buildColumnTypeAttributes(UE_Related_List_Column__mdt dataColumn){
        Org_DataTable_TypeAttributes_Wrapper columnTypeAttributesList = new Org_DataTable_TypeAttributes_Wrapper();
        if(dataColumn.Column_Type__c == 'date-local'){
            columnTypeAttributesList.day = '2-digit';
            columnTypeAttributesList.month = '2-digit';
        }
        else if(dataColumn.Column_Type__c == 'url'){
            columnTypeAttributesList.target = '_blank';
            columnTypeAttributesList.label = new Org_DataTable_Label_Attribute_Details();
            columnTypeAttributesList.label.fieldName = dataColumn.Field_Name__c;
        }
        else if(dataColumn.Column_Type__c == 'action'){
            columnTypeAttributesList.rowActions = buildActionAttributeDetails(dataColumn);
        }

        return columnTypeAttributesList;
    }

    private static List<Org_DataTable_Label_Attribute_Details> buildLabelAttributeDetails(String fieldName){
        List<Org_DataTable_Label_Attribute_Details> labelAttributeDetailsList = new List<Org_DataTable_Label_Attribute_Details>();
        Org_DataTable_Label_Attribute_Details labelAttributeDetail = new Org_DataTable_Label_Attribute_Details();
        labelAttributeDetail.fieldName = fieldName;
        labelAttributeDetailsList.add(labelAttributeDetail);
        return labelAttributeDetailsList;
    }

    private static List<Org_DataTable_RowActions> buildActionAttributeDetails(UE_Related_List_Column__mdt dataColumn){
        List<Org_DataTable_RowActions> rowActionDetailsList = new List<Org_DataTable_RowActions>();
        Org_DataTable_RowActions rowActionDetail = new Org_DataTable_RowActions();
        rowActionDetail.label = dataColumn.Label;
        rowActionDetail.name = dataColumn.Field_Name__c;
        rowActionDetailsList.add(rowActionDetail);
        return rowActionDetailsList;
    }

    private static String buildObjectQuery(String objectType, String relatedObjectField){
        String sObjectQuery = '';
        System.debug('This is the object type ::: ' + objectType);
        List<UE_Related_List_Column__mdt> fieldsToQuery = getRelatedListColumnMetadata(objectType);

        if(fieldsToQuery.isEmpty()){
            return sObjectQuery;
        }

        sObjectQuery = 'SELECT Id, ';
        for(UE_Related_List_Column__mdt column: fieldsToQuery){
            if(column.Column_Type__c != 'action' && column.Column_Type__c != 'url'){
                sObjectQuery += column.Field_Name__c + ',';
            }
            else if(column.Column_Type__c == 'url'){
                sObjectQuery += column.Field_Name__c + ',';
                
                if(!sObjectQuery.contains(column.URL_Id__c))
                {
                    sObjectQuery += column.URL_Id__c	+ ',';
                }
            }
        }

        sObjectQuery = sObjectQuery.removeEnd(',');
        sObjectQuery += ' FROM ' + objectType + ' WHERE ' + relatedObjectField + ' = :recordId';
        return sObjectQuery;
    }*/
}