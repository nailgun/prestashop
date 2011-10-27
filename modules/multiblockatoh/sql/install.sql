SET NAMES 'utf8';

START TRANSACTION;

DROP TABLE IF EXISTS `PREFIX_mbatoh_block`;
CREATE  TABLE IF NOT EXISTS `PREFIX_mbatoh_block` (
  `id_mbatoh_block` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `mbatoh_block_hook` ENUM('backOfficeFooter', 'backOfficeHeader', 'backOfficeHome',
        'backOfficeTop', 'beforeCarrier', 'productTabContent', 'createAccountTop', 'createAccountForm',
        'customerAccount', 'extraLeft', 'extraRight', 'extraCarrier', 'extraProductComparison',
        'footer', 'header', 'home', 'invoice', 'leftColumn', 'myAccountBlock', 'orderConfirmation',
        'orderDetailDisplayed', 'paymentReturn', 'productActions', 'productfooter',
        'productOutOfStock', 'rightColumn', 'shoppingCart', 'top', 'paymentTop', 'shoppingCartExtra') NOT NULL ,
  `date_add` DATETIME NULL ,
  PRIMARY KEY (`id_mbatoh_block`) ,
  UNIQUE INDEX `block_hook_UNIQUE` (`mbatoh_block_hook` ASC) )
ENGINE = ENGINE_TYPE  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `PREFIX_mbatoh_block_lang`;
CREATE  TABLE IF NOT EXISTS `PREFIX_mbatoh_block_lang` (
  `id_mbatoh_block` INT(10) UNSIGNED NOT NULL ,
  `id_lang` INT(10) UNSIGNED NOT NULL ,
  `mbatoh_block_body` TEXT NOT NULL ,
  PRIMARY KEY (`id_mbatoh_block`, `id_lang`) )
ENGINE = ENGINE_TYPE  DEFAULT CHARSET=utf8;

COMMIT;


