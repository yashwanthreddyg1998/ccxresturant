import { LightningElement ,api} from 'lwc';

export default class MenuScreenheader extends LightningElement {
    @api token;
    @api id;
    @api table;
    @api cname;
    @api  csn;
}