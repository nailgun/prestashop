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

/**
 * An object of this type is a representauion of a block inserted
 *  by this module
 * @see ObjectModelCore
 * @see MultiBlockAtoh
 */
final class MultiBlockAtohBlock extends ObjectModel {

    /** @var integer DB primary key for this block, set when it is persisted */
    public $id = NULL;

    /** @var integer DB primary key for this block, used for inserts to
     * language table. Set when it is persisted */
    public $id_mbatoh_block = NULL;

    /** @var enum The hook this block hooks */
    public $mbatoh_block_hook = NULL;

    /** @var array Multilingual array of block content */
    public $mbatoh_block_body = array();

    /** @var string The date this block is persisted */
    public $date_add = NULL;

    /** @var array Non-null fields in DB */
    protected $fieldsRequired = array('mbatoh_block_hook');

    /** @var array Field sizes in DB */
    protected $fieldsSize = array(
        'mbatoh_block_hook' => 32,
        'date_add' => 20
    );

    /** @var array Fields to validate */
    protected $fieldsValidate = array(
        'mbatoh_block_hook' => 'isHookName',
        'date_add' => 'isDate'
    );

    /** @var array Multilingual non-null fields in DB */
    protected $fieldsRequiredLang = array('mbatoh_block_body');

    /** @var array Multilingual Field sizes in DB */
    protected $fieldsSizeLang = array(
        'id_mbatoh_block' => 10,
        'mbatoh_block_body' => 65535
    );

    /** @var array multilingual fields to validate */
    protected $fieldsValidateLang = array(
        'id_mbatoh_block' => 'isUnsignedId',
        'mbatoh_block_body' => 'isString'
    );

    /** @var string The name of the DB table for thos object */
    protected $table = 'mbatoh_block';

    /** @var integer The instance identifier used for language table inserts */
    protected $identifier = 'id_mbatoh_block';

    /**
     * Constructor
     * @param enum $hook The name of the hook this block hooks
     * @param string $block_bodies The contents of the block
     * @see ObjectModelCore
     */
    public function __construct($hook, $block_bodies) {

        $this->mbatoh_block_hook = $hook;

        foreach ($block_bodies as $lang => $content) {
            $this->mbatoh_block_body[$lang] = $content;
        }

        parent::__construct();
    }

    /**
     *
     * Validates and returns DB fields for this object, used in DB insertion
     * into the object's main table
     * @return array DB fields if the fields validate, false otherwise
     * @see ObjectModelCore::getFields()
     */
    public function getFields() {

        $die = false; // Take evasive action against PSCFI-3228
        if (!$this->validateFields($die)) {
            return false;
        }

        $fields = array();
        $fields['mbatoh_block_hook'] = pSQL($this->mbatoh_block_hook);
        $fields['date_add'] = pSQL($this->date_add);

        return $fields;
    }

    /**
     * Validates and returns the multilingual DB fields for this object, used
     *  in DB insertion/update
     * @return array Multilingual fields for language table if the fields
     * validate, false otherwise
     * @see ObjectModelCore::add()
     */
    public function getTranslationsFieldsChild() {

        $die = false; // Take evasive action against PSCFI-3228
        if (!$this->validateFieldsLang($die)) {
            return false;
        }

        $languages = Language::getLanguages(false);
        if (!is_array($languages) || empty($languages)) {
            return false;
        }

        $fields = array();
        foreach ($languages as $language) {
            $lang = $language['id_lang'];
            $fields[$lang]['id_lang'] = (int) $language['id_lang'];
            $fields[$lang]['id_mbatoh_block'] = (int) $this->id_mbatoh_block;
            // required and html field
            if (isset($this->mbatoh_block_body[$lang]) &&
                    !empty($this->mbatoh_block_body[$lang])) {
                $fields[$lang]['mbatoh_block_body'] = pSQL($this->mbatoh_block_body[$lang], true);
            } else {
                $fields[$lang]['mbatoh_block_body'] = pSQL($this->mbatoh_block_body[(int) Configuration::get('PS_LANG_DEFAULT')], true);
            }
        }

        return $fields;
    }

    /**
     * Override parent method to eleminate the call to update
     * @param boolean $nullValues Not used
     * @param type $autodate Not used
     * @return return true if the object is saved to main and lang table,
     * false otherwise.
     */
    public function save($nullValues = false, $autodate = true) {

        return $this->add();
    }

    /**
     * We never update an instance of this object, so override parent to
     * disable this method.
     * @param boolean $nullValues Not used
     * @return boolean false
     */
    public function update($nullValues = false) {

        return false;
    }

    /**
     * Override parent method to work around the mess it is
     * @param boolean $autodate Not used
     * @param boolean $nullValues Not used
     * @return boolean true if the object is saved to main and lang table,
     * false otherwise.
     */
    public function add($autodate = true, $nullValues = false) {

        return $this->_add();
    }

    // don't call directly, called from add
    private function _add() {

        $this->date_add = date('Y-m-d H:i:s');

        $fields = $this->getFields();
        if (!$fields) {
            return false;
        }

        $result = Db::getInstance()->autoExecute(_DB_PREFIX_ . $this->table, $fields, 'INSERT');

        if ($result) {
            $this->id = (int) Db::getInstance()->Insert_ID();
            $this->id_mbatoh_block = $this->id;
            return $this->_addLang();
        }

        return false;
    }

    // don't call directly, called from _add upon success
    private function _addLang() {

        $translationFields = $this->getTranslationsFieldsChild();
        if (!$translationFields || empty($translationFields)) {
            $this->_rollback();
            return false;
        }

        $result = true;
        foreach ($translationFields AS $translationField) {
            $result &= Db::getInstance()->AutoExecute(_DB_PREFIX_ . $this->table . '_lang', $translationField, 'INSERT');
        }

        if (!$result) {
            $this->_rollback();
        }

        return $result;
    }

    // see http://forge.prestashop.com/browse/PSCFI-3226
    // don't call directly, called from _addLang
    private function _rollback() {

        $this->delete();
        $this->id = NULL;
        $this->id_mbatoh_block = NULL;
        $this->date_add = NULL;
    }

}

?>
