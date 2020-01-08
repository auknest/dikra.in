<?php

    /**
     * Copyright © 2016 Inspius. All rights reserved.
     * Author: Khanh Tran
     * Author URI: http://inspius.com
     */
    require_once('api.php');

    class ControllerIcymobiFrontCategories extends ControllerIcymobiFrontApi
    {

        protected $id_lang;

        protected function _getResponse()
        {
            $mode = $this->config->get('icymobi_category_page_display_value');
            switch ($mode) {
                case 'product' :
                    return $this->_getListCatByProductMode();
                case 'subcategories' :
                    return $this->_getListCatBySubCatMode();
            }
        }

        private function _getListCatByProductMode()
        {
            $categories = $this->_getArrayCategories();

            if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
                $base = $this->config->get('config_ssl');
            } else {
                $base = $this->config->get('config_url');
            }
            
            $return = array();
            
            foreach ($categories as $key => $category) {
                $productsBelongThisCategory = $this->_getProductByCatId($category['category_id']);
                $count = count( $productsBelongThisCategory );
                $return[$key]['id'] = (int) $category['category_id'];
                $return[$key]['name'] = $category['name'];
                $return[$key]['slug'] = '';
                $return[$key]['parent'] = (int) $category['parent_id'];
                $return[$key]['description'] = htmlspecialchars($category['description']);
                $return[$key]['display'] = '';
                $return[$key]['image']['src'] = $base.'image/'.$category['image'];
                $return[$key]['menu_order'] = '';
                $return[$key]['count'] = $count ? : 0;
                $return[$key]['products'] = $count ? $productsBelongThisCategory : array();
                $return[$key]['_links']['self']['href'] = '';
                $return[$key]['_links']['collection']['href'] = '';
                $return[$key]['_links']['up']['href'] = '';
            }

            return $return;
        }

        private function _getListCatBySubCatMode()
        {
            $categories = $this->_getArrayCategories();
            
            if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
                $base = $this->config->get('config_ssl');
            } else {
                $base = $this->config->get('config_url');
            }
            
            foreach($categories as &$category) {
                $category['id'] = (int)$category['category_id'];
                $category['parent'] = (int)$category['parent_id'];
                $category['image'] = array(
                    'src' => $base.'image/'.$category['image']
                );
                unset($category['parent_id']);
                unset($category['category_id']);
            }
            $data = array();
            
            foreach ($categories as $cat) {
                if ($cat['parent'] == 0) {
                    $cat['children'] = $this->get_child_category($cat['id'], $categories);
                    array_push($data, $cat);
                }
            }
            return $data;
        }
        
        /**
         * Recursive function get array include all recursive subcategory 
         * 
         * @param int $parent
         * @param array $categories
         * @return array
         */
        private function get_child_category($parent, $categories)
        {
            $child = array();
            foreach ($categories as $category) {
                if($category['parent']) {
                }
                if ($category['parent'] == (int)$parent) {
                    $category['children'] = $this->get_child_category($category['id'], $categories);
                    if (empty($category['children'])) {
                        $product = $this->_getProductByCatId($category['id']);
                        if (!empty($product)) {
                            $category['products'] = $product;
                        }
                    }
                    array_push($child, $category);
                }
            }
            return $child;
        }
        
        /**
        * Query all id_product which has catagory equal id_catefory
        *
        * @param int $categoryId
        * @return array 
        */
        private function _getProductByCatId($categoryId)
        {
            return array();
        }
        
        /**
         * Query all id_category with id_parent 
         * 
         * @return array
         */
        private function _getArrayCategories()
        {
            $this->load->model('icymobi/setting');
            $arrayCate = $this->model_icymobi_setting->getAllCategories();
            
            return $arrayCate;
        }
    }
    