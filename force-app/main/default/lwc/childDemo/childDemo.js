import { LightningElement, api } from 'lwc';

export default class ChildDemo extends LightningElement {

    @api
    get itemName(){
        return this.uppercaseItemName;
    }
    set itemName(value){
        this.uppercaseItemName = value.toUpperCase();
    } 
}