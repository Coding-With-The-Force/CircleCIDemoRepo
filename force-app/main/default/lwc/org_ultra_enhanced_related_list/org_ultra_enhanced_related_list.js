import { LightningElement, api } from 'lwc';
import getPageSizeOptionsFromController from '@salesforce/apex/Org_Ultra_Related_List_Controller.getTableSizeOptionsController'; 
import getDataTableColumnsFromController from '@salesforce/apex/Org_Ultra_Related_List_Controller.getDataTableColumnsController'; 
import getTableDataFromController from '@salesforce/apex/Org_Ultra_Related_List_Controller.getTableDataController'; 
import saveTableDataToServerController from '@salesforce/apex/Org_Ultra_Related_List_Controller.saveTableDataToServer'; 

export default class Org_ultra_enhanced_related_list extends LightningElement {
    
    @api recordId;
    @api relatedObjectName;
    @api relatedFieldName;
    objectRows; 

    sortDirection;
    rowSelectedForSorting;

    pageSize = 10;
    pageSizeLabel = "10";
    pageSizeOptions = [];
    currentPageNumber;
    maxPageNumber;

    dataTableColumns;
    allDataTableRows;
    currentTableRowData;
    selectedTableRows = [];

    connectedCallback()
    {
        this._getDataTableColumns();
        this.getTableData();
        this.getPageSizeOptions();
    }

    _getDataTableColumns()
    {
        getDataTableColumnsFromController({"objectType": this.relatedObjectName}).then(
			result =>{
                console.log(JSON.stringify('This is the result ::: ' + result));
                result.forEach(column =>{
                    console.log('This is the column data ::: ' + JSON.stringify(column));
                });
                this.dataTableColumns = result;
			}).catch(error => {
				console.error('Error retrieving data table columns from the controller ' + JSON.stringify(error));
		    });
    }

    getTableData()
    {
        getTableDataFromController({"recordId": this.recordId, "relatedObjectField": this.relatedFieldName, "objectType": this.relatedObjectName}).then(
			result =>{
                console.log('This is the received table data ::: ' + JSON.stringify(result));
                this.allDataTableRows = result;
                //this.maxPageNumber = result.length/this.pageSize;
			}).catch(error => {
				console.error('Error retrieving data from the controller ' + JSON.stringify(error));
		    });
    }

    getPageSizeOptions()
    {
        getPageSizeOptionsFromController().then(
			result =>
			{
                console.log(JSON.stringify(result));
                let pageSizeOptions = [];

                result.forEach(sizeOption =>{
                    pageSizeOptions.push({label: sizeOption.Label, value: sizeOption.Page_Size__c});
                });

                this.pageSizeOptions = pageSizeOptions;
			}).catch(error => {
				console.error('page size retrieval error ' + JSON.stringify(error));
		});
    }

    updateNumberOfItemsPerPage(event)
    {

    }

    searchDataTable(event)
    {

    }

    sortRowData(event)
    {

    }

    addRowToSelectedDataTableRowMap(event)
    {

    }

    changeDataTablePage(event)
    {
        if(event.target.label == 'First'){
            this.pageNumber = 1;
        }
        else if(event.target.label == 'Last'){
            this.pageNumber = this.maxPageNumber;
        }
        else if(event.target.label == 'Next'){
            this.pageNumber = Math.min(
                this.pageNumber + 1,
                this.maxPageNumber
            );
        }
        else if(event.target.label == 'Previous'){
            this.pageNumber = Math.max(1, this.pageNumber - 1);
        }
    }

    doSelectedRowAction(event)
    {
        
    }

    createNewRecord(event)
    {

    }

    saveTableDataToServer(event)
    {
        saveTableDataToServerController({"objectType": this.relatedObjectName, "tableDataJSON": JSON.stringify(event.detail.draftValues)}).then(
			result =>
			{
                console.log(result);
                //this.dispatchEvent(showToast('Success', 'Update Successful', 'success', 'dismissible'));
			}).catch(error => {
				console.error('There was an error saving the data in the table ::: ' + JSON.stringify(error));
		});
    }
}