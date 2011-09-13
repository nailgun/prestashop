<?php

if (!defined('_CAN_LOAD_FILES_'))
	exit;

class ProductVk extends Module
{
	private $_html = '';
	private $_postErrors = array();
	
	public function __construct()
	{
		$this->name = 'productvk';
		$this->tab = 'front_office_features';
		$this->version = '1.0';
		$this->author = 'Dmitry Bashkatov';
		$this->need_instance = 0;

		parent::__construct();

		$this->displayName = $this->l('VK.COM Product Comments');
		$this->description = $this->l('Adds VK.COM comments form on product pages.');
	}

	public function install()
	{
		if (parent::install() == false OR $this->registerHook('productTab') == false
		OR $this->registerHook('productTabContent') == false
		OR $this->registerHook('header') == false
        OR !Configuration::updateValue('PRODUCT_VK_APIID', 0)
        OR !Configuration::updateValue('PRODUCT_VK_WIDTH', 496)
        OR !Configuration::updateValue('PRODUCT_VK_LIMIT', 10))
			return false;
		return true;
	}
	
	public function uninstall()
	{
        if (!parent::uninstall()
        OR !Configuration::deleteByName('PRODUCT_VK_APIID')
        OR !Configuration::deleteByName('PRODUCT_VK_WIDTH')
        OR !Configuration::deleteByName('PRODUCT_VK_LIMIT'))
			return false;
		return true;
	}

    public function getContent()
    {
        $errors = array();

        $output = '<h2>'.$this->displayName.'</h2>';

        if (Tools::isSubmit('submitProductVk')) {
            $apiid = (int)Tools::getValue('apiid');
            $width = (int)Tools::getValue('width');
            $limit = (int)Tools::getValue('limit');
            if ($apiid == 0) {
                $errors[] = $this->l('Invalid API ID.');
            }
            if ($width < 300) {
                $errors[] = $this->l('Width must be > 300px.');
            }
            if ($limit < 5 OR $limit > 100) {
                $errors[] = $this->l('Limit must be from 5 to 100.');
            }

            if (sizeof($errors) == 0) {
                Configuration::updateValue('PRODUCT_VK_APIID', $apiid);
                Configuration::updateValue('PRODUCT_VK_WIDTH', $width);
                Configuration::updateValue('PRODUCT_VK_LIMIT', $limit);
                $output .= $this->_displayOk();
            } else {
                $output .= $this->_displayErrors($errors);
            }
        }

        return $output.$this->_displayForm();
    }

    protected function _displayOk()
    {
        return
            '<div class="conf">
                <img src="../img/admin/ok2.png" /> Settings updated
            </div>';
    }

    protected function _displayErrors($errors)
    {
        $html = 
            '<div class="error">
                <img src="../img/admin/error2.png" />
                '.sizeof($errors).' '.(sizeof($errors) > 1 ? $this->l('errors') : $this->l('error')).'
                <ol>';

        foreach ($errors AS $error) {
            $html .= '<li>'.$error.'</li>';
        }

        $html .=
                '</ol>
            </div>';

        return $html;
    }

    protected function _displayForm()
    {
        return '
    <form action="'.Tools::htmlentitiesUTF8($_SERVER['REQUEST_URI']).'" method="post">
        <fieldset>
            <legend><img src="'.$this->_path.'logo.gif" alt="" title="" />'.$this->l('Settings').'</legend>

            <label>'.$this->l('API ID').'</label>
            <div class="margin-form">
                <input type="text" name="apiid" value="'.Configuration::get('PRODUCT_VK_APIID').'" />
                <p class="clear">'.$this->l('Your site registered VK.COM API ID').'</p>
            </div>

            <label>'.$this->l('Form width').'</label>
            <div class="margin-form">
                <input type="text" name="width" value="'.Configuration::get('PRODUCT_VK_WIDTH').'" />
                <p class="clear">'.$this->l('Form width in pixels (>300)').'</p>
            </div>

            <label>'.$this->l('Comment limit').'</label>
            <div class="margin-form">
                <input type="text" name="limit" value="'.Configuration::get('PRODUCT_VK_LIMIT').'" />
                <p class="clear">'.$this->l('Number of comments visible on page (5-100)').'</p>
            </div>

            <center><input type="submit" name="submitProductVk" value="'.$this->l('Save').'" class="button" /></center>
        </fieldset>
    </form>';
    }

	public function hookHeader()
	{
		global $smarty;

        Tools::addJS('http://userapi.com/js/api/openapi.js?34');

		$smarty->assign(array(
		'apiid' => (int)Configuration::get('PRODUCT_VK_APIID')));

		return ($this->display(__FILE__, '/head.tpl'));
	}
	
	public function hookProductTab($params)
    {
		return ($this->display(__FILE__, '/tab.tpl'));
	}

    public function hookProductTabContent($params)
    {
		global $smarty;
		
		$smarty->assign(array(
		'width' => (int)Configuration::get('PRODUCT_VK_WIDTH'),
		'limit' => (int)Configuration::get('PRODUCT_VK_LIMIT')));

		return ($this->display(__FILE__, '/content.tpl'));
	}
}
