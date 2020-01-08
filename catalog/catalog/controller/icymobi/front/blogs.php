<?php

    /**
     * Copyright © 2016 Inspius. All rights reserved.
     * Author: Khanh Tran
     * Author URI: http://inspius.com
     */
    require_once('api.php');
    require_once('helpers/Data.php');

    class ControllerIcymobiFrontBlogs extends ControllerIcymobiFrontApi
    {

        const REQUEST_SINGLE = 'single';
        const REQUEST_SEARCH = 'search';
        const REQUEST_CATEGORY = 'category';
        const REQUEST_TAG = 'tag';
        const ADD_NEW_COMMENT = 'add';
        const REQUEST_GET_CATEGORY = 'get_category';

        public $id_lang_default;

        protected function _getResponse()
        {
            $blogs = $this->getBlog();
            return ($blogs);
        }
        
        public function getBlog()
        {
            return array();
        }
        
        public function formatTags()
        {
            return array();
        }
    }