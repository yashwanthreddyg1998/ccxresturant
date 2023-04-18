public class date12 {
    
    public void date()
    {
        DateTime dt = DateTime.now();
		String formattedDate = dt.format('MM/dd/yyyy hh:mm:ss a');
		System.debug(formattedDate);
    }

}