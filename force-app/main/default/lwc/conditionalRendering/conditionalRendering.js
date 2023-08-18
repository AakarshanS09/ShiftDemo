import { LightningElement,api } from 'lwc';

export default class ConditionalRendering extends LightningElement {
    
    @api
    areDetailsVisible=false;

    handleChange(event){
        this.areDetailsVisible=event.target.checked;
    }
}