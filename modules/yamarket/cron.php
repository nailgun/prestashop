<?php

include(dirname(__FILE__).'/../../config/config.inc.php');
include(dirname(__FILE__).'/yamarket.php');

if (isset($_GET['secure_key']))
{
	$secureKey = Configuration::get('YAMARKET_SECURE_KEY');
	if (!empty($secureKey) AND $secureKey === $_GET['secure_key'])
	{
		$yamarket = new YaMarket();
		$yamarket->cronTask();
	}
}

