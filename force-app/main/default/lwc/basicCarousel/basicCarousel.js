import { LightningElement,api } from 'lwc';

export default class BasicCarousel extends LightningElement {

    @api
    pictureInfo=[];
    @api
    pictureLink;
}