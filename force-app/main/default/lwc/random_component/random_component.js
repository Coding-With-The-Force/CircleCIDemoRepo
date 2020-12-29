import { LightningElement } from 'lwc';

import{ showError, newStatus, coolClass} from 'c/utility_module';

export default class Random_component extends LightningElement 
{
    returnedError;
    returnedStatus;
    returnedLog;

    connectedCallback() {
        this.returnedError = showError();
        this.returnedStatus = newStatus;
        this.returnedLog = new coolClass().showConsoleLog();
    }
}