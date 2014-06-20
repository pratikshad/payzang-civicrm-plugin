{literal}
<script>
  var priceFields = '';
  var paymentMethods = '';
  var isRecurSection = '';
    
  cj(document).ready(function(){
    priceFields = cj('div#priceset').html();
    paymentMethods = cj('#choose-paymentmethod').html();
    isRecurSection = cj('.is_recur-section').html();

    cj('#choose-paymentmethod').insertAfter('fieldset.credit_card_info-group');
    cj('div#priceset').insertAfter('fieldset.credit_card_info-group');
    cj('#choose-paymentmethod, .is_recur-section').wrapAll('<div class="movingSections">');

    cj('#CIVICRM_QFID_0_payment_processor').one('click',function(){
      cj('div#priceset').remove();
      cj('.payment_options-group').append('<div id="priceset">'+priceFields+'</div>');
      cj('.payment_options-group').append('<div id="choose-paymentmethod">' +paymentMethods+ '</div>');
      cj('.payment_options-group').append('<div class="is_recur-section">' +isRecurSection+ '</div>');
      cj('#choose-paymentmethod').hide();
    });

    cj(document).ajaxComplete(function(event, request, settings) {
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
        	 cj('.crm-contribution-main-form-block').append('<div id="priceset">'+ priceFields + '</div>');
             }
      	     if (cj('#payment_information #priceset').length) {
                 cj('div#priceset').remove();
		 cj('.crm-contribution-main-form-block').append('<div id="priceset">'+ priceFields + '</div>');
             }
    
	     if (cj('input#payment_type').length) {
                 cj('input#payment_type').next().remove();
        	 cj('input#payment_type').remove();
        	 if (cj('#choose-paymentmethod').length) {
	  	     cj('#choose-paymentmethod').remove();
                 }
        	 cj('.crm-contribution-main-form-block').append('<div id="choose-paymentmethod">' +paymentMethods+ '</div>');
      	     }
      	     if (cj('input#is_recur').parent().length) {
                 cj('input#is_recur').parent().remove();
        	 if (cj('.is_recur-section').length) {
	  	     cj('.is_recur-section').remove();
                 }
        	 cj('.crm-contribution-main-form-block').append('<div class="is_recur-section">' +isRecurSection+ '</div>');
             }
         }
    });
  });
</script>
{/literal}

{literal}
<style>
.movingSections {
    width: 413px;
}
</style>
{/literal}
