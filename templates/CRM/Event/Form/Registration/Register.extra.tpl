{literal}
<script>
   var priceFields = '';
   
   cj(document).ready(function(e){
     priceFields = cj('div#priceset').html();
     cj('div#priceset').insertAfter('fieldset.credit_card_info-group');
     cj('#CIVICRM_QFID_0_payment_processor').one('click',function(){
       cj('div#priceset').remove();
       cj('.payment_options-group').append('<div id="priceset">'+priceFields+'</div>');
     });

     cj(document).ajaxComplete(function(event,request, settings){
         var obj = event.target.activeElement.attributes['name'];
         var name;
     	 cj.each(obj, function(key, element) {
     	     if(element == 'payment_processor') {
     	         name = element;
		 return false;
     	     }
         });
     
         if (name == "payment_processor") {
             if (cj('.payment_options-group #priceset').length) {
	         cj('div#priceset').remove();
         	 cj('.crm-event-register-form-block').append('<div id="priceset">'+ priceFields + '</div>');
             }
       	     if (cj('#payment_information #priceset').length) {
                 cj('div#priceset').remove();
	 	 cj('.crm-event-register-form-block').append('<div id="priceset">'+ priceFields + '</div>');
             }
          }
     });
});
</script>
{/literal}
