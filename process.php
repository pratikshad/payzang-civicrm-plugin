<?php

require_once 'process.civix.php';

/**
 * Implementation of hook_civicrm_config
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_config
 */
function process_civicrm_config(&$config) {
  global $base_url;
  $framework = $config->userFramework;
  $smarty  =&  CRM_Core_Smarty::singleton( );
  $smarty->assign('BaseUrl', $base_url);
  $smarty->assign('FrameWork', $framework);
  _process_civix_civicrm_config($config);
}

/**
 * Implementation of hook_civicrm_xmlMenu
 *
 * @param $files array(string)
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_xmlMenu
 */
function process_civicrm_xmlMenu(&$files) {
  _process_civix_civicrm_xmlMenu($files);
}

/**
 * Implementation of hook_civicrm_install
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_install
 */
function process_civicrm_install() {
  return _process_civix_civicrm_install();
}

/**
 * Implementation of hook_civicrm_uninstall
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_uninstall
 */
function process_civicrm_uninstall() {
  return _process_civix_civicrm_uninstall();
}

/**
 * Implementation of hook_civicrm_enable
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_enable
 */
function process_civicrm_enable() {
  return _process_civix_civicrm_enable();
}

/**
 * Implementation of hook_civicrm_disable
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_disable
 */
function process_civicrm_disable() {
  return _process_civix_civicrm_disable();
}

/**
 * Implementation of hook_civicrm_upgrade
 *
 * @param $op string, the type of operation being performed; 'check' or 'enqueue'
 * @param $queue CRM_Queue_Queue, (for 'enqueue') the modifiable list of pending up upgrade tasks
 *
 * @return mixed  based on op. for 'check', returns array(boolean) (TRUE if upgrades are pending)
 *                for 'enqueue', returns void
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_upgrade
 */
function process_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
  return _process_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implementation of hook_civicrm_managed
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_managed
 */
function process_civicrm_managed(&$entities) {
  return _process_civix_civicrm_managed($entities);
}

/**
 * Implementation of hook_civicrm_caseTypes
 *
 * Generate a list of case-types
 *
 * Note: This hook only runs in CiviCRM 4.4+.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_caseTypes
 */
function process_civicrm_caseTypes(&$caseTypes) {
  _process_civix_civicrm_caseTypes($caseTypes);
}

/**
 * Implementation of hook_civicrm_alterSettingsFolders
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_alterSettingsFolders
 */
function process_civicrm_alterSettingsFolders(&$metaDataFolders = NULL) {
//_process_civix_civicrm_alterSettingsFolders($metaDataFolders);
}

function process_civicrm_buildForm($formName, &$form)
{
  if ($formName == 'CRM_Contribute_Form_Contribution_Main' || $formName == 'CRM_Event_Form_Registration_Register' || $formName == 'CRM_Contribute_Form_Contribution' || $formName == 'CRM_Event_Form_Participant' || $formName == 'CRM_Member_Form_Membership' || $formName == 'CRM_Member_Form_MembershipRenewal')// && empty($_GET['qfKey']))
    {
      require_once 'CRM/Contribute/PseudoConstant.php';
      if(isset($form->_elementIndex['credit_card_exp_date'])){
        $expireYear = $form->getElement('credit_card_exp_date');
        $expireYear->_options['maxYear'] = (int)$expireYear->_options['maxYear']+4;
        foreach($expireYear->_locale['months_short'] as $key => $val ) {
          $expireYear->_locale['months_short'][$key] = $key.'-'.$val;
        }
        $form->set('credit_card_exp_date', $expireYear);
      }
      $paymentMethods = CRM_Contribute_PseudoConstant::paymentInstrument();
      foreach ( $paymentMethods as $methodId => $methodName ) {
        if ( $methodName != "Credit Card" && $methodName != "ACH" ) {
          unset($paymentMethods[$methodId]);
        }
      }
      $form->assign('isPZ', 1);
      $element =& $form->add( 'select', 'payment_method',
                ts( 'Payment Method' ),
                $paymentMethods, FALSE,
                array( 'onChange' => "return showHidePaymentDetails(this);")
      );
      $element =& $form->add( 'text', 'routing_number', ts('Routing Number'), array('size' => 15, 'maxlength' => 10, 'autocomplete' => 'off', 'placeholder' => 'Routing#'));
      $element =& $form->add( 'text', 're_account_number', ts('Re Account Number'), array('size' => 15, 'autocomplete' => 'off', 'placeholder' => 'Re-Enter Account'));
      $element =& $form->add( 'text', 'account_number', ts('Account Number'), array('size' => 15, 'autocomplete' => 'off', 'placeholder' => 'Account#'));
      $element =& $form->add( 'text', 'check_number', ts('Check Number'), array('size' => 15, 'autocomplete' => 'off', 'placeholder' => 'Check#'));
      $element =& $form->add( 'select', 'account_type',
                ts( 'Account Type' ),
                array('Checking' => ts('Checking'),
                  'Savings' => ts('Savings') ), FALSE);
      foreach($form->_elements as $element)
        {
          if(!empty($element->_attributes['name']) && $element->_attributes['name'] == 'frequency_unit')
            {
              $options = array();
              $options[] = array("text" => "weekly", "attr" => array("value" => "weekly"));
              $options[] = array("text" => "bi-weekly", "attr" => array("value" => "bi-weekly"));
              $options[] = array("text" => "monthly", "attr" => array("value" => "monthly"));
              $options[] = array("text" => "bi-monthly", "attr" => array("value" => "bi-monthly"));
              $options[] = array("text" => "quarterly", "attr" => array("value" => "quarterly"));
              $options[] = array("text" => "semiannually", "attr" => array("value" => "semiannually"));
              $options[] = array("text" => "yearly", "attr" => array("value" => "yearly"));
              $element->_options = $options;
            }
        }
    }
  elseif ( $formName == 'CRM_Contribute_Form_Contribution_Confirm' || $formName == 'CRM_Event_Form_Registration_Confirm' || $formName == 'CRM_Contribute_Form_Contribution_ThankYou' || $formName == 'CRM_Event_Form_Registration_ThankYou')
    {
      $params = $form->get( 'params' );
      if($params == null) // on ThankYou page, previous line of code is returning null, even though params exist, manually setting params below
        {
          $params = $form->getvar('_params');
        }

      if ( !empty($params[0]) && is_array($params[0]) ) {
        $params = $params[0];
      }
      require_once 'CRM/Contribute/PseudoConstant.php';
      require_once 'CRM/Utils/System.php';
      $paymentMethods = CRM_Contribute_PseudoConstant::paymentInstrument();

      if ( CRM_Utils_Array::value( 'payment_method', $params ) ) {
        $form->assign( 'payment_method', $paymentMethods[$params['payment_method']]);
      }
      if(isset($params['payment_method'])) {
          if ($paymentMethods[$params['payment_method']] == 'ACH') {
            if ( CRM_Utils_Array::value( 'routing_number', $params ) ) {
              $form->assign( 'routing_number', $params['routing_number']);
            }
            if ( CRM_Utils_Array::value( 'account_number', $params ) ) {
              $form->assign( 'account_number', CRM_Utils_System::mungeCreditCard( $params['account_number'] ) );
            }
            if ( CRM_Utils_Array::value( 'account_type', $params ) ) {
              $form->assign( 'account_type', $params['account_type']);
            }
          }
        }
    }
  else if ( $formName == 'CRM_Contribute_Form_ContributionPage_Amount')
    {
      /*
       * Commented out processor class code due to bug.  If user didn't select PayZang as the processor then click save,
       * before enabling recurring payments, the "day" option was displaying because processorClass was null.
       */

      //$processorClass = getProcessorClass( $form->getVar('_id') );
      $form->addElement( 'checkbox', 'is_recur', ts('Recurring contributions'), null,
        array('onclick' => "showHideByValue('is_recur',true,'recurFields','table-row','radio',false); showRecurInterval( );") );
      require_once 'CRM/Core/OptionGroup.php';
      //if( $processorClass == 'com.payzang.payment.pzpayments' ){
      $frequencyUnitOptions = array(
        'weekly'    => 'weekly',
        'bi-weekly' => 'bi-weekly',
        'monthly'   => 'monthly',
        'bi-monthly' => 'bi-monthly',
        'quarterly' => 'quarterly',
        'semiannually' => 'semiannually',
        'yearly'    => 'yearly'
      );
      /*}else{
        $frequencyUnitOptions = CRM_Core_OptionGroup::values( 'recur_frequency_units', false, false, false, null, 'name' );
        $form->addElement('checkbox', 'is_recur_interval', ts('Support recurring intervals') );
        }*/
      $form->addCheckBox( 'recur_frequency_unit', ts('Supported recurring units'),
        $frequencyUnitOptions,
        null, null, null, null,
        array( '&nbsp;&nbsp;', '&nbsp;&nbsp;', '&nbsp;&nbsp;', '<br/>' ) );

    }
  if ($formName == "CRM_Contribute_Form_Contribution") {
    CRM_Core_Region::instance('page-body')->add(array(
        'template' => 'CRM/Contribute/Form/NameChange.tpl',
      ));
  }

  //wa added to assign selected payment method in smarty
  if ($formName == 'CRM_Contribute_Form_Contribution_Confirm') {
    $paymentMethod = $form->get('paymentMethod');
    $smarty  =&  CRM_Core_Smarty::singleton( );
    $smarty->assign('paymentMethod', $paymentMethod);
  }
}

function process_civicrm_validate( $formName, &$fields, &$files, &$form )
{
    if( $formName == 'CRM_Contribute_Form_ContributionPage_Amount' && isset( $fields ['is_recur'] ) )
    {
        require_once 'CRM/Contribute/Form/ContributionPage/Amount.php';

        $defaults = array();
        require_once "CRM/Financial/BAO/PaymentProcessor.php";

        $processor_id = $fields['payment_processor'];

        CRM_Financial_BAO_PaymentProcessor::retrieve($processor_id, $defaults );

        $frequency_interval=array ( 'monthly' , 'bi-monthly', 'weekly' , 'bi-weekly' , 'quarterly' , 'semiannually', 'yearly');
        $flag = 0;
        if ( !empty( $fields['recur_frequency_unit'] ) )
        {
            foreach( $frequency_interval as $key=>$values ){
                if ( !array_key_exists("$values",$fields['recur_frequency_unit'] ))
                {
                    $flag = 0;
                }
                else
                {
                    $flag = 1;
                    break;
                }
            }
        }
        if ( $defaults['class_name'] == 'com.payzang.payment.pzpayments' && $flag == 0){
            $form->_errors['recur_frequency_unit'] = "Invalid fields for the Payment Processor";
        }
    }
    require_once 'CRM/Contribute/PseudoConstant.php';
    $paymentMethods = CRM_Contribute_PseudoConstant::paymentInstrument();
    //overide validation for CC or ACH details
    if ( $formName == 'CRM_Contribute_Form_Contribution_Main' || $formName == 'CRM_Event_Form_Registration_Register' || $formName == 'CRM_Contribute_Form_Contribution' || $formName == 'CRM_Event_Form_Participant' || $formName == 'CRM_Member_Form_Membership' || $formName == 'CRM_Member_Form_MembershipRenewal')
    {
        if ( $formName == 'CRM_Contribute_Form_Contribution_Main' && empty($fields['is_recur']) )
        {
            require_once "CRM/Utils/Rule.php";

            if ( !empty($fields['amount_other'])) {
                $amt = CRM_Utils_Rule::cleanMoney( $fields['amount_other'] );
                if ($amt <= 5 ){
                    $form->_errors['amount_other'] = "Amount cannot be less than or equal to 5 for one time payment";
                }
            } else if ( isset($fields['amount']) ) {
                $amt = CRM_Utils_Rule::cleanMoney( $fields['amount'] );
                if( $amt <= 5 ) {
                    $form->_errors['amount'] = "Amount cannot be less than or equal to 5 for recurring payment";
                }
            }
        }
        if ( !empty($fields['payment_method']) && $paymentMethods[$fields['payment_method']] == 'ACH' ) {
            unset($form->_errors['credit_card_number']);
            unset($form->_errors['cvv2']);
            unset($form->_errors['credit_card_exp_date']);
            unset($form->_errors['credit_card_type']);
            unset($form->_errors['cardholder_name']);
            if ( !$fields['routing_number'] )
            {
                // additional validation? modulus 9?
                $form->_errors['routing_number'] = "Routing number field is required";
            }
            else
            {
                if(!validateRoutingNumber($fields['routing_number']))
                {
                    $form->_errors['routing_number'] = "Invalid Routing number ";
                }
            }
            if ( !$fields['account_number'] )
            {
                $form->_errors['account_number'] = "Account number field is required";
            }
            if ( !$fields['re_account_number'] )
            {
                $form->_errors['re_account_number'] = "Re-Enter Account number field is required";
            }
            if ( $fields['re_account_number'] != $fields['account_number'] )
            {
                $form->_errors['re_account_number'] = "Re-Enter Account number does not match with account number";
            }
        }
    }
}

//Set selected payment method's value in form
//This value will be fetched and set as smarty variable in build form
function process_civicrm_postProcess( $formName, &$form ) {
  if ($formName == 'CRM_Contribute_Form_Contribution_Main' || $formName == 'CRM_Contribute_Form_Contribution') {
      if(isset($form->_submitValues['payment_method'])){
    $form->set('paymentMethod', $form->_submitValues['payment_method']);
    }
  }
}

function process_civicrm_post( $op, $objectName, $objectId, &$objectRef ) {
}


//Change payment instrument id of contribution/recur contribution as per the payment method selected
//fethching selected payment method from smarty

function process_civicrm_pre( $op, $objectName, $id, &$params ) {
  $smarty  =&  CRM_Core_Smarty::singleton( );
  $variables = $smarty->get_template_vars();
  if(isset($variables['is_monetary'])){
    $is_monetory = $variables['is_monetary'];
    }
   if(isset($variables['paymentMethod'])){
    $paymentInstrumentId = $variables['paymentMethod'];
    }
  if($op == 'create' && (($objectName == "Contribution" && !$params['is_pay_later']) || $objectName == "ContributionRecur")) {
    if (isset($is_monetory) && $paymentInstrumentId) {
      $params['payment_instrument_id'] = $paymentInstrumentId;
    }
  }
}

function validateRoutingNumber($routing)
{
    if (strlen($routing)!=9)
        return false;
    $d=str_split($routing,1);
    if ((3*($d[0]+$d[3]+$d[6])+7*($d[1]+$d[4]+$d[7])+($d[2]+$d[5]+$d[8]))%10==0)
        return true;
    return false;
}


function getProcessorClass( $pageId ){
    $sql = "SELECT pp.class_name
    FROM `civicrm_contribution_page` cp, civicrm_payment_processor pp
    where cp.payment_processor = pp.id and cp.id={$pageId}";
    $processorClass =& CRM_Core_DAO::singleValueQuery( $sql );
    return $processorClass;
}
