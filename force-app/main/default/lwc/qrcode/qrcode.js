import { LightningElement } from 'lwc';

import qrcode from './qrcodegen.js';

export default class Qrcode extends LightningElement {
    renderedCallback() {
        const qrCodeGenerated = new qrcode(0, 'H');
        let strForGenearationOfQRCode  = 'This is my data.I am Shivani'
        qrCodeGenerated.addData(strForGenearationOfQRCode);
        qrCodeGenerated.make();
        let element = this.template.querySelector(".qrcode2");
        element.innerHTML = qrCodeGenerated.createSvgTag({});
   }
}