trigger Trig_AddUpdateCCXUser on User (After insert,After update) {
	if(trigger.isafter)
    {
        if(trigger.isinsert)            
        { 
            AddUpdateCCXUser.addCCXUser(trigger.new);
        }
        if(trigger.isupdate)            
        {    
            AddUpdateCCXUser.updateCCXUser(trigger.old,trigger.new);
        }
    }
}