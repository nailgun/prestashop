<?php

/*
{declension nb="110" expressions="товар,товара,товаров"}
*/

function smarty_function_declension ($params,&$smarty) {
	$totl = null;
	$expressions = explode(',',$params['expressions']);
	
	$count = $params['nb'] % 100;
	
	if ($count >= 5 && $count <= 20) {
		$result = $totl . ' ' . $expressions['2'];
	} else {
		$count = $count % 10;
		if ($count == 1) {
			$result = $totl . ' ' . $expressions['0'];
		} elseif ($count >= 2 && $count <= 4) {
			$result = $totl . ' ' . $expressions['1'];
		} else {
			$result = $totl . ' ' . $expressions['2'];
		}
	}
	return $result;
}

?>
