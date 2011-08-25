SET NAMES 'utf8';

/* Carrier */
INSERT INTO `PREFIX_carrier` (`id_carrier`, `id_tax_rules_group`, `name`, `active`, `deleted`, `shipping_handling`, `is_free`) VALUES (2, 1, 'Курьер', 1, 0, 1, 0);
INSERT INTO `PREFIX_carrier_group` (`id_carrier`, `id_group`) VALUES (2, 1);
INSERT INTO `PREFIX_carrier_lang` (`id_carrier`, `id_lang`, `delay`) VALUES (2, 1, 'Delivery next day!'),(2, 2, 'Доставка на следующий день!');
INSERT INTO `PREFIX_carrier_zone` (`id_carrier`, `id_zone`) VALUES (2, 1),(2, 2);

UPDATE `PREFIX_configuration` SET `value` = '2' WHERE `name` = 'PS_CARRIER_DEFAULT';

INSERT INTO `PREFIX_configuration` (`name`, `value`, `date_add`, `date_upd`) VALUES
	('MB_PAY_TO_EMAIL', 'testmerchant@moneybookers.com', NOW(), NOW()),
	('MB_SECRET_WORD', 'mbtest', NOW(), NOW()),
	('MB_HIDE_LOGIN', 1, NOW(), NOW()),
	('MB_ID_LOGO', 1, NOW(), NOW()),
	('MB_ID_LOGO_WALLET', 1, NOW(), NOW()),
	('MB_PARAMETERS', 1, NOW(), NOW()),
	('MB_PARAMETERS_2', 1, NOW(), NOW()),
	('MB_DISPLAY_MODE', 0, NOW(), NOW()),
	('MB_CANCEL_URL', 'http://www.yoursite.com', NOW(), NOW()),
	('MB_LOCAL_METHODS', '2', NOW(), NOW()),
	('MB_INTER_METHODS', '5', NOW(), NOW()),
	('BANK_WIRE_CURRENCIES', '2,1', NOW(), NOW()),
	('CHEQUE_CURRENCIES', '2,1', NOW(), NOW()),
	('PRODUCTS_VIEWED_NBR', '2', NOW(), NOW()),
	('BLOCK_CATEG_DHTML', '1', NOW(), NOW()),
	('BLOCK_CATEG_MAX_DEPTH', '3', NOW(), NOW()),
	('MANUFACTURER_DISPLAY_FORM', '1', NOW(), NOW()),
	('MANUFACTURER_DISPLAY_TEXT', '1', NOW(), NOW()),
	('MANUFACTURER_DISPLAY_TEXT_NB', '5', NOW(), NOW()),
	('NEW_PRODUCTS_NBR', '5', NOW(), NOW()),
	('PS_TOKEN_ENABLE', '1', NOW(), NOW()),
	('PS_STATS_RENDER', 'graphxmlswfcharts', NOW(), NOW()),
	('PS_STATS_OLD_CONNECT_AUTO_CLEAN', 'never', NOW(), NOW()),
	('PS_STATS_GRID_RENDER', 'gridhtml', NOW(), NOW()),
	('BLOCKTAGS_NBR', '10', NOW(), NOW()),
	('CHECKUP_DESCRIPTIONS_LT', '100', NOW(), NOW()),
	('CHECKUP_DESCRIPTIONS_GT', '400', NOW(), NOW()),
	('CHECKUP_IMAGES_LT', '1', NOW(), NOW()),
	('CHECKUP_IMAGES_GT', '2', NOW(), NOW()),
	('CHECKUP_SALES_LT', '1', NOW(), NOW()),
	('CHECKUP_SALES_GT', '2', NOW(), NOW()),
	('CHECKUP_STOCK_LT', '1', NOW(), NOW()),
	('CHECKUP_STOCK_GT', '3', NOW(), NOW()),
	('FOOTER_CMS', '0_3|0_4', NOW(), NOW()),
	('FOOTER_BLOCK_ACTIVATION', '0_3|0_4', NOW(), NOW()),
	('FOOTER_POWEREDBY', 1, NOW(), NOW()),
	('BLOCKADVERT_LINK', 0, NOW(), NOW()),
	('BLOCKSTORE_IMG', 'store.jpg', NOW(), NOW());

INSERT INTO `PREFIX_module` (`id_module`, `name`, `active`) VALUES (1, 'homefeatured', 1),(2, 'gsitemap', 1),(3, 'cheque', 1),(4, 'moneybookers', 1),(5, 'editorial', 1),
(6, 'bankwire', 1),(7, 'blockadvertising', 1),(8, 'blockbestsellers', 1),(9, 'blockcart', 1),(10, 'blockcategories', 1),(11, 'blockcurrencies', 1),(12, 'blockcms', 1),
(13, 'blocklanguages', 1),(14, 'blockmanufacturer', 1),(15, 'blockmyaccount', 1),(16, 'blocknewproducts', 1),(17, 'blockpaymentlogo', 1),(18, 'blockpermanentlinks', 1),
(19, 'blocksearch', 1),(20, 'blockspecials', 1),(21, 'blocktags', 1),(22, 'blockuserinfo', 1),(24, 'blockviewed', 1),(25, 'statsdata', 1),
(26, 'statsvisits', 1),(27, 'statssales', 1),(28, 'statsregistrations', 1),(30, 'statspersonalinfos', 1),(31, 'statslive', 1),(32, 'statsequipment', 1),(33, 'statscatalog', 1),
(34, 'graphvisifire', 1),(35, 'graphxmlswfcharts', 1),(36, 'graphgooglechart', 1),(37, 'graphartichow', 1),(39, 'gridhtml', 1),(40, 'statsbestcustomers', 1),
(41, 'statsorigin', 1),(42, 'pagesnotfound', 1),(43, 'sekeywords', 1),(44, 'statsproduct', 1),(45, 'statsbestproducts', 1),(46, 'statsbestcategories', 1),
(47, 'statsbestvouchers', 1),(48, 'statsbestsuppliers', 1),(49, 'statscarrier', 1),(50, 'statsnewsletter', 1),(51, 'statssearch', 1),(52, 'statscheckup', 1),(53, 'statsstock', 1),
(54, 'blockstore', 1),(55, 'statsforecast', 1);

INSERT INTO `PREFIX_hook` (`name`, `title`, `description`, `position`) VALUES
	('myAccountBlock', 'My account block', 'Display extra informations inside the "my account" block', 1);

INSERT INTO `PREFIX_hook_module` (`id_module`, `id_hook`, `position`) VALUES (3, 1, 1),(6, 1, 2),(4, 1, 3),(4, 4, 3),(8, 2, 1),(3, 4, 1),(6, 4, 2),(9, 6, 1),(16, 6, 2),(8, 6, 3),
(20, 6, 4),(12, 6, 5),(54, 6, 6),(15, 7, 1),(21, 7, 2),(10, 7, 3),(24, 7, 4),(14, 7, 5),(12, 7, 6),(7, 7, 7),(17, 7, 8),(5, 8, 1),(1, 8, 2),(11, 14, 1),(13, 14, 2),(18, 14, 3),
(19, 14, 4),(22, 14, 5),(8, 19, 1),(12, 21, 1),(25, 11, 1),(25, 21, 2),(26, 32, 1),(27, 32, 2),(28, 32, 3),(30, 32, 4),(31, 32, 5),(32, 32, 6),(33, 32, 7),(34, 33, 1),
(35, 33, 2),(36, 33, 3),(37, 33, 4),(39, 37, 1),(40, 32, 8),(41, 32, 9),(42, 32, 10),(43, 32, 11),(42, 14, 6),(43, 14, 7),(44, 32, 12),(45, 32, 13),(46, 32, 15),
(47, 32, 14),(48, 32, 16),(49, 32, 17),(55, 32, 22),(50, 32, 18),(51, 32, 19),(51, 45, 1),(25, 25, 1),(41, 20, 2),(52, 32, 20),(53, 32, 21),(17, 9, 2),(18, 9, 3),(24, 9, 4),(9, 9, 5),
(15, 9, 6),(5, 9, 7),(8, 9, 8),(10, 9, 9),(20, 9, 10),(11, 9, 11),(16, 9, 12),(22, 9, 13),(13, 9, 14),(14, 9, 15),(12, 9, 16),(7, 9, 17),(21, 9, 18),(10, 60, 1),(10, 61, 1),(10, 62, 1),
(54, 9, 19),(10,66,1);

CREATE TABLE `PREFIX_pagenotfound` (
  `id_pagenotfound` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `request_uri` VARCHAR(256) NOT NULL,
  `http_referer` VARCHAR(256) NOT NULL,
  `date_add` DATETIME NOT NULL,
  PRIMARY KEY(`id_pagenotfound`)
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8;

CREATE TABLE `PREFIX_statssearch` (
	`id_statssearch` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`keywords` VARCHAR(255) NOT NULL,
	`results` INT(6) NOT NULL DEFAULT 0,
	`date_add` DATETIME NOT NULL,
	PRIMARY KEY(`id_statssearch`)
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8;

CREATE TABLE `PREFIX_sekeyword` (
	`id_sekeyword` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`keyword` VARCHAR(256) NOT NULL,
	`date_add` DATETIME NOT NULL,
	PRIMARY KEY(`id_sekeyword`)
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8;


CREATE TABLE `PREFIX_cms_block` (
	`id_cms_block` int(10) unsigned NOT NULL auto_increment,
	`id_cms_category` int(10) unsigned NOT NULL,
	`name` varchar(40) NOT NULL,
	`location` tinyint(1) unsigned NOT NULL,
	`position` int(10) unsigned NOT NULL default '0',
	`display_store` tinyint(1) unsigned NOT NULL DEFAULT '1',
	PRIMARY KEY (`id_cms_block`)
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8;

CREATE TABLE `PREFIX_cms_block_page` (
	`id_cms_block_page` int(10) unsigned NOT NULL auto_increment,
	`id_cms_block` int(10) unsigned NOT NULL,
	`id_cms` int(10) unsigned NOT NULL,
	`is_category` tinyint(1) unsigned NOT NULL,
	PRIMARY KEY (`id_cms_block_page`)
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8;

CREATE TABLE `PREFIX_cms_block_lang` (
	`id_cms_block` int(10) unsigned NOT NULL,
	`id_lang` int(10) unsigned NOT NULL,
	`name` varchar(40) NOT NULL default '',
	PRIMARY KEY (`id_cms_block`, `id_lang`)
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8;

CREATE TABLE `PREFIX_editorial` (
	`id_editorial` int(10) unsigned NOT NULL auto_increment,
	`body_home_logo_link` varchar(255) NOT NULL,
	PRIMARY KEY (`id_editorial`)
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8;

CREATE TABLE `PREFIX_editorial_lang` (
	`id_editorial` int(10) unsigned NOT NULL,
	`id_lang` int(10) unsigned NOT NULL,
	`body_title` varchar(255) NOT NULL,
	`body_subheading` varchar(255) NOT NULL,
	`body_paragraph` text NOT NULL,
	`body_logo_subheading` varchar(255) NOT NULL,
	PRIMARY KEY (`id_editorial`, `id_lang`)
) ENGINE=ENGINE_TYPE DEFAULT CHARSET=utf8;

INSERT INTO `PREFIX_editorial` (`id_editorial`, `body_home_logo_link`) VALUES (1, 'http://www.prestashop.com');
INSERT INTO `PREFIX_editorial_lang` (`id_editorial`, `id_lang`, `body_title`, `body_subheading`, `body_paragraph`, `body_logo_subheading`) VALUES
(1, 1, 'Lorem ipsum dolor sit amet', 'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum</p>', 'Excepteur sint prestashop cupidatat non proident'),
(1, 2, 'Охват аудитории как таргетирование', 'Охват аудитории как таргетирование', '<p>Производство, безусловно, искажает экспериментальный план размещения, признавая определенные рыночные тенденции. Целевой сегмент рынка упорядочивает из ряда вон выходящий план размещения, работая над проектом. В общем, показ баннера масштабирует культурный медиамикс, осознав маркетинг как часть производства. Стратегия сегментации отталкивает сублимированный принцип восприятия, расширяя долю рынка. Не факт, что молодежная аудитория искажает популярный отраслевой стандарт, опираясь на опыт западных коллег.</p>', 'Охват аудитории как таргетирование');

INSERT INTO `PREFIX_range_price` (`id_range_price`, `id_carrier`, `delimiter1`, `delimiter2`) VALUES (1, 2, 0, 10000);
INSERT INTO `PREFIX_range_weight` (`id_range_weight`, `id_carrier`, `delimiter1`, `delimiter2`) VALUES (1, 2, 0, 10000);
INSERT INTO `PREFIX_delivery` (`id_delivery`, `id_range_price`, `id_range_weight`, `id_carrier`, `id_zone`, `price`) VALUES
(1, NULL, 1, 2, 1, 5.00),(2, NULL, 1, 2, 2, 5.00),(4, 1, NULL, 2, 1, 5.00),(5, 1, NULL, 2, 2, 5.00);

INSERT INTO `PREFIX_customer_group` (`id_customer`, `id_group`) VALUES (1, 1);
INSERT INTO `PREFIX_category_group` (`id_category`, `id_group`) VALUES (2, 1),(3, 1),(4, 1);

INSERT INTO `PREFIX_manufacturer` (`id_manufacturer`, `name`, `date_add`, `date_upd`, `active`) VALUES (1, 'Apple Computer, Inc', NOW(), NOW(), 1);
INSERT INTO `PREFIX_manufacturer` (`id_manufacturer`, `name`, `date_add`, `date_upd`, `active`) VALUES(2, 'Shure Incorporated', NOW(), NOW(), 1);

INSERT INTO `PREFIX_manufacturer_lang` (`id_manufacturer`, `id_lang`, `description`, `short_description`, `meta_title`, `meta_keywords`, `meta_description`) VALUES 
(1, 1, '', '', '', '', ''),
(1, 2, '', '', '', '', '');

INSERT INTO `PREFIX_address` (`id_address`, `id_country`, `id_state`, `id_customer`, `id_manufacturer`, `id_supplier`, `alias`, `lastname`, `firstname`, `address1`, `postcode`, `city`, `phone`, `date_add`, `date_upd`, `active`, `deleted`)
	VALUES (1, 21, 5, 0, 1, 0, 'manufacturer', 'JOBS', 'STEVE', '1 Infinite Loop', '95014', 'Cupertino', '(800) 275-2273', NOW(), NOW(), 1, 0);

INSERT INTO `PREFIX_supplier` (`id_supplier`, `name`, `date_add`, `date_upd`, `active`) VALUES (1, 'AppleStore', NOW(), NOW(), 1);
INSERT INTO `PREFIX_supplier` (`id_supplier`, `name`, `date_add`, `date_upd`, `active`) VALUES (2, 'Shure Online Store', NOW(), NOW(), 1);

INSERT INTO `PREFIX_supplier_lang` (`id_supplier`, `id_lang`, `description`, `meta_title`, `meta_keywords`, `meta_description`) VALUES 
(1, 1, '', '', '', ''),
(1, 2, '', '', '', '');

INSERT INTO `PREFIX_product` (`id_product`, `indexed`, `id_supplier`, `id_manufacturer`, `id_tax_rules_group`, `id_category_default`, `id_color_default`, `on_sale`, `online_only`, `ean13`, `ecotax`, `quantity`, `price`, `wholesale_price`, `reference`, `supplier_reference`, `weight`, `out_of_stock`, `quantity_discount`, `customizable`, `uploadable_files`, `text_fields`, `active`, `date_add`, `date_upd`) VALUES
(1, 1, 1, 1, 1, 2, 2, 0, 0, '0', 0.00, 800, 124.581940, 70.000000, '', '', 0.5, 2, 0, 0, 0, 0, 1, NOW(), NOW()),
(2, 1, 1, 1, 1, 2, 0, 0, 0, '0', 0.00, 100, 66.053500, 33.000000, '', '', 0, 2, 0, 0, 0, 0, 1, NOW(), NOW()),
(5, 1, 1, 1, 1, 4, 0, 0, 0, '0', 0.00, 274, 1504.180602, 1000.000000, '', NULL, 1.36, 2, 0, 0, 0, 0, 1, NOW(), NOW()),
(6, 1, 1, 1, 1, 4, 0, 0, 0, '0', 0.00, 250, 1170.568561, 0.000000, '', NULL, 0.75, 2, 0, 0, 0, 0, 1, NOW(), NOW()),
(7, 1, 0, 0, 1, 2, 0, 0, 0, '', 0.00, 180, 241.638796, 200.000000, '', NULL, 0, 2, 0, 0, 0, 0, 1, NOW(), NOW()),
(8, 1, 0, 0, 1, 3, 0, 0, 1, '', 0.00, 1, 25.041806, 0.000000, '', NULL, 0, 2, 0, 0, 0, 0, 1, NOW(), NOW()),
(9, 1, 2, 2, 1, 3, 0, 0, 1, '', 0.00, 1, 124.581940, 0.000000, '', NULL, 0, 2, 0, 0, 0, 0, 1, NOW(), NOW());


INSERT INTO `PREFIX_product_lang` (`id_product`, `id_lang`, `description`, `description_short`, `link_rewrite`, `meta_description`, `meta_keywords`, `meta_title`, `name`, `available_now`, `available_later`) VALUES
(1, 1, '<p><strong><span style="font-size: small;">Curved ahead of the curve.</span></strong></p>\r\n<p>For those about to rock, we give you nine amazing colors. But that''s only part of the story. Feel the curved, all-aluminum and glass design and you won''t want to put iPod nano down.</p>\r\n<p><strong><span style="font-size: small;">Great looks. And brains, too.</span></strong></p>\r\n<p>The new Genius feature turns iPod nano into your own highly intelligent, personal DJ. It creates playlists by finding songs in your library that go great together.</p>\r\n<p><strong><span style="font-size: small;">Made to move with your moves.</span></strong></p>\r\n<p>The accelerometer comes to iPod nano. Give it a shake to shuffle your music. Turn it sideways to view Cover Flow. And play games designed with your moves in mind.</p>', '<p>New design. New features. Now in 8GB and 16GB. iPod nano rocks like never before.</p>', 'ipod-nano', '', '', '', 'iPod Nano', 'In stock', ''),
(1, 2, '<p><strong><span style="font-size: small;">Curved ahead of the curve.</span></strong></p>\r\n<p>For those about to rock, we give you nine amazing colors. But that''s only part of the story. Feel the curved, all-aluminum and glass design and you won''t want to put iPod nano down.</p>\r\n<p><strong><span style="font-size: small;">Great looks. And brains, too.</span></strong></p>\r\n<p>The new Genius feature turns iPod nano into your own highly intelligent, personal DJ. It creates playlists by finding songs in your library that go great together.</p>\r\n<p><strong><span style="font-size: small;">Made to move with your moves.</span></strong></p>\r\n<p>The accelerometer comes to iPod nano. Give it a shake to shuffle your music. Turn it sideways to view Cover Flow. And play games designed with your moves in mind.</p>', '<p>New design. New features. Now in 8GB and 16GB. iPod nano rocks like never before.</p>', 'ipod-nano', '', '', '', 'iPod Nano', 'На складе', ''),
(2, 1, '<p><span style="font-size: small;"><strong>Instant attachment.</strong></span></p>\r\n<p>Wear up to 500 songs on your sleeve. Or your belt. Or your gym shorts. iPod shuffle is a badge of musical devotion. Now in new, more brilliant colors.</p>\r\n<p><span style="font-size: small;"><strong>Feed your iPod shuffle.</strong></span></p>\r\n<p>iTunes is your entertainment superstore. It’s your ultra-organized music collection and jukebox. And it’s how you load up your iPod shuffle in one click.</p>\r\n<p><span style="font-size: small;"><strong>Beauty and the beat.</strong></span></p>\r\n<p>Intensely colorful anodized aluminum complements the simple design of iPod shuffle. Now in blue, green, pink, red, and original silver.</p>', '<p>iPod shuffle, the world’s most wearable music player, now clips on in more vibrant blue, green, pink, and red.</p>', 'ipod-shuffle', '', '', '', 'iPod shuffle', 'In stock', ''),
(2, 2, '<p><span style="font-size: small;"><strong>Instant attachment.</strong></span></p>\r\n<p>Wear up to 500 songs on your sleeve. Or your belt. Or your gym shorts. iPod shuffle is a badge of musical devotion. Now in new, more brilliant colors.</p>\r\n<p><span style="font-size: small;"><strong>Feed your iPod shuffle.</strong></span></p>\r\n<p>iTunes is your entertainment superstore. It’s your ultra-organized music collection and jukebox. And it’s how you load up your iPod shuffle in one click.</p>\r\n<p><span style="font-size: small;"><strong>Beauty and the beat.</strong></span></p>\r\n<p>Intensely colorful anodized aluminum complements the simple design of iPod shuffle. Now in blue, green, pink, red, and original silver.</p>', '<p>iPod shuffle, the world’s most wearable music player, now clips on in more vibrant blue, green, pink, and red.</p>', 'ipod-shuffle', '', '', '', 'iPod shuffle', 'На складе', ''),
(5, 1, '<p>MacBook Air is nearly as thin as your index finger. Practically every detail that could be streamlined has been. Yet it still has a 13.3-inch widescreen LED display, full-size keyboard, and large multi-touch trackpad. It’s incomparably portable without the usual ultraportable screen and keyboard compromises.</p><p>The incredible thinness of MacBook Air is the result of numerous size- and weight-shaving innovations. From a slimmer hard drive to strategically hidden I/O ports to a lower-profile battery, everything has been considered and reconsidered with thinness in mind.</p><p>MacBook Air is designed and engineered to take full advantage of the wireless world. A world in which 802.11n Wi-Fi is now so fast and so available, people are truly living untethered — buying and renting movies online, downloading software, and sharing and storing files on the web. </p>', 'MacBook Air is ultrathin, ultraportable, and ultra unlike anything else. But you don’t lose inches and pounds overnight. It’s the result of rethinking conventions. Of multiple wireless innovations. And of breakthrough design. With MacBook Air, mobile computing suddenly has a new standard.', 'macbook-air', '', '', '', 'MacBook Air', '', NULL),
(5, 2, '<p>MacBook Air is nearly as thin as your index finger. Practically every detail that could be streamlined has been. Yet it still has a 13.3-inch widescreen LED display, full-size keyboard, and large multi-touch trackpad. It’s incomparably portable without the usual ultraportable screen and keyboard compromises.</p><p>The incredible thinness of MacBook Air is the result of numerous size- and weight-shaving innovations. From a slimmer hard drive to strategically hidden I/O ports to a lower-profile battery, everything has been considered and reconsidered with thinness in mind.</p><p>MacBook Air is designed and engineered to take full advantage of the wireless world. A world in which 802.11n Wi-Fi is now so fast and so available, people are truly living untethered — buying and renting movies online, downloading software, and sharing and storing files on the web. </p>', 'MacBook Air is ultrathin, ultraportable, and ultra unlike anything else. But you don’t lose inches and pounds overnight. It’s the result of rethinking conventions. Of multiple wireless innovations. And of breakthrough design. With MacBook Air, mobile computing suddenly has a new standard.', 'macbook-air', '', '', '', 'MacBook Air', '', NULL),
(6, 1, 'Every MacBook has a larger hard drive, up to 250GB, to store growing media collections and valuable data.<br /><br />The 2.4GHz MacBook models now include 2GB of memory standard — perfect for running more of your favorite applications smoothly.', 'MacBook makes it easy to hit the road thanks to its tough polycarbonate case, built-in wireless technologies, and innovative MagSafe Power Adapter that releases automatically if someone accidentally trips on the cord.', 'macbook', '', '', '', 'MacBook', '', NULL),
(6, 2, 'Every MacBook has a larger hard drive, up to 250GB, to store growing media collections and valuable data.<br /><br />The 2.4GHz MacBook models now include 2GB of memory standard — perfect for running more of your favorite applications smoothly.', 'MacBook makes it easy to hit the road thanks to its tough polycarbonate case, built-in wireless technologies, and innovative MagSafe Power Adapter that releases automatically if someone accidentally trips on the cord.', 'macbook', '', '', '', 'MacBook', '', NULL),
(7, 1, '<h3>Five new hands-on applications</h3>\r\n<p>View rich HTML email with photos as well as PDF, Word, and Excel attachments. Get maps, directions, and real-time traffic information. Take notes and read stock and weather reports.</p>\r\n<h3>Touch your music, movies, and more</h3>\r\n<p>The revolutionary Multi-Touch technology built into the gorgeous 3.5-inch display lets you pinch, zoom, scroll, and flick with your fingers.</p>\r\n<h3>Internet in your pocket</h3>\r\n<p>With the Safari web browser, see websites the way they were designed to be seen and zoom in and out with a tap.<sup>2</sup> And add Web Clips to your Home screen for quick access to favorite sites.</p>\r\n<h3>What''s in the box</h3>\r\n<ul>\r\n<li><span></span>iPod touch</li>\r\n<li><span></span>Earphones</li>\r\n<li><span></span>USB 2.0 cable</li>\r\n<li><span></span>Dock adapter</li>\r\n<li><span></span>Polishing cloth</li>\r\n<li><span></span>Stand</li>\r\n<li><span></span>Quick Start guide</li>\r\n</ul>', '<ul>\r\n<li>Revolutionary Multi-Touch interface</li>\r\n<li>3.5-inch widescreen color display</li>\r\n<li>Wi-Fi (802.11b/g)</li>\r\n<li>8 mm thin</li>\r\n<li>Safari, YouTube, Mail, Stocks, Weather, Notes, iTunes Wi-Fi Music Store, Maps</li>\r\n</ul>', 'ipod-touch', '', '', '', 'iPod touch', '', NULL),
(7, 2, '<h3>Five new hands-on applications</h3>\r\n<p>View rich HTML email with photos as well as PDF, Word, and Excel attachments. Get maps, directions, and real-time traffic information. Take notes and read stock and weather reports.</p>\r\n<h3>Touch your music, movies, and more</h3>\r\n<p>The revolutionary Multi-Touch technology built into the gorgeous 3.5-inch display lets you pinch, zoom, scroll, and flick with your fingers.</p>\r\n<h3>Internet in your pocket</h3>\r\n<p>With the Safari web browser, see websites the way they were designed to be seen and zoom in and out with a tap.<sup>2</sup> And add Web Clips to your Home screen for quick access to favorite sites.</p>\r\n<h3>What''s in the box</h3>\r\n<ul>\r\n<li><span></span>iPod touch</li>\r\n<li><span></span>Earphones</li>\r\n<li><span></span>USB 2.0 cable</li>\r\n<li><span></span>Dock adapter</li>\r\n<li><span></span>Polishing cloth</li>\r\n<li><span></span>Stand</li>\r\n<li><span></span>Quick Start guide</li>\r\n</ul>', '<ul>\r\n<li>Revolutionary Multi-Touch interface</li>\r\n<li>3.5-inch widescreen color display</li>\r\n<li>Wi-Fi (802.11b/g)</li>\r\n<li>8 mm thin</li>\r\n<li>Safari, YouTube, Mail, Stocks, Weather, Notes, iTunes Wi-Fi Music Store, Maps</li>\r\n</ul>', 'ipod-touch', '', '', '', 'iPod touch', '', NULL),
(8, 1, '<p>Lorem ipsum</p>', '<p>Lorem ipsum</p>', 'belkin-leather-folio-for-ipod-nano-black-chocolate', '', '', '', 'Belkin Leather Folio for iPod nano - Black / Chocolate', '', NULL),
(8, 2, '<p>Lorem ipsum</p>', '<p>Lorem ipsum</p>', 'belkin-leather-folio-for-ipod-nano-black-chocolate', '', '', '', 'Belkin Leather Folio for iPod nano - Black / Chocolate', '', NULL),
(9, 1, '<div class="product-overview-full">Using Hi-Definition MicroSpeakers to deliver full-range audio, the ergonomic and lightweight design of the SE210 earphones is ideal for premium on-the-go listening on your iPod or iPhone. They offer the most accurate audio reproduction from both portable and home stereo audio sources--for the ultimate in precision highs and rich low end. In addition, the flexible design allows you to choose the most comfortable fit from a variety of wearing positions. <br /> <br /> <strong>Features </strong> <br /> \r\n<ul>\r\n<li>Sound-isolating design </li>\r\n<li> Hi-Definition MicroSpeaker with a single balanced armature driver </li>\r\n<li> Detachable, modular cable so you can make the cable longer or shorter depending on your activity </li>\r\n<li> Connector compatible with earphone ports on both iPod and iPhone </li>\r\n</ul>\r\n<strong>Specifications </strong><br /> \r\n<ul>\r\n<li>Speaker type: Hi-Definition MicroSpeaker </li>\r\n<li> Frequency range: 25Hz-18.5kHz </li>\r\n<li> Impedance (1kHz): 26 Ohms </li>\r\n<li> Sensitivity (1mW): 114 dB SPL/mW </li>\r\n<li> Cable length (with extension): 18.0 in./45.0 cm (54.0 in./137.1 cm) </li>\r\n</ul>\r\n<strong>In the box</strong><br /> \r\n<ul>\r\n<li>Shure SE210 earphones </li>\r\n<li> Extension cable (36.0 in./91.4 cm) </li>\r\n<li> Three pairs foam earpiece sleeves (small, medium, large) </li>\r\n<li> Three pairs soft flex earpiece sleeves (small, medium, large) </li>\r\n<li> One pair triple-flange earpiece sleeves </li>\r\n<li> Carrying case </li>\r\n</ul>\r\nWarranty<br /> Two-year limited <br />(For details, please visit <br />www.shure.com/PersonalAudio/CustomerSupport/ProductReturnsAndWarranty/index.htm.) <br /><br /> Mfr. Part No.: SE210-A-EFS <br /><br />Note: Products sold through this website that do not bear the Apple Brand name are serviced and supported exclusively by their manufacturers in accordance with terms and conditions packaged with the products. Apple''s Limited Warranty does not apply to products that are not Apple-branded, even if packaged or sold with Apple products. Please contact the manufacturer directly for technical support and customer service.</div>', '<p>Evolved from personal monitor technology road-tested by pro musicians and perfected by Shure engineers, the lightweight and stylish SE210 delivers full-range audio that''s free from outside noise.</p>', 'ecouteurs-a-isolation-sonore-shure-se210-blanc', '', '', '', 'Shure SE210 Sound-Isolating Earphones for iPod and iPhone', '', NULL),
(9, 2, '<div class="product-overview-full">Using Hi-Definition MicroSpeakers to deliver full-range audio, the ergonomic and lightweight design of the SE210 earphones is ideal for premium on-the-go listening on your iPod or iPhone. They offer the most accurate audio reproduction from both portable and home stereo audio sources--for the ultimate in precision highs and rich low end. In addition, the flexible design allows you to choose the most comfortable fit from a variety of wearing positions. <br /> <br /> <strong>Features </strong> <br /> \r\n<ul>\r\n<li>Sound-isolating design </li>\r\n<li> Hi-Definition MicroSpeaker with a single balanced armature driver </li>\r\n<li> Detachable, modular cable so you can make the cable longer or shorter depending on your activity </li>\r\n<li> Connector compatible with earphone ports on both iPod and iPhone </li>\r\n</ul>\r\n<strong>Specifications </strong><br /> \r\n<ul>\r\n<li>Speaker type: Hi-Definition MicroSpeaker </li>\r\n<li> Frequency range: 25Hz-18.5kHz </li>\r\n<li> Impedance (1kHz): 26 Ohms </li>\r\n<li> Sensitivity (1mW): 114 dB SPL/mW </li>\r\n<li> Cable length (with extension): 18.0 in./45.0 cm (54.0 in./137.1 cm) </li>\r\n</ul>\r\n<strong>In the box</strong><br /> \r\n<ul>\r\n<li>Shure SE210 earphones </li>\r\n<li> Extension cable (36.0 in./91.4 cm) </li>\r\n<li> Three pairs foam earpiece sleeves (small, medium, large) </li>\r\n<li> Three pairs soft flex earpiece sleeves (small, medium, large) </li>\r\n<li> One pair triple-flange earpiece sleeves </li>\r\n<li> Carrying case </li>\r\n</ul>\r\nWarranty<br /> Two-year limited <br />(For details, please visit <br />www.shure.com/PersonalAudio/CustomerSupport/ProductReturnsAndWarranty/index.htm.) <br /><br /> Mfr. Part No.: SE210-A-EFS <br /><br />Note: Products sold through this website that do not bear the Apple Brand name are serviced and supported exclusively by their manufacturers in accordance with terms and conditions packaged with the products. Apple''s Limited Warranty does not apply to products that are not Apple-branded, even if packaged or sold with Apple products. Please contact the manufacturer directly for technical support and customer service.</div>', '<p>Evolved from personal monitor technology road-tested by pro musicians and perfected by Shure engineers, the lightweight and stylish SE210 delivers full-range audio that''s free from outside noise.</p>', 'ecouteurs-a-isolation-sonore-shure-se210-blanc', '', '', '', 'Shure SE210 Sound-Isolating Earphones for iPod and iPhone', '', NULL);

INSERT INTO `PREFIX_specific_price` (`id_product`, `id_shop`, `id_currency`, `id_country`, `id_group`, `price`, `from_quantity`, `reduction`, `reduction_type`, `from`, `to`) VALUES
(1, 0, 0, 0, 0, 0, 1, 0.05, 'percentage', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

INSERT INTO `PREFIX_category` (`id_category`, `id_parent`, `level_depth`, `nleft`, `nright`, `active`, `date_add`, `date_upd`, `position`) VALUES
(2, 1, 1, 2, 3, 1, NOW(), NOW(), 0),(3, 1, 1, 3, 4, 1, NOW(), NOW(), 1),(4, 1, 1, 4, 5, 1, NOW(), NOW(), 2);

INSERT INTO `PREFIX_category_lang` (`id_category`, `id_lang`, `name`, `description`, `link_rewrite`, `meta_title`, `meta_keywords`, `meta_description`) VALUES
(2, 1, 'iPods', 'Now that you can buy movies from the iTunes Store and sync them to your iPod, the whole world is your theater.', 'music-ipods', '', '', ''),
(2, 2, 'Айподы', 'Now that you can buy movies from the iTunes Store and sync them to your iPod, the whole world is your theater.', 'music-ipods', '', '', ''),
(3, 1, 'Accessories', 'Wonderful accessories for your iPod', 'accessories-ipod', '', '', ''),
(3, 2, 'Аксессуары', 'Wonderful accessories for your iPod', 'accessories-ipod', '', '', ''),
(4, 2, 'Ноутбуки', 'The latest Intel processor, a bigger hard drive, plenty of memory, and even more new features all fit inside just one liberating inch. The new Mac laptops have the performance, power, and connectivity of a desktop computer. Without the desk part.', 'laptops', 'Apple laptops', 'Apple laptops MacBook Air', 'Powerful and chic Apple laptops');

INSERT INTO `PREFIX_category_product` (`id_category`, `id_product`, `position`) VALUES
(1, 1, 0),(1, 2, 1),(1, 6, 2),(1, 7, 3),(2, 1, 0),(2, 2, 1),(2, 7, 2),(3, 8, 0),(3, 9, 1),(4, 5, 0),(4, 6, 1);

INSERT INTO `PREFIX_attribute_group` (`id_attribute_group`, `is_color_group`) VALUES (1, 0),(2, 1),(3, 0);

INSERT INTO `PREFIX_attribute_group_lang` (`id_attribute_group`, `id_lang`, `name`, `public_name`) VALUES
(1, 1, 'Disk space', 'Disk space'),(1, 2, 'Дисковое пространство', 'Диск'),(2, 1, 'Color', 'Color'),(2, 2, 'Цвет', 'Цвет'),(3, 1, 'ICU', 'Processor'),(3, 2, 'Процессор', 'Процессор');

INSERT INTO `PREFIX_attribute_impact` (`id_attribute_impact`, `id_product`, `id_attribute`, `weight`, `price`) VALUES
(1, 1, 2, 0, 60.00),(2, 1, 5, 0, 0.00),(3, 1, 16, 0, 50.00),(4, 1, 15, 0, 0.00),(5, 1, 4, 0, 0.00),(6, 1, 19, 0, 0.00),(7, 1, 3, 0, 0.00),(8, 1, 14, 0, 0.00),
(9, 1, 7, 0, 0.00),(10, 1, 20, 0, 0.00),(11, 1, 6, 0, 0.00),(12, 1, 18, 0, 0.00);

INSERT INTO `PREFIX_scene` (`id_scene`, `active`) VALUES (1, 1),(2, 1),(3, 1);

INSERT INTO `PREFIX_scene_category` (`id_scene`, `id_category`) VALUES (1, 2),(2, 2),(3, 4);

INSERT INTO `PREFIX_scene_lang` (`id_scene`, `id_lang`, `name`) VALUES
(1, 1, 'The iPods Nano'),(1, 2, 'iPod Nano'),
(2, 1, 'The iPods'),(2, 2, 'iPod'),
(3, 1, 'The MacBooks'),(3, 2, 'MacBook');

INSERT INTO `PREFIX_scene_products` (`id_scene`, `id_product`, `x_axis`, `y_axis`, `zone_width`, `zone_height`) VALUES
(1, 1, 474, 15, 72, 166),(2, 2, 389, 137, 51, 46),(2, 7, 111, 83, 161, 108),(2, 1, 340, 31, 46, 151),(3, 6, 355, 37, 151, 103),(3, 6, 50, 47, 128, 84),
(3, 5, 198, 47, 137, 92),(1, 1, 394, 14, 73, 168),(1, 1, 318, 14, 69, 168),(1, 1, 244, 14, 66, 169),(1, 1, 180, 13, 59, 168),(1, 1, 6, 12, 30, 175),
(1, 1, 38, 12, 30, 170),(1, 1, 76, 14, 41, 169),(1, 1, 123, 13, 49, 169);

INSERT INTO `PREFIX_attribute` (`id_attribute`, `id_attribute_group`) VALUES (1, 1),(2, 1),(8, 1),(9, 1),(10, 3),(11, 3),(12, 1),(13, 1);
INSERT INTO `PREFIX_attribute` (`id_attribute`, `id_attribute_group`, `color`) VALUES (3, 2, '#D2D6D5'),(4, 2, '#008CB7'),(5, 2, '#F3349E'),(6, 2, '#93D52D'),
(7, 2, '#FD9812'),(15, 1, ''),(16, 1, ''),(17, 1, ''),(18, 2, '#7800F0'),(19, 2, '#F6EF04'),(20, 2, '#F60409'),(14, 2, '#000000');

INSERT INTO `PREFIX_attribute_lang` VALUES (1, 1, '2GB'),(1, 2, '2Гб.'),(2, 1, '4GB'),(2, 2, '4Гб.'),(3, 1, 'Metal'),(3, 2, 'Металик'),
(4, 1, 'Blue'),(4, 2, 'Синий'),(5, 1, 'Pink'),(5, 2, 'Розовый'),(6, 1, 'Green'),(6, 2, 'Зеленый'),(7, 1, 'Orange'),(7, 2, 'Оранжевый'),
(8, 1, 'Optional 64GB solid-state drive'),(8, 2, 'Дополнительный диск на 64 Гб.'),
(9, 1, '80GB Parallel ATA Drive @ 4200 rpm'),(9, 2, '80 Гб. Parallel ATA Drive @ 4200 оборотов в мин.'),(10, 1, '1.60GHz Intel Core 2 Duo'),
(10, 2, '1.60GHz Intel Core 2 Duo'),(11, 1, '1.80GHz Intel Core 2 Duo'),(11, 2, '1.80GHz Intel Core 2 Duo'),
(12, 1, '80GB: 20,000 Songs'),(12, 2, '80Гб.: 20 000 песен'),(13, 1, '160GB: 40,000 Songs'),
(13, 2, '160Гб.: 40 000 песен'),(14, 2, 'Черный'),(14, 1, 'Black'),(15, 1, '8Go'),(15, 2, '8Гб.'),
(16, 1, '16Go'),(16, 2, '16Гб.'),(17, 1, '32Go'),(17, 2, '32Гб.');

INSERT INTO `PREFIX_attribute_lang` (`id_attribute`, `id_lang`, `name`) VALUES
(18, 1, 'Purple'),(18, 2, 'Пурпурный'),(19, 1, 'Yellow'),(19, 2, 'Желтый'),(20, 1, 'Red'),(20, 2, 'Красный');

INSERT INTO `PREFIX_product_attribute` (`id_product_attribute`, `id_product`, `reference`, `supplier_reference`, `ean13`, `wholesale_price`, `price`, `ecotax`, `quantity`, `weight`, `default_on`, `minimal_quantity`) VALUES
(30, 1, '', '', '', 0.000000, 0.00, 0.00, 50, 0, 0, 1),
(29, 1, '', '', '', 0.000000, 41.806020, 0.00, 50, 0, 0, 1),
(28, 1, '', '', '', 0.000000, 0.00, 0.00, 50, 0, 0, 1),
(27, 1, '', '', '', 0.000000, 41.806020, 0.00, 50, 0, 0, 1),
(26, 1, '', '', '', 0.000000, 0.00, 0.00, 50, 0, 0, 1),
(25, 1, '', '', '', 0.000000, 41.806020, 0.00, 50, 0, 0, 4),
(7, 2, '', '', '', 0.000000, 0.00, 0.00, 10, 0, 0, 1),
(8, 2, '', '', '', 0.000000, 0.00, 0.00, 20, 0, 1, 1),
(9, 2, '', '', '', 0.000000, 0.00, 0.00, 30, 0, 0, 1),
(10, 2, '', '', '', 0.000000, 0.00, 0.00, 40, 0, 0, 1),
(12, 5, '', NULL, '', 0.000000, 751.672241, 0.00, 100, 0, 0, 1),
(13, 5, '', NULL, '', 0.000000, 0.00, 0.00, 99, 0, 1, 1),
(14, 5, '', NULL, '', 0.000000, 225.752508, 0.00, 50, 0, 0, 1),
(15, 5, '', NULL, '', 0.000000, 977.424749, 0.00, 25, 0, 0, 1),
(23, 7, '', NULL, '', 0.000000, 150.501672, 0.00, 70, 0, 0, 1),
(22, 7, '', NULL, '', 0.000000, 75.250836, 0.00, 60, 0, 0, 1),
(19, 7, '', NULL, '', 0.000000, 0.00, 0.00, 50, 0, 1, 1),
(31, 1, '', '', '', 0.000000, 41.806020, 0.00, 50, 0, 1, 1),
(32, 1, '', '', '', 0.000000, 0.00, 0.00, 50, 0, 0, 1),
(33, 1, '', '', '', 0.000000, 41.806020, 0.00, 50, 0, 0, 1),
(34, 1, '', '', '', 0.000000, 0.00, 0.00, 50, 0, 0, 1),
(35, 1, '', '', '', 0.000000, 41.806020, 0.00, 50, 0, 0, 1),
(36, 1, '', '', '', 0.000000, 0.00, 0.00, 50, 0, 0, 1),
(39, 1, '', '', '', 0.000000, 41.806020, 0.00, 50, 0, 0, 1),
(40, 1, '', '', '', 0.000000, 0.00, 0.00, 50, 0, 0, 1),
(41, 1, '', '', '', 0.000000, 41.806020, 0.00, 50, 0, 0, 1),
(42, 1, '', '', '', 0.000000, 0.00, 0.00, 50, 0, 0, 1);

INSERT INTO `PREFIX_product_attribute_image` (`id_product_attribute`, `id_image`) VALUES (30, 44),(29, 44),(28, 45),(27, 45),(26, 38),(25, 38),(7, 46),(8, 47),(9, 49),
(10, 48),(12, 0),(13, 0),(14, 0),(15, 0),(23, 0),(22, 0),(19, 0),(31, 37),(32, 37),(33, 40),(34, 40),(35, 41),(36, 41),(39, 39),(40, 39),(41, 42),(42, 42);

INSERT INTO `PREFIX_product_attribute_combination` (`id_attribute`, `id_product_attribute`) VALUES (3, 9),(3, 12),(3, 13),(3, 14),(3, 15),(3, 29),(3, 30),(4, 7),(4, 25),
(4, 26),(5, 10),(5, 35),(5, 36),(6, 8),(6, 39),(6, 40),(7, 33),(7, 34),(8, 13),(8, 15),(9, 12),(9, 14),(10, 12),(10, 13),(11, 14),(11, 15),(14, 31),(14, 32),(15, 19),
(15, 26),(15, 28),(15, 30),(15, 32),(15, 34),(15, 36),(15, 40),(15, 42),(16, 22),(16, 25),(16, 27),(16, 29),(16, 31),(16, 33),(16, 35),(16, 39),(16, 41),(17, 23),(18, 41),(18, 42),(19, 27),(19, 28);

INSERT INTO `PREFIX_feature` (`id_feature`) VALUES (1), (2), (3), (4), (5);

INSERT INTO `PREFIX_feature_lang` (`id_feature`, `id_lang`, `name`) VALUES
(1, 1, 'Height'), (1, 2, 'Высота'),(2, 1, 'Width'), (2, 2, 'Ширина'),(3, 1, 'Depth'), (3, 2, 'Толщина'),(4, 1, 'Weight'), (4, 2, 'Вес'),(5, 1, 'Headphone'), (5, 2, 'Наушники');

INSERT INTO `PREFIX_feature_product` (`id_feature`, `id_product`, `id_feature_value`) VALUES
(1, 1, 11),(1, 2, 15),(2, 1, 12),(2, 2, 16),(3, 1, 14),(3, 2, 18),(4, 1, 13),(4, 2, 17),(5, 1, 10),(5, 2, 10),(3, 7, 26),(5, 7, 9),(4, 7, 25),(2, 7, 24),(1, 7, 23);

INSERT INTO `PREFIX_feature_value` (`id_feature_value`, `id_feature`, `custom`) VALUES
(11, 1, 1),(15, 1, 1),(12, 2, 1),(16, 2, 1),(14, 3, 1),(18, 3, 1),(13, 4, 1),(17, 4, 1),(26, 3, 1),(25, 4, 1),(24, 2, 1),(23, 1, 1),(9, 5, 0),(10, 5, 0);

INSERT INTO `PREFIX_feature_value_lang` (`id_feature_value`, `id_lang`, `value`) VALUES
(13, 1, '49.2 g'),(13, 2, '49,2 г.'),
(12, 1, '2.06 in'),(12, 2, '52,3 мм.'),
(11, 1, '2.75 in'),(11, 2, '69,8 мм.'),
(17, 1, '15.5 g'),(17, 2, '15,5 г.'),
(16, 1, '1.62 in'),(16, 2, '41,2 мм.'),
(15, 1, '1.07 in'),(15, 2, '27,3 мм.'),
(9, 1, 'Jack stereo'),(9, 2, 'Jack stereo'),
(10, 1, 'Mini-jack stereo'),(10, 2, 'Mini-jack'),
(14, 1, '0.26 in'),(14, 2, '6,5 мм.'),
(18, 1, '0.41 in (clip included)'),(18, 2, '10,5 мм.'),
(26, 1, '0.31 in'),(26, 2, '8 мм.'),
(25, 1, '120g'),(25, 2, '120г.'),
(24, 1, '2.76 in'),(24, 2, '70 мм.'),
(23, 1, '4.33 in'),(23, 2, '110 мм.');

INSERT INTO `PREFIX_image` (`id_image`, `id_product`, `position`, `cover`) VALUES
(40, 1, 4, 0),(39, 1, 3, 0),(38, 1, 2, 0),(37, 1, 1, 1),(48, 2, 3, 0),(47, 2, 2, 0),(49, 2, 4, 0),(46, 2, 1, 1),(15, 5, 1, 1),(16, 5, 2, 0),(17, 5, 3, 0),(18, 6, 4, 0),(19, 6, 5, 0),
(20, 6, 1, 1),(24, 7, 1, 1),(33, 8, 1, 1),(27, 7, 3, 0),(26, 7, 2, 0),(29, 7, 4, 0),(30, 7, 5, 0),(32, 7, 6, 0),(36, 9, 1, 1),(41, 1, 5, 0),(42, 1, 6, 0),(44, 1, 7, 0),(45, 1, 8, 0);

INSERT INTO `PREFIX_image_lang` (`id_image`, `id_lang`, `legend`) VALUES
(40, 2, 'iPod Nano'),(40, 1, 'iPod Nano'),
(39, 2, 'iPod Nano'),(39, 1, 'iPod Nano'),
(38, 2, 'iPod Nano'),(38, 1, 'iPod Nano'),
(37, 2, 'iPod Nano'),(37, 1, 'iPod Nano'),
(48, 2, 'iPod shuffle'),(48, 1, 'iPod shuffle'),
(47, 2, 'iPod shuffle'),(47, 1, 'iPod shuffle'),
(49, 2, 'iPod shuffle'),(49, 1, 'iPod shuffle'),
(46, 2, 'iPod shuffle'),(46, 1, 'iPod shuffle'),
(10, 1, 'luxury-cover-for-ipod-video'),(10, 2, 'luxury-cover-for-ipod-video'),
(11, 1, 'cover'),(11, 2, 'cover'),
(12, 1, 'myglove-ipod-nano'),(12, 2, 'myglove-ipod-nano'),
(13, 1, 'myglove-ipod-nano'),(13, 2, 'myglove-ipod-nano'),
(14, 1, 'myglove-ipod-nano'),(14, 2, 'myglove-ipod-nano'),
(15, 1, 'MacBook Air'),(15, 2, 'MacBook Air'),
(16, 1, 'MacBook Air'),(16, 2, 'MacBook Air'),
(17, 1, 'MacBook Air'),(17, 2, 'MacBook Air'),
(18, 1, 'MacBook Air'),(18, 2, 'MacBook Air'),
(19, 1, 'MacBook Air'),(19, 2, 'MacBook Air'),
(20, 1, 'MacBook Air SuperDrive'),(20, 2, 'MacBook Air SuperDrive'),
(24, 2, 'iPod touch'),(24, 1, 'iPod touch'),
(33, 1, 'housse-portefeuille-en-cuir'),(33, 2, 'housse-portefeuille-en-cuir'),
(26, 1, 'iPod touch'),(26, 2, 'iPod touch'),
(27, 1, 'iPod touch'),(27, 2, 'iPod touch'),
(29, 1, 'iPod touch'),(29, 2, 'iPod touch'),
(30, 1, 'iPod touch'),(30, 2, 'iPod touch'),
(36, 2, 'Shure SE210 Sound-Isolating Earphones for iPod and iPhone'),(36, 1, 'Shure SE210 Sound-Isolating Earphones for iPod and iPhone'),
(32, 1, 'iPod touch'),(32, 2, 'iPod touch'),
(41, 1, 'iPod Nano'),(41, 2, 'iPod Nano'),
(42, 1, 'iPod Nano'),(42, 2, 'iPod Nano'),
(44, 1, 'iPod Nano'),(44, 2, 'iPod Nano'),
(45, 1, 'iPod Nano'),(45, 2, 'iPod Nano');

INSERT INTO `PREFIX_tag` (`id_tag`, `id_lang`, `name`) VALUES (5, 1, 'apple'),(6, 2, 'ipod'),(7, 2, 'nano'),(8, 2, 'apple'),(18, 2, 'shuffle'),
(19, 2, 'macbook'),(20, 2, 'macbookair'),(21, 2, 'air'),(22, 1, 'superdrive'),(23, 1, 'Ipod touch'),(28, 1, 'ipod'),(29, 1, 'nano'),(33, 1, 'shuffle'),
(35, 2, 'superdrive');

INSERT INTO `PREFIX_product_tag` (`id_product`, `id_tag`) VALUES (1, 5),(1, 6),(1, 7),(1, 8),(1, 28),(1, 29),(1, 30),(1, 31),(1, 32),(2, 6),(2, 18),(2, 28),
(2, 30),(2, 33),(2, 34),(5, 8),(5, 19),(5, 20),(5, 21),(6, 5),(6, 8),(6, 22),(6, 32),(6, 35),(6, 36),(7, 23),(7, 24),(7, 37),(9, 25),(9, 26),(9, 27);

INSERT INTO `PREFIX_alias` (`alias`, `search`, `active`, `id_alias`) VALUES ('piod', 'ipod', 1, 4),('ipdo', 'ipod', 1, 3);
INSERT INTO `PREFIX_order_message` (`id_order_message`, `date_add`) VALUES (1, NOW());
INSERT INTO `PREFIX_order_message_lang` (`id_order_message`, `id_lang`, `name`, `message`) VALUES
(1, 1, 'Delay', 'Hi,

Unfortunately, an item on your order is currently out of stock. This may cause a slight delay in delivery.
Please accept our apologies and rest assured that we are working hard to rectify this.

Best regards,');

INSERT INTO `PREFIX_order_message_lang` (`id_order_message`, `id_lang`, `name`, `message`) VALUES
(1, 2, 'Задержка', 'Здравствуйте,

к сожалению, товар для вашего заказа закончился. 
Пожалуйста, примите извинения, мы прилагаем все усилия, чтобы исправить это.

Хорошего вам дня');

/* Block CMS module*/

INSERT INTO `PREFIX_cms_block` (`id_cms_block`, `id_cms_category`, `name`, `location`, `position`) VALUES(1, 1, '', 0, 0);
INSERT INTO `PREFIX_cms_block_page` (`id_cms_block_page`, `id_cms_block`, `id_cms`, `is_category`) VALUES(1, 1, 1, 0), (2, 1, 2, 0), (3, 1, 3, 0), (4, 1, 4, 0), (5, 1, 5, 0);
INSERT INTO `PREFIX_cms_block_lang` (`id_cms_block`, `id_lang`, `name`) VALUES (1, 1, 'Information'),(1, 2, 'Информация');

/* Currency/Country module */
INSERT INTO `PREFIX_module_currency` (`id_module`, `id_currency`) VALUES (3, 1),(3, 2),(3, 3),(4, 1),(4, 2),(4, 3),(6, 1),(6, 2),(6, 3);
INSERT INTO `PREFIX_module_group` (`id_module`, `id_group`) VALUES (3, 1),(4, 1),(6, 1);

INSERT INTO `PREFIX_module_country` (`id_module`, `id_country`) VALUES (3, 1),(3, 2),(3, 3),(3, 4),(3, 5),(3, 6),(3, 7),(3, 8),
(3, 9),(3, 10),(3, 11),(3, 12),(3, 13),(3, 14),(3, 15),(3, 16),(3, 17),(3, 18),(3, 19),(3, 20),(3, 21),(3, 22),(3, 23),(3, 24),
(3, 25),(3, 26),(3, 27),(3, 28),(3, 29),(3, 30),(3, 31),(3, 32),(3, 33),(3, 34),(4, 1),(4, 2),(4, 3),(4, 4),(4, 5),(4, 6),(4, 7),
(4, 8),(4, 9),(4, 10),(4, 11),(4, 12),(4, 13),(4, 14),(4, 15),(4, 16),(4, 17),(4, 18),(4, 19),(4, 20),(4, 21),(4, 22),(4, 23),
(4, 24),(4, 25),(4, 26),(4, 27),(4, 28),(4, 29),(4, 30),(4, 31),(4, 32),(4, 33),(4, 34),(6, 1),(6, 2),(6, 3),(6, 4),(6, 5),(6, 6),
(6, 7),(6, 8),(6, 9),(6, 10),(6, 11),(6, 12),(6, 13),(6, 14),(6, 15),(6, 16),(6, 17),(6, 18),(6, 19),(6, 20),(6, 21),(6, 22),(6, 23),
(6, 24),(6, 25),(6, 26),(6, 27),(6, 28),(6, 29),(6, 30),(6, 31),(6, 32),(6, 33),(6, 34);

INSERT INTO `PREFIX_access` (`id_profile`, `id_tab`, `view`, `add`, `edit`, `delete`) VALUES
(2, 1, 1, 1, 1, 1),
(2, 2, 1, 1, 1, 1),
(2, 3, 1, 1, 1, 1),
(2, 4, 0, 0, 0, 0),
(2, 5, 1, 1, 1, 1),
(2, 6, 0, 0, 0, 0),
(2, 7, 0, 0, 0, 0),
(2, 8, 0, 0, 0, 0),
(2, 9, 0, 0, 0, 0),
(2, 10, 0, 0, 0, 0),
(2, 11, 0, 0, 0, 0),
(2, 12, 1, 1, 1, 1),
(2, 13, 1, 1, 1, 1),
(2, 14, 0, 0, 0, 0),
(2, 15, 0, 0, 0, 0),
(2, 16, 0, 0, 0, 0),
(2, 17, 1, 1, 1, 1),
(2, 18, 0, 0, 0, 0),
(2, 19, 0, 0, 0, 0),
(2, 20, 1, 1, 1, 1),
(2, 21, 1, 1, 1, 1),
(2, 22, 0, 0, 0, 0),
(2, 23, 0, 0, 0, 0),
(2, 24, 0, 0, 0, 0),
(2, 26, 0, 0, 0, 0),
(2, 27, 0, 0, 0, 0),
(2, 28, 0, 0, 0, 0),
(2, 29, 0, 0, 0, 0),
(2, 30, 0, 0, 0, 0),
(2, 31, 0, 0, 0, 0),
(2, 32, 0, 0, 0, 0),
(2, 33, 0, 0, 0, 0),
(2, 34, 1, 1, 1, 1),
(2, 35, 0, 0, 0, 0),
(2, 36, 0, 0, 0, 0),
(2, 37, 0, 0, 0, 0),
(2, 38, 0, 0, 0, 0),
(2, 39, 0, 0, 0, 0),
(2, 40, 0, 0, 0, 0),
(2, 41, 0, 0, 0, 0),
(2, 42, 1, 1, 1, 1),
(2, 43, 0, 0, 0, 0),
(2, 44, 0, 0, 0, 0),
(2, 46, 0, 0, 0, 0),
(2, 47, 1, 1, 1, 1),
(2, 48, 0, 0, 0, 0),
(2, 49, 1, 1, 1, 1),
(2, 51, 0, 0, 0, 0),
(2, 52, 0, 0, 0, 0),
(2, 53, 0, 0, 0, 0),
(2, 54, 0, 0, 0, 0),
(2, 55, 1, 1, 1, 1),
(2, 56, 0, 0, 0, 0),
(2, 57, 0, 0, 0, 0),
(2, 58, 0, 0, 0, 0),
(2, 59, 1, 1, 1, 1),
(2, 60, 1, 1, 1, 1),
(2, 61, 0, 0, 0, 0),
(2, 62, 0, 0, 0, 0),
(2, 63, 0, 0, 0, 0),
(2, 64, 0, 0, 0, 0),
(2, 65, 0, 0, 0, 0),
(2, 66, 0, 0, 0, 0),
(2, 67, 0, 0, 0, 0),
(2, 68, 0, 0, 0, 0),
(2, 69, 0, 0, 0, 0),
(2, 70, 0, 0, 0, 0),
(2, 71, 0, 0, 0, 0),
(2, 72, 0, 0, 0, 0),
(2, 73, 1, 1, 1, 1),
(2, 80, 0, 0, 0, 0),
(2, 81, 0, 0, 0, 0),
(2, 82, 0, 0, 0, 0),
(2, 83, 0, 0, 0, 0),
(2, 84, 0, 0, 0, 0),
(2, 85, 0, 0, 0, 0),
(2, 86, 0, 0, 0, 0),
(2, 87, 0, 0, 0, 0),
(2, 88, 1, 1, 1, 1),
(3, 1, 1, 1, 1, 1),
(3, 2, 0, 0, 0, 0),
(3, 3, 0, 0, 0, 0),
(3, 4, 0, 0, 0, 0),
(3, 5, 0, 0, 0, 0),
(3, 6, 0, 0, 0, 0),
(3, 7, 0, 0, 0, 0),
(3, 8, 0, 0, 0, 0),
(3, 9, 1, 0, 0, 0),
(3, 10, 0, 0, 0, 0),
(3, 11, 0, 0, 0, 0),
(3, 12, 0, 0, 0, 0),
(3, 13, 0, 0, 0, 0),
(3, 14, 0, 0, 0, 0),
(3, 15, 0, 0, 0, 0),
(3, 16, 0, 0, 0, 0),
(3, 17, 0, 0, 0, 0),
(3, 18, 0, 0, 0, 0),
(3, 19, 0, 0, 0, 0),
(3, 20, 0, 0, 0, 0),
(3, 21, 0, 0, 0, 0),
(3, 22, 0, 0, 0, 0),
(3, 23, 0, 0, 0, 0),
(3, 24, 0, 0, 0, 0),
(3, 26, 0, 0, 0, 0),
(3, 27, 0, 0, 0, 0),
(3, 28, 0, 0, 0, 0),
(3, 29, 0, 0, 0, 0),
(3, 30, 0, 0, 0, 0),
(3, 31, 0, 0, 0, 0),
(3, 32, 1, 1, 1, 1),
(3, 33, 1, 1, 1, 1),
(3, 34, 0, 0, 0, 0),
(3, 35, 0, 0, 0, 0),
(3, 36, 0, 0, 0, 0),
(3, 37, 0, 0, 0, 0),
(3, 38, 0, 0, 0, 0),
(3, 39, 0, 0, 0, 0),
(3, 40, 0, 0, 0, 0),
(3, 41, 0, 0, 0, 0),
(3, 42, 0, 0, 0, 0),
(3, 43, 1, 0, 0, 0),
(3, 44, 0, 0, 0, 0),
(3, 46, 0, 0, 0, 0),
(3, 47, 0, 0, 0, 0),
(3, 48, 0, 0, 0, 0),
(3, 49, 0, 0, 0, 0),
(3, 51, 0, 0, 0, 0),
(3, 52, 0, 0, 0, 0),
(3, 53, 0, 0, 0, 0),
(3, 54, 0, 0, 0, 0),
(3, 55, 0, 0, 0, 0),
(3, 56, 0, 0, 0, 0),
(3, 57, 1, 1, 1, 1),
(3, 58, 0, 0, 0, 0),
(3, 59, 0, 0, 0, 0),
(3, 60, 0, 0, 0, 0),
(3, 61, 0, 0, 0, 0),
(3, 62, 0, 0, 0, 0),
(3, 63, 0, 0, 0, 0),
(3, 64, 0, 0, 0, 0),
(3, 65, 0, 0, 0, 0),
(3, 66, 0, 0, 0, 0),
(3, 67, 0, 0, 0, 0),
(3, 68, 0, 0, 0, 0),
(3, 69, 0, 0, 0, 0),
(3, 70, 0, 0, 0, 0),
(3, 71, 0, 0, 0, 0),
(3, 72, 0, 0, 0, 0),
(3, 73, 0, 0, 0, 0),
(3, 80, 0, 0, 0, 0),
(3, 81, 0, 0, 0, 0),
(3, 82, 0, 0, 0, 0),
(3, 83, 0, 0, 0, 0),
(3, 84, 0, 0, 0, 0),
(3, 85, 0, 0, 0, 0),
(3, 86, 0, 0, 0, 0),
(3, 87, 0, 0, 0, 0),
(3, 88, 1, 1, 1, 1),
(4, 1, 1, 1, 1, 1),
(4, 2, 1, 1, 1, 1),
(4, 3, 1, 1, 1, 1),
(4, 4, 0, 0, 0, 0),
(4, 5, 0, 0, 0, 0),
(4, 6, 1, 1, 1, 1),
(4, 7, 0, 0, 0, 0),
(4, 8, 0, 0, 0, 0),
(4, 9, 0, 0, 0, 0),
(4, 10, 1, 0, 0, 0),
(4, 11, 0, 0, 0, 0),
(4, 12, 1, 1, 1, 1),
(4, 13, 0, 0, 0, 0),
(4, 14, 0, 0, 0, 0),
(4, 15, 0, 0, 0, 0),
(4, 16, 0, 0, 0, 0),
(4, 17, 0, 0, 0, 0),
(4, 18, 0, 0, 0, 0),
(4, 19, 0, 0, 0, 0),
(4, 20, 0, 0, 0, 0),
(4, 21, 0, 0, 0, 0),
(4, 22, 0, 0, 0, 0),
(4, 23, 0, 0, 0, 0),
(4, 24, 0, 0, 0, 0),
(4, 26, 0, 0, 0, 0),
(4, 27, 0, 0, 0, 0),
(4, 28, 0, 0, 0, 0),
(4, 29, 0, 0, 0, 0),
(4, 30, 0, 0, 0, 0),
(4, 31, 0, 0, 0, 0),
(4, 32, 0, 0, 0, 0),
(4, 33, 0, 0, 0, 0),
(4, 34, 0, 0, 0, 0),
(4, 35, 0, 0, 0, 0),
(4, 36, 0, 0, 0, 0),
(4, 37, 0, 0, 0, 0),
(4, 38, 0, 0, 0, 0),
(4, 39, 0, 0, 0, 0),
(4, 40, 0, 0, 0, 0),
(4, 41, 0, 0, 0, 0),
(4, 42, 1, 1, 1, 1),
(4, 43, 1, 0, 0, 0),
(4, 44, 0, 0, 0, 0),
(4, 46, 0, 0, 0, 0),
(4, 47, 0, 0, 0, 0),
(4, 48, 0, 0, 0, 0),
(4, 49, 1, 1, 1, 1),
(4, 51, 0, 0, 0, 0),
(4, 52, 0, 0, 0, 0),
(4, 53, 0, 0, 0, 0),
(4, 54, 1, 1, 1, 1),
(4, 55, 0, 0, 0, 0),
(4, 56, 0, 0, 0, 0),
(4, 57, 0, 0, 0, 0),
(4, 58, 0, 0, 0, 0),
(4, 59, 1, 1, 1, 1),
(4, 60, 0, 0, 0, 0),
(4, 61, 0, 0, 0, 0),
(4, 62, 1, 1, 1, 1),
(4, 63, 1, 1, 1, 1),
(4, 64, 0, 0, 0, 0),
(4, 65, 1, 1, 1, 1),
(4, 66, 0, 0, 0, 0),
(4, 67, 0, 0, 0, 0),
(4, 68, 0, 0, 0, 0),
(4, 69, 0, 0, 0, 0),
(4, 70, 0, 0, 0, 0),
(4, 71, 0, 0, 0, 0),
(4, 72, 0, 0, 0, 0),
(4, 73, 0, 0, 0, 0),
(4, 80, 0, 0, 0, 0),
(4, 81, 0, 0, 0, 0),
(4, 82, 1, 1, 1, 1),
(4, 83, 0, 0, 0, 0),
(4, 84, 0, 0, 0, 0),
(4, 85, 0, 0, 0, 0),
(4, 86, 0, 0, 0, 0),
(4, 87, 0, 0, 0, 0),
(4, 88, 1, 1, 1, 1);

INSERT INTO `PREFIX_profile` (`id_profile`) VALUES (2),(3),(4);
INSERT INTO `PREFIX_profile_lang` (`id_lang`, `id_profile`, `name`) VALUES
(1, 2, 'Logistician'),(2, 2, 'Логист'),
(1, 3, 'Translator'),(2, 3, 'Переводчик'),
(1, 4, 'Salesman'),(2, 4, 'Продавец');

INSERT INTO `PREFIX_stock_mvt` (`id_stock_mvt`, `id_product`, `id_product_attribute`, `id_order`, `id_stock_mvt_reason`, `id_employee`, `quantity`, `date_add`, `date_upd`) VALUES
(1, 6, 0, 0, 2, 1, 250, NOW(), NOW()),(2, 8, 0, 0, 2, 1, 1, NOW(), NOW()),(3, 9, 0, 0, 2, 1, 1, NOW(), NOW()),(4, 2, 7, 0, 2, 1, 10, NOW(), NOW()),(5, 2, 8, 0, 2, 1, 20, NOW(), NOW()),(6, 2, 9, 0, 2, 1, 30, NOW(), NOW()),(7, 2, 10, 0, 2, 1, 40, NOW(), NOW()),(8, 5, 12, 0, 2, 1, 100, NOW(), NOW()),(9, 5, 13, 0, 2, 1, 99, NOW(), NOW()),(10, 5, 14, 0, 2, 1, 50, NOW(), NOW()),(11, 5, 15, 0, 2, 1, 25, NOW(), NOW()),(12, 7, 19, 0, 2, 1, 50, NOW(), NOW()),(13, 7, 22, 0, 2, 1, 60, NOW(), NOW()),(14, 7, 23, 0, 2, 1, 70, NOW(), NOW()),(15, 1, 25, 0, 2, 1, 50, NOW(), NOW()),(16, 1, 26, 0, 2, 1, 50, NOW(), NOW()),(17, 1, 27, 0, 2, 1, 50, NOW(), NOW()),(18, 1, 28, 0, 2, 1, 50, NOW(), NOW()),(19, 1, 29, 0, 2, 1, 50, NOW(), NOW()),(20, 1, 30, 0, 2, 1, 50, NOW(), NOW()),(21, 1, 31, 0, 2, 1, 50, NOW(), NOW()),(22, 1, 32, 0, 2, 1, 50, NOW(), NOW()),(23, 1, 33, 0, 2, 1, 50, NOW(), NOW()),(24, 1, 34, 0, 2, 1, 50, NOW(), NOW()),(25, 1, 35, 0, 2, 1, 50, NOW(), NOW()),(26, 1, 36, 0, 2, 1, 50, NOW(), NOW()),(27, 1, 39, 0, 2, 1, 50, NOW(), NOW()),(28, 1, 40, 0, 2, 1, 50, NOW(), NOW()),(29, 1, 41, 0, 2, 1, 50, NOW(), NOW()),(30, 1, 42, 0, 2, 1, 50, NOW(), NOW());

INSERT INTO `PREFIX_store` (`id_store`, `id_country`, `id_state`, `name`, `address1`, `address2`, `city`, `postcode`, `latitude`, `longitude`, `hours`, `phone`, `fax`, `email`, `note`, `active`, `date_add`, `date_upd`) VALUES
(1, 21, 9, 'Dade County', '3030 SW 8th St Miami', '', 'Miami', ' 33135', 25.765005, -80.243797, 'a:7:{i:0;s:13:"09:00 - 19:00";i:1;s:13:"09:00 - 19:00";i:2;s:13:"09:00 - 19:00";i:3;s:13:"09:00 - 19:00";i:4;s:13:"09:00 - 19:00";i:5;s:13:"10:00 - 16:00";i:6;s:13:"10:00 - 16:00";}', '', '', '', '', 1, '2010-11-09 10:53:13', '2010-11-09 10:53:13'),
(2, 21, 9, 'E Fort Lauderdale', '1000 Northeast 4th Ave Fort Lauderdale', '', 'miami', ' 33304', 26.137936, -80.139435, 'a:7:{i:0;s:13:"09:00 - 19:00";i:1;s:13:"09:00 - 19:00";i:2;s:13:"09:00 - 19:00";i:3;s:13:"09:00 - 19:00";i:4;s:13:"09:00 - 19:00";i:5;s:13:"10:00 - 16:00";i:6;s:13:"10:00 - 16:00";}', '', '', '', '', 1, '2010-11-09 10:56:26', '2010-11-09 10:56:26'),
(3, 21, 9, 'Pembroke Pines', '11001 Pines Blvd Pembroke Pines', '', 'miami', '33026', 26.009987, -80.294472, 'a:7:{i:0;s:13:"09:00 - 19:00";i:1;s:13:"09:00 - 19:00";i:2;s:13:"09:00 - 19:00";i:3;s:13:"09:00 - 19:00";i:4;s:13:"09:00 - 19:00";i:5;s:13:"10:00 - 16:00";i:6;s:13:"10:00 - 16:00";}', '', '', '', '', 1, '2010-11-09 10:58:42', '2010-11-09 11:01:11'),
(4, 21, 9, 'Coconut Grove', '2999 SW 32nd Avenue', '', ' Miami', ' 33133', 25.736296, -80.244797, 'a:7:{i:0;s:13:"09:00 - 19:00";i:1;s:13:"09:00 - 19:00";i:2;s:13:"09:00 - 19:00";i:3;s:13:"09:00 - 19:00";i:4;s:13:"09:00 - 19:00";i:5;s:13:"10:00 - 16:00";i:6;s:13:"10:00 - 16:00";}', '', '', '', '', 1, '2010-11-09 11:00:38', '2010-11-09 11:04:52'),
(5, 21, 9, 'N Miami/Biscayne', '12055 Biscayne Blvd', '', 'Miami', '33181', 25.886740, -80.163292, 'a:7:{i:0;s:13:"09:00 - 19:00";i:1;s:13:"09:00 - 19:00";i:2;s:13:"09:00 - 19:00";i:3;s:13:"09:00 - 19:00";i:4;s:13:"09:00 - 19:00";i:5;s:13:"10:00 - 16:00";i:6;s:13:"10:00 - 16:00";}', '', '', '', '', 1, '2010-11-09 11:11:28', '2010-11-09 11:11:28');

