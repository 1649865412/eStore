
$(document).ready(function()
{
	$('.galleryImage').hover(
		function()
		{
		
		$(this).find('img').animate({width:70, marginTop:5, marginLeft:5}, 500);
		   
		 },
		 function()
		 {
			 
			 $(this).find('img').animate({width:192, marginTop:0, marginLeft:0},300);
			 
		 });
});

                       
                   