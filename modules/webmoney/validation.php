<?php

include(dirname(__FILE__). '/../../config/config.inc.php');
include(dirname(__FILE__).'/webmoney.php');

$webmoney = new Webmoney();

if (isset($_POST))
{
	$key = Configuration::get('WEBMONEY_KEY');
	$cart = new Cart(intval($_POST['LMI_PAYMENT_NO']));
	$currency = new Currency(intval($cart->id_currency));
	$customer = new Customer((int)$cart->id_customer); 

		if ($currency->iso_code == 'RUB')
			{$purse = Configuration::get('WEBMONEY_PURSE_R');}
		elseif ($currency->iso_code == 'USD')
			{$purse = Configuration::get('WEBMONEY_PURSE_Z');}
		elseif ($currency->iso_code == 'EUR')
			{$purse = Configuration::get('WEBMONEY_PURSE_E');}

		$amount = number_format($cart->getOrderTotal(true, 3), 2, '.', '');

		if($_POST['LMI_PREREQUEST'] == 1)
		{
			if ($_POST['LMI_PAYEE_PURSE'] == $purse && $_POST['LMI_MODE'] == 0 && $_POST['LMI_PAYMENT_NO'] == $cart->id && $_POST['LMI_PAYMENT_AMOUNT'] == $order_amount)
			{echo 'YES'; exit;} else {echo 'WRONG';}
		}

		if (isset($_POST['LMI_HASH']))
		{
			$crc = strtoupper(md5($_POST['LMI_PAYEE_PURSE'].$_POST['LMI_PAYMENT_AMOUNT'].$_POST['LMI_PAYMENT_NO'].$_POST['LMI_MODE'].$_POST['LMI_SYS_INVS_NO'].$_POST['LMI_SYS_TRANS_NO'].$_POST['LMI_SYS_TRANS_DATE'].$ikey.$_POST['LMI_PAYER_PURSE'].$_POST['LMI_PAYER_WM']));

			if ($crc == strtoupper($_POST['LMI_HASH']))
				{
					$webmoney->validateOrder((int)$cart->id, _PS_OS_PAYMENT_, $_POST['LMI_PAYMENT_AMOUNT'], $webmoney->displayName, $message, NULL, NULL, false, $customer->secure_key);
				}
		}
}