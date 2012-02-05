<?php

if (!defined('_CAN_LOAD_FILES_'))
	exit;

class AddCopy extends Module
{
	public function __construct()
	{
		$this->name = 'addcopy';
		$this->tab = 'front_office_features';
		$this->version = '1.0';
		$this->author = 'Dmitry Bashkatov';
		$this->need_instance = 0;

		parent::__construct();

		$this->displayName = $this->l('Add copyright');
		$this->description = $this->l('Copy-pasters protection.');
	}

	public function install()
	{
        if (parent::install() == false
            OR $this->registerHook('header') == false)
			return false;
		return true;
	}

	public function hookHeader()
	{
		global $smarty;

        Tools::addCSS(($this->_path).'jquery.addcopy.css', 'all');
        Tools::addJS(($this->_path).'rangy-core.js');
        Tools::addJS(($this->_path).'jquery.addcopy.min.js');

		$smarty->assign(array(
		'domain' => Configuration::get('PS_SHOP_DOMAIN')));

		return ($this->display(__FILE__, '/head.tpl'));
	}
}
