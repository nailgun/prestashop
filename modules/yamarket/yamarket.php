<?php

if (!defined('_CAN_LOAD_FILES_'))
	exit;

class YaMarket extends Module
{
	private $_html = '';
	private $_postErrors = array();

	public function __construct()
	{
		$this->name = 'yamarket';
		$this->tab = 'market_place';
		$this->version = '0.1';
		$this->author = 'Dmitry Bashkatov';
		$this->need_instance = 0;
		
		parent::__construct();

		$this->displayName = $this->l('Yandex.Market');
		$this->description = $this->l('Generate YML file for Yandex.Market');

		if (!defined('YML_FILE'))
			define('YML_FILE', dirname(__FILE__).'/../../market.yml');
	}
	
	public function install()
	{
		Configuration::updateValue('YAMARKET_SECURE_KEY', strtoupper(Tools::passwdGen(16)));
		return parent::install();
	}

	public function uninstall()
	{
        Configuration::deleteByName('YAMARKET_SECURE_KEY');
		file_put_contents(YML_FILE, '');
		return parent::uninstall();
	}
	
	private function _postValidation()
	{
		file_put_contents(YML_FILE, '');
		if (!($fp = fopen(YML_FILE, 'w')))
			$this->_postErrors[] = $this->l('Cannot create').' '.realpath(dirname(__FILE__.'/../..')).'/'.$this->l('market.yml file.');
		else
			fclose($fp);
	}
	
	private function getUrlWith($url, $key, $value)
	{
		if (empty($value))
			return $url;
		if (strpos($url, '?') !== false)
			return $url.'&'.$key.'='.$value;
		return $url.'?'.$key.'='.$value;
	}

	private function _postProcess()
	{
		Configuration::updateValue('YAMARKET_ALL_PRODUCTS', (int)Tools::getValue('YAMARKET_ALL_PRODUCTS'));
		
		$this->cronTask();

		$res = file_exists(YML_FILE);
		$this->_html .= '<h3 class="'. ($res ? 'conf confirm' : 'alert error') .'" style="margin-bottom: 20px">';
		$this->_html .= $res ? $this->l('YML file generated') : $this->l('Error while creating YML file');
		$this->_html .= '</h3>';
	}
	
	private function _addSitemapNode($xml, $loc, $priority, $change_freq, $last_mod = NULL)
	{		
		$sitemap = $xml->addChild('url');
		$sitemap->addChild('loc', $loc);
		$sitemap->addChild('priority',  $priority);
		if ($last_mod)
			$sitemap->addChild('lastmod', $last_mod);
		$sitemap->addChild('changefreq', $change_freq);
		return $sitemap;
	}
	
	private function _addSitemapNodeImage($xml, $product)
	{
		$link = new Link();	
		$image = $xml->addChild('image', null, 'http://www.google.com/schemas/sitemap-image/1.1');
		$image->addChild('loc', $link->getImageLink($product['link_rewrite'], (int)$product['id_product'].'-'.(int)$product['id_image']), 'http://www.google.com/schemas/sitemap-image/1.1');
		
		$legend_image = preg_replace('/(&+)/i', '&amp;', $product['legend_image']);
		$image->addChild('caption', $legend_image, 'http://www.google.com/schemas/sitemap-image/1.1');
		$image->addChild('title', $legend_image, 'http://www.google.com/schemas/sitemap-image/1.1');
	}

    private function _displayYml()
    {
        if (file_exists(YML_FILE) AND filesize(YML_FILE))
        {			
            $fp = fopen(YML_FILE, 'r');
            $fstat = fstat($fp);
            fclose($fp);
            $xml = simplexml_load_file(YML_FILE);
			
            $nbOffers = sizeof($xml->url);

            $this->_html .= '<p>'.$this->l('Your YML file is online at the following address:').'<br />
            <a href="'.Tools::getShopDomain(true, true).__PS_BASE_URI__.'market.yml" target="_blank"><b>'.Tools::getShopDomain(true, true).__PS_BASE_URI__.'market.yml</b></a></p><br />';

            $this->_html .= $this->l('Update:').' <b>'.utf8_encode(strftime('%A %d %B %Y %H:%M:%S',$fstat['mtime'])).'</b><br />';
            $this->_html .= $this->l('Filesize:').' <b>'.number_format(($fstat['size']*.000001), 3).'MB</b><br />';
            $this->_html .= $this->l('Number of offers:').' <b>'.$nbOffers.'</b><br /><br />';
        }
    }

	private function _displayForm()
	{
		$this->_html .=
		'<form action="'.Tools::htmlentitiesUTF8($_SERVER['REQUEST_URI']).'" method="post">
			<div style="margin:0 0 20px 0;">
				<input type="checkbox" name="YAMARKET_ALL_PRODUCTS" id="YAMARKET_ALL_PRODUCTS" style="vertical-align: middle;" value="1" '.(Configuration::get('YAMARKET_ALL_PRODUCTS') ? 'checked="checked"' : '').' /> <label class="t" for="YAMARKET_ALL_PRODUCTS">'.$this->l('YML also includes products from inactive categories').'</label>
			</div>
			<input name="btnSubmit" class="button" type="submit"
			value="'.((!file_exists(YML_FILE)) ? $this->l('Generate YML file') : $this->l('Update YML file')).'" />
		</form>';
	}
	
	public function getContent()
	{
		$this->_html .= '<h2>'.$this->l('Yandex.Market Export').'</h2>
		'.$this->l('See').' <a href="http://help.yandex.ru/partnermarket/" style="font-weight:bold;text-decoration:underline;" target="_blank">
		'.$this->l('this page').'</a> '.$this->l('for more information').'<br /><br />';

		$this->_html .= $this->l('Place this URL in crontab or call it manually daily:').'<br />
		<b>'.Tools::getShopDomain(true, true).__PS_BASE_URI__.'modules/yamarket/cron.php?secure_key='.Configuration::get('YAMARKET_SECURE_KEY').'</b><br /><br />';

		if (Tools::isSubmit('btnSubmit'))
		{
			$this->_postValidation();
			if (!sizeof($this->_postErrors))
				$this->_postProcess();
			else
				foreach ($this->_postErrors AS $err)
					$this->_html .= '<div class="alert error">'.$err.'</div>';
		}

		$this->_displayYml();
		$this->_displayForm();

		return $this->_html;
	}

	public function cronTask()
	{
		$link = new Link();
		$langs = Language::getLanguages();
				
		$xmlString = <<<XML
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE yml_catalog SYSTEM "shops.dtd">
<yml_catalog date="BLAH BLAH BLAH">
</yml_catalog>
XML;
		
		$xml = new SimpleXMLElement($xmlString);
        $shop_node = $xml->addChild('shop');

        # TODO:
        $id_lang = 2;

        # TODO:
        #date('Y-m-d')
        $shop_node->addChild('name', 'BLAH BLAH BLAH');
        $shop_node->addChild('company', 'BLAH BLAH BLAH');
        $shop_node->addChild('url', Tools::getShopDomain(true, true).__PS_BASE_URI__);

        # TODO: currencies
        $shop_node->addChild(new SimpleXMLElement('<currencies><currency id="RUR" rate="1" plus="0"/></currencies>'));

        # TODO:
        $shop_node->addChild('local_delivery_cost', '0');

        $categories_node = $shop_node->addChild('categories');

		/* Categories Generator */
        $categories = Db::getInstance()->ExecuteS(
        'SELECT c.id_category, c.id_parent, cl.name
        FROM '._DB_PREFIX_.'category c 
		LEFT JOIN '._DB_PREFIX_.'category_lang cl ON (c.id_category = cl.id_category)
        WHERE c.active = 1 AND cl.id_lang = '.$id_lang.'
        ORDER BY c.id_category ASC');
		
		foreach($categories as $category) {
            $category_node = $categories_node->addChild('category', $category['name']);
            $category_node->addAttribute('id', $category['id_category');
            if ($category['id_parent']) {
                $category_node->addAttribute('parentId', $category['id_parent');
            }
		}

        $offers_node = $shop_node->addChild('offers');

		$products = Db::getInstance(_PS_USE_SQL_SLAVE_)->ExecuteS('
		SELECT p.id_product, pl.link_rewrite, pl.name, cl.link_rewrite category_link_rewrite, pl.ean13, i.id_image,
		FROM '._DB_PREFIX_.'product p
		LEFT JOIN '._DB_PREFIX_.'product_lang pl ON (p.id_product = pl.id_product)
        LEFT JOIN '._DB_PREFIX_.'category_lang cl ON (p.id_category_default = cl.id_category)
		LEFT JOIN '._DB_PREFIX_.'image i ON p.id_product = i.id_product
		WHERE p.active = 1 AND pl.id_lang = '.$id_lang.' AND cl.id_lang = '.$id_lang.'
		ORDER BY p.id_product ASC');

		foreach($products as $product) {
			if (($priority = 0.7 - ($product['level_depth'] / 10)) < 0.1)
				$priority = 0.1;

			$tmpLink = $link->getProductLink((int)($product['id_product']), $product['link_rewrite'], $product['category'], $product['ean13'], (int)($product['id_lang']));
			$sitemap = $this->_addSitemapNode($xml, htmlspecialchars($tmpLink), $priority, 'weekly', substr($product['date_upd'], 0, 10));
			$sitemap = $this->_addSitemapNodeImage($sitemap, $product);
		}

		$xmlString = $xml->asXML();
		
		$fp = fopen(YML_FILE, 'w');
		fwrite($fp, $xmlString);
		fclose($fp);
	}
}
