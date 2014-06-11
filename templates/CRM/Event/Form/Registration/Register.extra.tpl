{literal}
<script>
   var priceFields = '';
   
   cj(document).ready(function(){
     priceFields = cj('div#priceset').html();
     cj('div#priceset').insertAfter('fieldset.credit_card_info-group');

     cj('#CIVICRM_QFID_0_payment_processor').one('click',function(){
       cj('div#priceset').remove();
       cj('.payment_options-group').append('<div id="priceset">'+priceFields+'</div>');
     });

     cj(document).ajaxStart(function(){
       if (cj('#payment_information').find('div#priceset').length) {
	 cj('div#priceset').remove();
         cj('.payment_options-group').append('<div id="priceset">'+priceFields+'</div>');
       }
     });

     cj(document).ajaxStop(function(){
       if (cj('.payment_options-group #priceset').length) {
	 cj('div#priceset').remove();
         cj('.crm-event-register-form-block').append('<div id="priceset">'+ priceFields + '</div>');
       }
       if (cj('#payment_information #priceset').length) {
         cj('div#priceset').remove();
	 cj('.crm-event-register-form-block').append('<div id="priceset">'+ priceFields + '</div>');
       }
     });
   });
   
</script>
{/literal}
