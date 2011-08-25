<?php

class Webmoney extends PaymentModule
{
	private $_html = '';

	public function __construct()
	{
		$this->name = 'webmoney';
		$this->tab = 'payments_gateways';
		$this->version = '1.0';
		$this->author = 'PrestaDev.ru';

		$this->currencies = true;
		$this->currencies_mode = 'radio';
		//$this->currencies_mode = 'checkbox';

		parent::__construct();

		$this->_errors = array();
		$this->page = basename(__FILE__, '.php');
        $this->displayName = 'WebMoney';
        $this->description = $this->l('Accepts payments by WebMoney');
		$this->confirmUninstall = $this->l('Are you sure you want to delete your details?');
		if (!Configuration::get('WEBMONEY_PURSE_R') && !Configuration::get('WEBMONEY_PURSE_Z') && !Configuration::get('WEBMONEY_PURSE_E'))
			$this->warning = $this->l('Please add any purse');
		if (!Configuration::get('KEY'))
			$this->warning = $this->l('Please add secret key');
	}

	public function install()
	{
		if (!parent::install()
			OR !$this->registerHook('payment')
			OR !$this->registerHook('paymentReturn'))
			return false;

		Configuration::updateValue('WEBMONEY_PURSE_R', '');
		Configuration::updateValue('WEBMONEY_PURSE_Z', '');
		Configuration::updateValue('WEBMONEY_PURSE_E', '');
		Configuration::updateValue('KEY', '');

		return true;
	}

	public function uninstall()
	{
		Configuration::deleteByName('WEBMONEY_PURSE_R');
		Configuration::deleteByName('WEBMONEY_PURSE_Z');
		Configuration::deleteByName('WEBMONEY_PURSE_E');
		Configuration::deleteByName('KEY');

		return parent::uninstall();
	}

	public function getContent()
	{
		if (Tools::isSubmit('submit'))
		{
			Configuration::updateValue('WEBMONEY_PURSE_R', Tools::getValue('WEBMONEY_PURSE_R'));
			Configuration::updateValue('WEBMONEY_PURSE_Z', Tools::getValue('WEBMONEY_PURSE_Z'));
			Configuration::updateValue('WEBMONEY_PURSE_E', Tools::getValue('WEBMONEY_PURSE_E'));
			Configuration::updateValue('KEY', Tools::getValue('KEY'));
		}

		return '
		<form action="'.Tools::htmlentitiesUTF8($_SERVER['REQUEST_URI']).'" method="post">
			<fieldset><legend><img src="../modules/'.$this->name.'/logo.gif" /> '.$this->l('Settings').'</legend>
				<label for="wmr">'.$this->l('WMR:').'</label>
				<div class="margin-form">
					<input type="text" id="wmr" size="25" maxlength="13" name="WEBMONEY_PURSE_R" value="'.Tools::getValue('WEBMONEY_PURSE_R', Configuration::get('WEBMONEY_PURSE_R')).'" />
				</div>
				<div class="clear">&nbsp;</div>
				<label for="wmz">'.$this->l('WMZ:').'</label>
				<div class="margin-form">
					<input type="text" id="wmz" size="25" maxlength="13" name="WEBMONEY_PURSE_Z" value="'.Tools::getValue('WEBMONEY_PURSE_Z', Configuration::get('WEBMONEY_PURSE_Z')).'" />
				</div>
				<div class="clear">&nbsp;</div>
				<label for="wme">'.$this->l('WME:').'</label>
				<div class="margin-form">
					<input type="text" id="wme" size="25" maxlength="13" name="WEBMONEY_PURSE_E" value="'.Tools::getValue('WEBMONEY_PURSE_E', Configuration::get('WEBMONEY_PURSE_E')).'" />
				</div>
				<div class="clear">&nbsp;</div>
				<label for="key">'.$this->l('SECRET KEY:').'</label>
				<div class="margin-form">
					<input type="text" id="key" size="25" name="KEY" value="'.Tools::getValue('KEY', Configuration::get('KEY')).'" />
				</div>
				<div class="clear">&nbsp;</div>
				<center><input type="submit" name="submit" value="'.$this->l('Update settings').'" class="button" /></center>
			</fieldset>
		</form>
		<div class="clear">&nbsp;</div>
		<fieldset><legend><img src="../img/admin/prefs.gif" /> Подключение интернет-магазина к WebMoney</legend>
			На странице <a href="https://merchant.webmoney.ru" style="font-weight:bold">https://merchant.webmoney.ru</a> выберите пункт меню &quot;Настройки&quot;. Пройдите авторизацию и выберите кошелек, на который вы будете принимать платежи   через сервис Web Merchant Interface. Вы получите страницу для настройки   параметров. <br />
			<br />Ниже приведен перечень заполняемых значений:</p>
			<ul>
				<li><b>Торговое имя:</b> Торговое имя (это название отображается на странице при оплате)</li>
				<li><b>Secret Key:</b> Придумайте код платежа, должен знать интернет-магазин и Webmoney</li>
				<li><b>Тестовый/Рабочий режим:</b> Тестовый - для тестов, Рабочий - для приема платежей</li>
				<li><b>Передавать параметры в предварительном запросе:</b> отметить</li>
				<li><b>Позволять использовать URL, передаваемые в форме:</b> отметить</li>
			</ul>
			<div class="clear">&nbsp;</div>
		</fieldset>
		<div class="clear">&nbsp;</div>';
	}

	public function hookPayment($params)
	{
		global $smarty;

		$currency = new Currency((int)($params['cart']->id_currency));
		$lang = new Language((int)($params['cart']->id_lang));
		$customer = new Customer((int)($params['cart']->id_customer));
		$address = new Address((int)($params['cart']->id_address_invoice));
		$country = new Country((int)($address->id_country), (int)($params['cart']->id_lang));

		if ($currency->iso_code == 'RUB' && Configuration::get('WEBMONEY_PURSE_R'))
			$purse = Configuration::get('WEBMONEY_PURSE_R');
		elseif ($currency->iso_code == 'USD' && Configuration::get('WEBMONEY_PURSE_Z'))
			$purse = Configuration::get('WEBMONEY_PURSE_Z');
		elseif ($currency->iso_code == 'EUR' && Configuration::get('WEBMONEY_PURSE_E'))
			$purse = Configuration::get('WEBMONEY_PURSE_E');

		$smarty->assign(array(
			'purse' => $purse,
			'orderid' => (int)$params['cart']->id,
			'amount' => number_format($params['cart']->getOrderTotal(true, 3), 2, '.', ''),
			'returnUrl' => 'http://'.htmlspecialchars($_SERVER['HTTP_HOST'], ENT_COMPAT, 'UTF-8').__PS_BASE_URI__.'modules/webmoney/validation.php',
			'cancelUrl' => 'http://'.htmlspecialchars($_SERVER['HTTP_HOST'], ENT_COMPAT, 'UTF-8').__PS_BASE_URI__.'order.php?step=3',
			'this_path' => $this->_path
		));

		return $this->display(__FILE__, 'payment.tpl');
    }		
}
?>