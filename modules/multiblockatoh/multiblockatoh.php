<?php

/*
  Copyright (C) 2011 by phrasespot

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 */
if (!defined('_PS_VERSION_')) {
    exit;
}

require_once _PS_MODULE_DIR_ . '/multiblockatoh/MultiBlockAtohBlock.php';

/**
 * A module to insert blocks at various locations
 * @see ModuleCode
 * @see MultiBlockAtohBlock
 */
final class MultiBlockAtoh extends Module {

    /**
     * Constructor
     * @see ModuleCore::__construct()
     */
    public function __construct() {

        $this->name = 'multiblockatoh';

        parent::__construct();

        $this->tab = 'front_office_features';
        $this->version = '1.1.9';
        $this->author = 'phrasespot';
        $this->displayName = $this->l('Multi Block Arbitrary Text Or HTML');
        $this->description = $this->l('Add one or more blocks with arbitrary text or HTML content');
        $this->confirmUninstall = $this->l('Uninstall Multi Block Arbitrary Text or HTML?');
        $this->need_instance = 0;
    }

    /**
     * Install module
     * @return boolean true if module installs successfully, false otherwise
     * @see ModuleCore::install()
     */
    public function install() {

        if (!self::isPsCompatible()) {
            Logger::addLog($this->l('Module is not compatible with this version of Prestashop'), 3, NULL, 'MultiBlockAtoh', 1);
            return false;
        }

        // Add module tables
        if (!$this->_executeSql(_PS_MODULE_DIR_ . 'multiblockatoh/sql/install.sql')) {
            return false;
        }

        return parent::install();
    }

    /**
     * Uninstall module
     * @return boolean true if module uninstall successfully, false otherwise
     * @see ModuleCore::uninstall()
     */
    public function uninstall() {

        if (!$this->_executeSql(_PS_MODULE_DIR_ . 'multiblockatoh/sql/uninstall.sql')) {
            Logger::addLog($this->l('Failed to remove module tables during uninstall.'), 1, NULL, 'MultiBlockAtoh', 1);
        }

        return parent::uninstall();
    }

    /**
     * Unregister hook with id $hook_id. First remove the hook from module's
     * tables, then hand over to prestashop.
     *
     * This method overrides parent method to enable correct functioning of the
     * delete and unhook operations performed from the "Positions" tab;
     * <b>Back Office > Modules > Positions</b>
     * @param integer $hook_id The id of the hook to unregister
     * @return boolean true if the hook was unregistered succesfully,
     *  false otherwise
     * @see ModuleCore::unregisterHook
     */
    public function unregisterHook($hook_id) {

        // order of queries matters!
        // clear from mbatoh_block_lang table
        $query = 'DELETE' .
                ' FROM `' . _DB_PREFIX_ . 'mbatoh_block_lang`' .
                ' WHERE `id_mbatoh_block` = (SELECT `id_mbatoh_block`' .
                ' FROM `' . _DB_PREFIX_ . 'mbatoh_block`' .
                ' WHERE `mbatoh_block_hook` = (SELECT `name` FROM `'
                . _DB_PREFIX_ . 'hook` WHERE `id_hook` = ' . (int) $hook_id . '))';


        Db::getInstance(_PS_USE_SQL_SLAVE_)->Execute($query);

        // clear from mbatoh_block table
        $query = 'DELETE' .
                ' FROM `' . _DB_PREFIX_ . 'mbatoh_block`' .
                ' WHERE `mbatoh_block_hook` = (SELECT `name` FROM `'
                . _DB_PREFIX_ . 'hook` WHERE `id_hook` = ' . (int) $hook_id . ')';

        Db::getInstance(_PS_USE_SQL_SLAVE_)->Execute($query);

        // hand over to parent
        return parent::unregisterHook($hook_id);
    }

    /**
     * Is hook $hookName hookable by this module?
     * @param string $hookName Correct case (as in DB table) hook name
     * @return boolean true if this hook can be hooked, false otherwise or
     * if the callee is AdminModulesPositions (Transplant) or
     * ourselves (LiveEdit DnD)
     * @see ModuleCore::isHookableOn
     */
    public function isHookableOn($hookName) {

        // Ugly hack for stopping transplant and LiveEdit DnD from being used,
        // nothing we can do for LiveEdit delete :( c'est la vie
        $backtrace = debug_backtrace();
        if ((isset($backtrace[1]['class']) &&
                $backtrace[1]['class'] == 'AdminModulesPositions') ||
                (isset($backtrace[1]['class']) &&
                $backtrace[0]['class'] == 'MultiBlockAtoh')) {

            return false;
        }

        return in_array($hookName, self::$_HOOKABLES);
    }

    /**
     * Magic method. Used to call relevant hook method (and only a hook method).
     * @param string $name All lowercase name of the hook method to call
     * @param mixed $arguments Not used
     * @return string Content for this hook <b>iff</b> this is a hook
     *  callable by this module
     */
    public function __call($name, $arguments) {

        $split = preg_split('/hook/', $name, NULL, PREG_SPLIT_NO_EMPTY);
        $hook = $split[0];
        if (in_array($hook, array_map('strtolower', self::$_HOOKABLES))) {
            return $this->_hookOracle($hook);
        }
    }

    /**
     * Process and display back office form
     * @global Smarty $smarty Smarty object
     * @global Cookie $cookie Cookie object
     * @return string Back office HTML
     */
    public function getContent() {

        global $smarty, $cookie;

        if (Tools::isSubmit('save-block')) {

            $block_hook = Tools::getValue('block_hook');
            $block_bodies = array();
            $hasBody = false; // assume a blank form was submitted

            foreach ($_POST as $key => $value) {
                if ((bool) preg_match('/\d+$/', $key)) {// multi lang field
                    $body = Tools::getValue($key);
                    if (!empty($body)) {
                        $keyParts = preg_split('/_([\d]+)/', $key, NULL, PREG_SPLIT_NO_EMPTY | PREG_SPLIT_DELIM_CAPTURE);
                        $block_bodies[$keyParts[1]] = $body;
                        if (!$hasBody) {
                            $hasBody = true;
                        }
                    }
                }
            }

            if ($hasBody) {
                $block = new MultiBlockAtohBlock($block_hook, $block_bodies);

                if ($block->save()) {
                    if ($this->registerHook($block_hook)) {
                        $smarty->assign('submitResult', $this->displayConfirmation($this->l('New block added successfully')));
                    }
                } else {
                    $smarty->assign('submitResult', $this->displayError($this->l('There was an error and could not save block.')));
                }
            }
        }

        // this assignment must come after any hooking that may be done above
        // processing of a possible submit
        $alreadyHooked = $this->_getHooked();
        $remainingHooks = array();
        foreach (self::$_HOOKABLES as $hookName) {
            if (!in_array($hookName, $alreadyHooked)) {
                $remainingHooks[$hookName] = $this->_getHookTitle($hookName);
            }
        }
        $allLanguages = Language::getLanguages(false);
        $defaultLanguage = (int) Configuration::get('PS_LANG_DEFAULT');
        $flags = $this->displayFlags($allLanguages, $defaultLanguage, 'block_body_wrapper', 'block_body_wrapper', true);

        $smarty->assign('assignedVars', array(
            'hook' => array(
                'remaining' => $remainingHooks
            ),
            'lang' => array(
                'all' => $allLanguages,
                'default' => $defaultLanguage,
                'flags' => $flags
            ),
            'icons' => array(
                'module' => $this->_path . 'logo.gif',
                'license' => $this->_path . 'img/license.gif',
                'credits' => $this->_path . 'img/credits.gif',
                'usage' => $this->_path . 'img/usage.gif',
                'examples' => $this->_path . 'img/examples.gif',
                'bugs' => $this->_path . 'img/bugs.gif',
                'donate' => $this->_path . 'img/pp.gif'
            ),
            'links' => array(
                'license' => $this->_getLicense(),
                'positionsTab' => 'index.php?tab=AdminModulesPositions&token=' . Tools::getAdminToken('AdminModulesPositions' .
                        (int) Tab::getIdFromClassName('AdminModulesPositions') .
                        (int) $cookie->id_employee) . '&show_modules=' . $this->id,
                'self' => Tools::safeOutput($_SERVER['REQUEST_URI']),
                'examples' => array(
                    '1' => $this->_path . 'img/example1.jpg',
                    '2' => $this->_path . 'img/example2.jpg',
                    '3' => $this->_path . 'img/example3.jpg'
                ),
                'update' => 'https://sites.google.com/site/phrasespot/home/modules/insert-anywhere'
            ),
            'version' => $this->version,
            'includes' => array(
                'donateTpl' => _PS_MODULE_DIR_ . $this->name . '/tpl/donate.tpl',
                'contactTpl' => _PS_MODULE_DIR_ . $this->name . '/tpl/contact.tpl'
            )
        ));

        return self::display(__FILE__, 'tpl/back_office.tpl');
    }

    // <editor-fold defaultstate="collapsed" desc="private">
    private function _hookOracle($hook) {

        global $smarty, $cookie;

        $id_lang = $cookie->id_lang ? (int) $cookie->id_lang : (int) Configuration::get('PS_LANG_DEFAULT');
        $smarty->assign('block', $this->_getBlockFor($hook, $id_lang));

        return self::display(__FILE__, 'tpl/block.tpl');
    }

    private function _getHookTitle($hookName) {

        $query = 'SELECT h.`title`
		FROM `' . _DB_PREFIX_ . 'hook` h
		WHERE `name` = \'' . pSQL($hookName) . '\'';

        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->getRow($query);

        return $result ? $result['title'] : '';
    }

    private function _getHooked() {

        $hooked = array();
        $query = 'SELECT `mbatoh_block_hook`
            FROM `' . _DB_PREFIX_ . 'mbatoh_block`';

        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->ExecuteS($query);

        if ($result)
            foreach ($result as $row) {
                $hooked[] = $row['mbatoh_block_hook'];
            }

        return $hooked;
    }

    private function _getBlockFor($hook, $id_lang) {

        $query = 'SELECT ml.`mbatoh_block_body`
		FROM `' . _DB_PREFIX_ . 'mbatoh_block` m
		LEFT JOIN `' . _DB_PREFIX_ . 'mbatoh_block_lang` ml ON (m.`id_mbatoh_block` = ml.`id_mbatoh_block`)
		WHERE m.`mbatoh_block_hook` =\'' . pSQL($hook) . '\' AND ml.`id_lang` = ' . (int) $id_lang;

        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->getRow($query);

        return $result ? $result['mbatoh_block_body'] : '';
    }

    private function _executeSql($sqlFile) {

        /** exists and readable */
        if (!is_readable($sqlFile)) {
            Logger::addLog($this->l('SQL file does not exist or is not readable'), 3, NULL, 'MultiBlockAtoh', 1);
            return false;
        }

        if (!$haystack = file_get_contents($sqlFile)) {
            Logger::addLog($this->l('Cannot get file contents'), 3, NULL, 'MultiBlockAtoh', 1);
            return false;
        }

        $psized = $this->_psizeSql($haystack);

        $queries = preg_split("/;\s*[\r\n]+/", $psized, NULL, PREG_SPLIT_NO_EMPTY);

        if (is_array($queries)) {
            foreach ($queries as $sql) {
                if (!Db::getInstance(_PS_USE_SQL_SLAVE_)->Execute(trim($sql))) {
                    Logger::addLog($this->l('Could not execute SQL statement ' . $sql), 3, NULL, 'MultiBlockAtoh', 1);
                    return false;
                }
            }
        }

        return true;
    }

    private function _psizeSql($haystack) {

        $search = array('PREFIX_', 'ENGINE_TYPE');
        $replace = array(_DB_PREFIX_, _MYSQL_ENGINE_);

        return str_replace($search, $replace, $haystack);
    }

    private function _getLicense() {

        global $cookie;

        $iso = strtolower(Language::getIsoById((int) $cookie->id_lang));
        $licensePath = _PS_MODULE_DIR_ . $this->name . '/license/';
        $license = $licensePath . $iso . '.txt';

        if (Tools::file_exists_cache($license)) {
            return Tools::file_get_contents($license);
        }

        return Tools::file_get_contents($licensePath . 'en.txt');
    }

    private static function isPsCompatible() {

        $min = '1.4.0.4';
        $max = '1.5.0.0';

        if (version_compare(_PS_VERSION_, $min) >= 0 &&
                version_compare(_PS_VERSION_, $max) < 0) {
            return true;
        }

        return false;
    }

    private static $_HOOKABLES = array(// enum in DB
        'backOfficeFooter',
        'backOfficeHeader',
        'backOfficeHome',
        'backOfficeTop',
        'beforeCarrier',
        'productTabContent',
        'createAccountTop',
        'createAccountForm',
        'customerAccount',
        'extraLeft',
        'extraRight',
        'extraCarrier',
        'extraProductComparison',
        'footer',
        'header',
        'home',
        'invoice',
        'leftColumn',
        'myAccountBlock',
        'orderConfirmation',
        'orderDetailDisplayed',
        'paymentReturn',
        'productActions',
        'productfooter',
        'productOutOfStock',
        'rightColumn',
        'shoppingCartExtra',
        'shoppingCart',
        'top',
        'paymentTop'
    );

// </editor-fold>
}

?>
