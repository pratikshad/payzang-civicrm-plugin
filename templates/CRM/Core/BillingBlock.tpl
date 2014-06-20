{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.4                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2013                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}

{crmRegion name="billing-block"}
{* Add 'required' marker to billing fields in this template for front-end / online contribution and event registration forms only. *}
{if $context EQ 'front-end'}
  {assign var=reqMark value=' <span class="crm-marker" title="This field is required.">*</span>'}
{else}
  {assign var=reqMark value=''}
{/if}

{if $form.credit_card_number or $form.bank_account_number}
    <div id="payment_information">
    <fieldset class="billing_mode-group {if $paymentProcessor.payment_type & 2}direct_debit_info-group{else}credit_card_info-group{/if}">
        <legend>
            {if $paymentProcessor.payment_type & 2}
                {ts}Direct Debit Information{/ts}
                {else}
                {if $isPZ eq 1}
                    {ts}Payment Information{/ts}
                    {else}
                    {ts}Credit Card Information{/ts}
                {/if}
            {/if}
        </legend>
        {if $paymentProcessor.billing_mode & 2 and !$hidePayPalExpress }
            <div class="crm-section no-label paypal_button_info-section">
                <div class="content description">
                    {ts}If you have a PayPal account, you can click the PayPal button to continue. Otherwise, fill in the credit card and billing information on this form and click <strong>Continue</strong> at the bottom of the page.{/ts}
                </div>
            </div>
            <div class="crm-section no-label {$form.$expressButtonName.name}-section">
                <div class="content description">
                    {$form.$expressButtonName.html}
                    <div class="description">Save time. Checkout securely. Pay without sharing your financial information. </div>
                </div>
            </div>
        {/if}

        {if $paymentProcessor.billing_mode & 1}
            <div class="crm-section billing_mode-section {if $paymentProcessor.payment_type & 2}direct_debit_info-section{else}credit_card_info-section{/if}">
                {if $paymentProcessor.payment_type & 2}
                    <div class="crm-section {$form.account_holder.name}-section">
                        <div class="label">{$form.account_holder.label}</div>
                        <div class="content">{$form.account_holder.html}</div>
                        <div class="clear"></div>
                    </div>
                    <div class="crm-section {$form.bank_account_number.name}-section">
                        <div class="label">{$form.bank_account_number.label}</div>
                        <div class="content">{$form.bank_account_number.html}</div>
                        <div class="clear"></div>
                    </div>
                    <div class="crm-section {$form.bank_identification_number.name}-section">
                        <div class="label">{$form.bank_identification_number.label}</div>
                        <div class="content">{$form.bank_identification_number.html}</div>
                        <div class="clear"></div>
                    </div>
                    <div class="crm-section {$form.bank_name.name}-section">
                        <div class="label">{$form.bank_name.label}</div>
                        <div class="content">{$form.bank_name.html}</div>
                        <div class="clear"></div>
                    </div>
                    {else}
                        {if $isPZ eq 1}
                            <div class="crm-section {$form.payment_method.name}-section" id="{$form.payment_method.name}-section">
                                <div class="content">
                                <ul id="payment_method_li" name="payment_method_li">
                                    <li class="current" value="Credit Card" data-value="Credit Card">Credit Card</li>
                                    <li value="ACH" data-value="ACH">Electronic Check/ACH</li>
                                </ul>
                                {$form.payment_method.html}</div>
                                <div class="clear"></div>
                            </div>
			    <div id="billing-instructions">Please fill the green fields below</div>
			    <div data-tab="ACH" class="tab-content">

			    <div id="ACH-fields" style="background-image:url({$BaseUrl}/images/eCheckBkg.jpg)">
                                <div class="crm-section {$form.routing_number.name}-section" id="{$form.routing_number.name}-section">
                                    <div class="content">{$form.routing_number.html}</div>
                                    <div class="clear"></div>
                            	</div>
                            	<div class="crm-section {$form.account_number.name}-section" id="{$form.account_number.name}-section">
                                    <div class="content">{$form.account_number.html}</div>
                                    <div class="clear"></div>
                            	</div>
                            	<div class="crm-section {$form.check_number.name}-section" id="{$form.check_number.name}-section">
                                    <div class="content">{$form.check_number.html}</div>
                                    <div class="clear"></div>
                                </div>
			    </div>
			    <div class="account_section">
			    <div class="crm-section {$form.re_account_number.name}-section" id="{$form.re_account_number.name}-section">
                                <div class="content">{$form.re_account_number.html}</div>
                                <div class="clear"></div>
                            </div>
                            <div class="crm-section {$form.account_type.name}-section" id="{$form.account_type.name}-section">
                                <div class="content">{$form.account_type.html}</div>
                                <div class="clear"></div>
			    </div>
                            </div>
			</div>
                        {/if}
		     <div data-tab="Credit Card" class="tab-content current">       
		    <div id="CREDIT-card-Fields" style="background-image:url({$BaseUrl}/images/genericCardBkg.jpg)">
		    	<div class="crm-section {$form.credit_card_type.name}-section">
                            <div class="label">{$form.credit_card_type.label} {$reqMark}</div>
                            <div class="content">
                                {$form.credit_card_type.html}
                                <div class="crm-credit_card_type-icons"></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="crm-section {$form.credit_card_number.name}-section">
                            <div class="content">{$form.credit_card_number.html}
                            </div>
                            <div class="clear"></div>
                        </div>
			<div class="crm-section {$form.cardholder_name.name}-section">
                            <div class="content">{$form.cardholder_name.html}</div>
                            <div class="clear"></div>
                        </div>
                    	<div class="crm-section {$form.credit_card_exp_date.name}-section">
			    <div class="label">Expires: </div>
                            <div class="content">{$form.credit_card_exp_date.html}</div>
                            <div class="clear"></div>
                        </div>
			<div class="crm-section {$form.cvv2.name}-section">
                            <div class="content">
                                {$form.cvv2.html}<img id='info-icon' src='{$BaseUrl}/images/info.png'><div id ='cvv-help'><img  src='{$BaseUrl}/images/cvv-help.png' alt='cvv-help' /></div>
                            </div>
                            <div class="clear"></div>
                        </div>
		    </div>
		</div>
                {/if}
            </div>
        </fieldset>
	{if $profileAddressFields}
             <input type="checkbox" id="billingcheckbox" value="0"> <label for="billingcheckbox">{ts}My billing address is the same as above{/ts}</label>
        {/if}
            <fieldset class="billing_name_address-group">
                <legend>{ts}Billing Name and Address{/ts}</legend>
                <div class="crm-section billing_name_address-section">
                    <div class="crm-section billingNameInfo-section">
                        <div class="content description">
                            {if $paymentProcessor.payment_type & 2}
                                {ts}Enter the name of the account holder, and the corresponding billing address.{/ts}
                                {else}
                                {ts}Enter the name as shown on your credit or debit card, and the billing address for this card.{/ts}
                            {/if}
                        </div>
                    </div>
                    <div class="crm-section {$form.billing_first_name.name}-section">
                        <div class="label">{$form.billing_first_name.label} {$reqMark}</div>
                        <div class="content">{$form.billing_first_name.html}</div>
                        <div class="clear"></div>
                    </div>
                    <div class="crm-section {$form.billing_middle_name.name}-section">
                        <div class="label">{$form.billing_middle_name.label}</div>
                        <div class="content">{$form.billing_middle_name.html}</div>
                        <div class="clear"></div>
                    </div>
                    <div class="crm-section {$form.billing_last_name.name}-section">
                        <div class="label">{$form.billing_last_name.label} {$reqMark}</div>
                        <div class="content">{$form.billing_last_name.html}</div>
                        <div class="clear"></div>
                    </div>
                    {assign var=n value=billing_street_address-$bltID}
                    <div class="crm-section {$form.$n.name}-section">
                        <div class="label">{$form.$n.label} {$reqMark}</div>
                        <div class="content">{$form.$n.html}</div>
                        <div class="clear"></div>
                    </div>
                    {assign var=n value=billing_city-$bltID}
                    <div class="crm-section {$form.$n.name}-section">
                        <div class="label">{$form.$n.label} {$reqMark}</div>
                        <div class="content">{$form.$n.html}</div>
                        <div class="clear"></div>
                    </div>
                    {assign var=n value=billing_country_id-$bltID}
                    <div class="crm-section {$form.$n.name}-section">
                        <div class="label">{$form.$n.label} {$reqMark}</div>
                        <div class="content">{$form.$n.html|crmAddClass:big}</div>
                        <div class="clear"></div>
                    </div>
                    {assign var=n value=billing_state_province_id-$bltID}
                    <div class="crm-section {$form.$n.name}-section">
                        <div class="label">{$form.$n.label} {$reqMark}</div>
                        <div class="content">{$form.$n.html|crmAddClass:big}</div>
                        <div class="clear"></div>
                    </div>
                    {assign var=n value=billing_postal_code-$bltID}
                    <div class="crm-section {$form.$n.name}-section">
                        <div class="label">{$form.$n.label} {$reqMark}</div>
                        <div class="content">{$form.$n.html}</div>
                        <div class="clear"></div>
                    </div>
                </div>
            </fieldset>
            {else}
            </fieldset>
        {/if}
    </div>

        {if $profileAddressFields}
        <script type="text/javascript">
                {literal}
             cj( function( ) {	     
  // build list of ids to track changes on
  var address_fields = {/literal}{$profileAddressFields|@json_encode}{literal};
  var input_ids = {};
  var select_ids = {};
  var orig_id = field = field_name = null;

  // build input ids
  cj('.billing_name_address-section input').each(function(i){
    orig_id = cj(this).attr('id');
    field = orig_id.split('-');
    field_name = field[0].replace('billing_', '');
    if(field[1]) {
      if(address_fields[field_name]) {
        input_ids['#'+field_name+'-'+address_fields[field_name]] = '#'+orig_id;
      }
    }
  });
  if(cj('#first_name').length)
    input_ids['#first_name'] = '#billing_first_name';
  if(cj('#middle_name').length)
    input_ids['#middle_name'] = '#billing_middle_name';
  if(cj('#last_name').length)
    input_ids['#last_name'] = '#billing_last_name';

  // build select ids
  cj('.billing_name_address-section select').each(function(i){
    orig_id = cj(this).attr('id');
    field = orig_id.split('-');
    field_name = field[0].replace('billing_', '').replace('_id', '');
    if(field[1]) {
      if(address_fields[field_name]) {
        select_ids['#'+field_name+'-'+address_fields[field_name]] = '#'+orig_id;
      }
    }
  });

  // detect if billing checkbox should default to checked
  var checked = true;
  for(var id in input_ids) {
    var orig_id = input_ids[id];
    if(cj(id).val() != cj(orig_id).val()) {
      checked = false;
      break;
    }
  }
  for(var id in select_ids) {
    var orig_id = select_ids[id];
    if(cj(id).val() != cj(orig_id).val()) {
      checked = false;
      break;
    }
  }
  if(checked) {
    cj('#billingcheckbox').attr('checked', 'checked');
    cj('.billing_name_address-group').hide();
  }

  // onchange handlers for non-billing fields
  for(var id in input_ids) {
    var orig_id = input_ids[id];
    cj(id).change(function(){
      var id = '#'+cj(this).attr('id');
      var orig_id = input_ids[id];

      // if billing checkbox is active, copy other field into billing field
      if(cj('#billingcheckbox').attr('checked')) {
        cj(orig_id).val( cj(id).val() );
      };
    });
  };
  for(var id in select_ids) {
    var orig_id = select_ids[id];
    cj(id).change(function(){
      var id = '#'+cj(this).attr('id');
      var orig_id = select_ids[id];

      // if billing checkbox is active, copy other field into billing field
      if(cj('#billingcheckbox').attr('checked')) {
        cj(orig_id+' option').removeAttr('selected');
        cj(orig_id+' option[value="'+cj(id).val()+'"]').attr('selected', 'selected');
      };

      if(orig_id == '#billing_country_id-5') {
        cj(orig_id).change();
      }
    });
  };


  // toggle show/hide
  cj('#billingcheckbox').click(function(){
    if(this.checked) {
      cj('.billing_name_address-group').hide(200);

      // copy all values
      for(var id in input_ids) {
        var orig_id = input_ids[id];
        cj(orig_id).val( cj(id).val() );
      };
      for(var id in select_ids) {
        var orig_id = select_ids[id];
        cj(orig_id+' option').removeAttr('selected');
        cj(orig_id+' option[value="'+cj(id).val()+'"]').attr('selected', 'selected');
      };
    } else {
      cj('.billing_name_address-group').show(200);
    }
  });

  // remove spaces, dashes from credit card number
  cj('#credit_card_number').change(function(){
    var cc = cj('#credit_card_number').val()
      .replace(/ /g, '')
      .replace(/-/g, '');
    cj('#credit_card_number').val(cc);
  });
});
                {/literal}
        </script>
        {/if}

        {literal}
        <script type="text/javascript">
	    
	    cj('.credit_card_type-section').hide();//to hide the card types section(WA)

            function showHidePaymentDetails(element)
            {
                value = element.options[element.selectedIndex].text;
                //if(value=='Check' )
                if(value=='ACH')
                {
		    cj('#CREDIT-card-Fields').hide();
		    cj('.cardholder_name-section').hide();
                    cj('.credit_card_number-section').hide();
                    cj('.cvv2-section').hide();
                    cj('.credit_card_exp_date-section').hide();

		    cj('#ACH-fields').show();
                    cj('.routing_number-section').show();
                    cj('.account_number-section').show();
		    cj('.re_account_number-section').show();
                    cj('.check_number-section').show();
                    cj('.account_type-section').show();

                }
                else if(value=='Credit Card')
                {
		    cj('#CREDIT-card-Fields').show();
		    cj('.cardholder_name-section').show();
                    cj('.credit_card_number-section').show();
                    cj('.cvv2-section').show();
                    cj('.credit_card_exp_date-section').show();

		    cj('#ACH-fields').hide();
                    cj('.routing_number-section').hide();
                    cj('.account_number-section').hide();
		    cj('.re_account_number-section').hide();
                    cj('.check_number-section').hide();
                    cj('.account_type-section').hide();
                }
                else
                {
		    cj('#priceset-div').show();
		    cj('#priceset').show();
		    cj('#billing-instructions').hide();
		    cj('#CREDIT-card-Fields').hide();
		    cj('.cardholder_name-section').hide();
                    cj('.credit_card_number-section').hide();
                    cj('.cvv2-section').hide();
                    cj('.credit_card_exp_date-section').hide();
		    cj('#ACH-fields').hide();
		    cj('.re_account_number-section').hide();
                    cj('.routing_number-section').hide();
                    cj('.account_number-section').hide();
                    cj('.check_number-section').hide();
                    cj('.account_type-section').hide();
                }
            }
            //showHidePaymentDetails(document.getElementById('payment_method'));

            function copyAddress(){
                var homeArray = new Array( 'first_name', 'last_name', 'street_address-3', 'city-3', 'postal_code-3', 'country-3', 'state_province-3' );
                var billingArray = new Array( 'billing_first_name', 'billing_last_name', 'billing_street_address-5', 'billing_city-5', 'billing_postal_code-5', 'billing_country_id-5', 'billing_state_province_id-5' );

                cj.each( homeArray, function(key, value){

                    cj('#'+billingArray[key]).val(cj('#'+value).val());
                } );
            }
        </script>
        {/literal}
    {/if}
{/crmRegion}

{literal}
<script>
    //code to place amount fields below payment istrument section and above billing informations (WA)
    cj(document).ready(function(){
	cj('.payment_processor-section input').map(function(index){
	  var label = cj("label[for='"+this.id+"']");
	  if(label.text().toLowerCase().indexOf("payzang") >= 0) {
	    label.html('PayZang <br/>(Credit Card/ Electronic Check/ ACH) ');
	  }
	  else {
	    cj(this, cj("label[for='"+this.id+"']") ).next().andSelf().wrapAll('<div class="input_label">');
	  }
	});
        //remove '-month-' option from month and '-year-' option from select year in credit_card_exp_date
	cj('#credit_card_exp_date_M option[value=""]').remove();
	cj('#credit_card_exp_date_Y option[value=""]').remove();
	cj('#pricelabel label').html('Total:');

	cj('.is_pledge-section').insertAfter('fieldset.credit_card_info-group');
	cj('.is_recur-section').insertAfter('fieldset.credit_card_info-group');
	cj('#priceset-div').insertAfter('fieldset.credit_card_info-group');
	cj('fieldset#priceset legend').css('display', 'none');
	var selectedIndex=cj( "#payment_method option:selected" ).text();
	cj('ul#payment_method_li  li').removeClass('current');
	cj('li[data-value="'+selectedIndex+'"]').addClass('current');
	cj('.tab-content').removeClass('current');
	cj('div.tab-content[data-tab="'+selectedIndex +'"]').addClass('current');
	cj("#payment_method").change(function(){
	   showHidePaymentDetails(this);
	});
	cj('ul#payment_method_li li').click(function(){
	    var tab_id = cj(this).attr('data-value');
	    var tab_text = cj(this).text();
	    cj('ul#payment_method_li  li').removeClass('current');
	    cj('.tab-content').removeClass('current');
	    cj(this).addClass('current');
	    cj('div.tab-content[data-tab="'+tab_id+'"]').addClass('current');
	    cj( "#payment_method option:contains('"+tab_id+"')").attr('selected', true);
	    cj("#payment_method").trigger('change');
	});
	
});
</script>
{/literal}

{if $FrameWork =='Joomla' }
    {literal}
    <style>
#routing_number-section,#account_number-section,#check_number-section {
    top:169px;
}
#routing_number {
    width: 79px !important;
}
#account_number{
    width: 119px !important;
}
#check_number{
    width: 52px !important;
}
#cvv2 {
    width: 35px !important;
}

   </style>
   {/literal}     
{/if}

{if $FrameWork =='WordPress' }
{literal}
<style>
#cvv2{
    width:52px  !important;
}
.cvv2-section{
    width:24%;
}
#routing_number-section,#account_number-section,#check_number-section {
    top:172px;
}
#routing_number {
    width: 96px !important;
}
#account_number{
    width: 135px !important;
}
#check_number{
    width: 64px !important;
}

#crm-container.crm-public .label {
        font-size: 0.80em !important;
}

</style>
{/literal}
{/if}
{if $FrameWork =='Drupal' }
{literal}
<style>
#routing_number-section,#account_number-section,#check_number-section {
    top:159px;
}
#routing_number {
    width: 79px !important;
}
#account_number{
    width: 119px !important;
}
#check_number{
    width: 52px !important;
}
#cvv2 {
    width: 35px !important;
}
</style>
{/literal}
{/if}
{literal}
<style>
.input_label {
    float: right;
    margin-top: -2.5%;
    //width: 50%;
}

.Payment_Amount-section div.label label {
    font-size: 14px;
    font-weight: bold;
    font-family: Arial,Helvetica,sans-serif;
}

.Payment_Amount-section div.label, #pricesetTotal .label {
    text-align: right !important;
}

#pricelabel label {
    font-size: 17px;
    font-weight: bold;
    font-family: Arial,Helvetica,sans-serif;
}

.credit_card_number-section div span.crm-error, 
.cvv2-section div span.crm-error, 
.credit_card_exp_date-section div span.crm-error, 
.cardholder_name-section div span.crm-error,
.routing_number-section div span.crm-error,
.account_number-section div span.crm-error, 
.re_account_number-section div span.crm-error{
    display:none !important;
}

#billing-instructions {
    background-color:#C1FFC1;
    border-color: #99CC66;
    border-style: solid;
    border-width: 1px;
    margin-top: 15px;
    padding: 10px;
    text-align: center;
}

#ACH-fields {
    background-repeat: no-repeat;
    height: 216px;
    margin: 10px auto;
    position: relative;
    width: 490px;
}
#routing_number,#account_number,#check_number,#re_account_number{
    background-color: #C1FFC1;
    border: 1px solid #3A741F;
    font-size: 13px !important;
    height: 23px !important;
    padding: 0 6px 0 7px !important;
}
#routing_number-section,#account_number-section,#check_number-section {
    position: absolute;
    margin: 0;
    line-height: 23px;
}
#routing_number-section {
    left: 39px;
}
#account_number-section {
    left: 150px;
}
#check_number-section {
    left: 301px;
}
#routing_number-section .content ,#account_number-section .content, #check_number-section .content{
    margin-left:0px !important; 
}
.account_section{
    height: 50px;
    width: 490px;
    margin: 10px auto;
    position: relative;
}
#re_account_number-section {
    margin-left: 117px;
}
#re_account_number-section,#account_type-section {
    float: left;
}
#re_account_number {
    font-size: 13px;
    height: 23px;
    margin: 7px 6px 0 8px;
    padding: 0 7px;
    width: 119px;
}
#account_type{
    font-size: 12px;
    height: 25px;
    left: 10px;
    padding: 3px;
    position: relative;
    top: 7px;
    width: 122px;
    background-color: #C1FFC1;
    border: 1px solid #3A741F;
    font-size: 13px !important;
    height: 25px !important;
    padding: 0 0px 0 7px !important;
}
#CREDIT-card-Fields {
    background-repeat: no-repeat;
    height: 216px;
    margin: 10px auto 0;
    position: relative;
    width: 352px;
}
#credit_card_number,#cvv2,#cardholder_name,#credit_card_exp_date_M,#credit_card_exp_date_Y {
    background-color: #D4ECC8;
    border: 1px solid #3A741F;
    float: left;
}
#credit_card_number,#cvv2,#cardholder_name {
    height: 23px !important;
    font-size: 13px !important;
    padding: 0 10px !important;
}
#credit_card_number,#cardholder_name  {
    width: 173px !important;
}

.credit_card_number-section {
    left: 13px;
    line-height: 23px;
    margin: 0 0 0 14px;
    position: absolute;
    top: 56px;
}
.cardholder_name-section {
    left: 13px;
    line-height: 23px;
    margin: 0 0 0 14px;
    position: absolute;
    top: 91px;
}
.cvv2-section {
    left: 242px;
    line-height: 23px;
    margin: 0 0 0 14px;
    position: absolute;
    top: 56px;
}
.credit_card_exp_date-section {
    height: 25px;
    left: 27px;
    position: absolute;
    top: 151px;
    width: 290px;
}
.credit_card_exp_date-section .label {
    color: #FFFFFF;
    float: left;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 11px;
    margin: 2px 0 0;
    padding-top: 0 !important;
    text-align: left;
    width : 18% !important;
}
#credit_card_exp_date_M {
    margin: 0 0 0 5px;
    width: 90px important;
    padding:0px !important;
    height:23px !important;
}
#credit_card_exp_date_Y {
    margin: 0 0 0 5px;
    width: 58px !important;
    padding:0px !important;
    height:23px !important;
}
.credit_card_number-section .content,.cardholder_name-section .content,.credit_card_exp_date-section .content,.cvv2-section .content{
    margin-left:0px !important;
}
.credit_card_exp_date-section .content{
margin-top:0px !important;
}



#payment_method {
    display:none;
}
ul#payment_method_li{

    margin: 0px;
    padding: 0px;
    list-style: none;
}
ul#payment_method_li li{
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    background: none repeat scroll 0 0 #E4E4E4;
    border-color: #CCCCCC;
    border-image: none;
    border-radius: 2px 2px 0 0;
    border-style: solid;
    border-width: 1px 1px 0;
    color: #222222;
    cursor: pointer;
    display: inline-block;
    list-style: none outside none;
    padding: 10px 15px;
}
ul#payment_method_li li.current{
    border-radius: 5px 5px 0 0;
     background:#FFFFFF;
    color: #222;
}
.tab-content{
    display: none;
    background: #ededed;
    padding: 15px;
    border: 1px solid #CCCCCC;
}
.tab-content.current{
    display: inherit;
}

#cvv-help {
    display:none;
}

#info-icon:hover + #cvv-help{
    display:block;
    position:absolute;
    z-index:100;
}

.Payment_Amount-section:after {
    content: "";
    display: block;
    height: 1px;
    width: 97%;
    margin: 10px;
    background: #000000;
}

div#priceset {
    border-left: 1px solid #000000;
    float: right;
    height: 100px;
    margin: 10px 0 !important;
    padding-top: 20px;
    padding-left: 1.5%;
    width: 40%;
}
div#priceset .label {
    padding-right: 5%;
    width: 46%;
}
div#priceset .Payment_Amount-content {
    margin-top: 0PX;
}
div#priceset .Payment_Amount-content input {
    background-color: #D4ECC8;
}

#pricesetTotal #pricelabel {
    padding-right: 14%;
    width: 38%;
}
#pricesetTotal #pricevalue {
	font-size: 15px;
    padding-top: 4px;
}

.billing_name_address-group {
	clear:both;
}
#choose-paymentmethod {
	padding: 3% 0;
}

#payment_information .is_recur-section .label {
	display: none;
}

#payment_information .is_recur-section .content {
	margin-left: 0;
}

#payment_information .is_recur-section .content label {
	display : inline;
	padding: 0 24% 1% 1%;
}
.crm-section.payment_method-section {
    background-color: #F4F4F4;
    border: 1px solid #E6E6E6;
    border-radius: 3px;
}
#payment_method-section .content {
    margin-left: 1% !important;
    margin-top: 1% !important;
}
#installments + label {
    padding-right : 0 !important;
}

#post-4 .entry-content {
        max-width: 720px !important;
}

#crm-container.crm-public .label {
        text-align: left;
}

@-moz-document url-prefix() { 
  #re_account_number-section input {
     margin: 7px 6px 0 2px;
  }
  
  #account_type-section .content {
        margin-left: 2% !important;
  }
}
.crm-container fieldset legend {
 text-indent: -4px !important;
}
@media screen and (-webkit-min-device-pixel-ratio:0) {
    #account_type-section .content {
        margin-left: 25% !important;
     }
}

</style>
{/literal}
