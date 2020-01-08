<?php

    /**
     * Copyright © 2016 Inspius. All rights reserved.
     * Author: Khanh Tran
     * Author URI: http://inspius.com
     */
    require_once('api.php');

    class ControllerIcymobiFrontProducts extends ControllerIcymobiFrontApi
    {

        const REQUEST_SINGLE = 'single';
        const REQUEST_CATEGORY = 'category';
        const REQUEST_TYPE = 'type';
        const REQUEST_SEARCH = 'search';
        const REQUEST_TAG = 'tag';

        protected $id_lang_default;
        protected $_productGroup = array('featured', 'onsale', 'best_seller', 'most_view', 'new');
        protected $_linkObj;

        protected function _getResponse()
        {
            $param = isset($this->request->get['param'])?$this->request->get['param']:null;
            $param2 = isset($this->request->get['params2'])?$this->request->get['params2']:null;
            $type = isset($this->request->get['type'])?$this->request->get['type']:null;
            $orderBy = isset($this->request->get['orderby'])?$this->request->get['orderby']:'id';
            if (!in_array($orderBy, array('date', 'id', 'name'))) {
                $orderBy = 'id';
            } else {
                switch ($orderBy) {
                    case 'date' :
                        $orderBy = 'date_added';
                        break;
                    case 'id' :
                        $orderBy = 'product_id';
                        break;
                    case 'name' :
                        $orderBy = 'name';
                        break;
                }
            }
            $order = isset($this->request->get['order'])?$this->request->get['order']:'desc';
            if (!in_array($order, array('asc', 'desc'))) {
                $order = 'desc';
            }
            $page = isset($this->request->get['page'])?$this->request->get['page']:1;
            $perPage = isset($this->request->get['per_page'])?$this->request->get['per_page']:10;
            switch ($type) {
                case self::REQUEST_TYPE:
                    if ($param && in_array(strtolower($param), $this->_productGroup)) {
                        $fn = '_get' . ucfirst(str_replace('_', '', $param));
                        $data = $this->$fn($page, $perPage, $orderBy, $order, $param2);
                    }
                    break;
                case self::REQUEST_SINGLE:
                    if ($param && is_numeric($param)) {
                        $data = $this->_getSingleProduct($param);
                    }
                    break;
                case self::REQUEST_CATEGORY:
                    if ($param && is_numeric($param)) {
                        $data = $this->_getProductsByCateId($param, $page, $perPage, $order, $orderBy);
                    }
                    break;
                case self::REQUEST_SEARCH:
                    if ($param) {
                        if ($param2) {
                            $category = (int) $param2;
                        } else {
                            $category = null;
                        }
                        $data = $this->_searchProduct($param, $page, $perPage, $order, $orderBy, $category);
                    }
                    break;
                case self::REQUEST_TAG:
                    if ($param) {
                        $data = $this->_getProductWtTag($param, $page, $perPage, $orderBy, $order);
                    }
                    break;
                default:
                    $data = $this->_getAllProduct($page, $perPage, $orderBy, $order);
                    break;
            }

            return $data;
        }

        protected function _getSingleProduct($param)
        {
            return $this->_getOneProductForApi($param);
        }
        
        
        protected function _getProductsByCateId($param, $page, $perPage, $order, $orderBy)
        {
            $this->load->model('catalog/category');
            $this->load->model('catalog/product');
            $filterData = array(
				'filter_category_id' => $param,
				'filter_filter'      => '',
				'sort'               => $orderBy,
				'order'              => $order,
				'start'              => ($page - 1) * $perPage,
				'limit'              => $perPage
			);
            $arrayProduct = $this->model_catalog_product->getProducts($filterData);
//            return $arrayProduct;
            $result = array();
            foreach($arrayProduct as $product) {
                $result[] = $this->_getOneProductForApi($product['product_id']);
            }
            return $result;
        }
        
        /**
         * Get categories of product
         * 
         * @param int $productId
         * @return string 
         */
        public function getCategoriesIdsByProductId($productId) 
        {
            $this->load->model('catalog/product');
            $categoriesRaw = $this->model_catalog_product->getCategories($productId);
            $categories = array();
            foreach ($categoriesRaw as $cate) {
                $categories[] = $cate['category_id'];
            }
            return implode(',', $categories);
        }
        
        protected function getArrayCategoriesForProduct($productId)
        {
            $arrayCategories = array();
            $this->load->model('catalog/product');
            $this->load->model('catalog/category');
            $categoriesRaw = $this->model_catalog_product->getCategories($productId);
            foreach ($categoriesRaw as $cate) {
                $arrayCategories[] = array(
                    'id' => $cate['category_id'],
                    'slug' => ""
                );
            }
            return $arrayCategories;
        }
        
        /**
         *  Get product type ( 'simple' or 'variable' )
         * 
         * @param int $productId
         * @return string
         */
        public function getProductType($productId)
        {
            $this->load->model('catalog/product');
            $productOptions = $this->model_catalog_product->getProductOptions($productId);
            if(empty($productOptions)) {
                return 'simple';
            }
            foreach ($productOptions as $option) {
                if($option['required'] == 1) {
                    return 'variable';
                }
            }
            return 'simple';
        }
        
        private function get_rating_html($star, $count = null)
        {
            $width = intval($star) * 20;
            return '<div class="rate">
                        <span style="width: ' . $width . '%;"></span>
                    </div>
                    <span class="count">(' . $count . ')</span>';
        }
        
        /**
         * 
         * @param int $productId
         * @return array
         */
        public function getProductRelatedIds($productId) 
        {
            $relate_ids = array();
            $this->load->model('catalog/product');
            $relatedProducts = $this->model_catalog_product->getProductRelated($productId);
            if(!empty($relatedProducts)) {
                $relate_ids = array_keys($relatedProducts);
            }
            return $relate_ids;
        }
        
        
        /**
         *  Get Single Product Info by id_product
         * 
         * @param int $productId
         * @return array
         */
        private function _getOneProductForApi($productId)
        {
            if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
                $base = $this->config->get('config_ssl');
            } else {
                $base = $this->config->get('config_url');
            }
            $this->load->model('catalog/product');
            $product = $this->model_catalog_product->getProduct($productId);
            $productImages = $this->model_catalog_product->getProductImages($productId);
            $arrayImages = array(
                array(
                    "alt" => "",
                    "date_created" => "",
                    "date_modified" => "",
                    "id" => "",
                    "name" => "",
                    "src" => $base.'image/'.$product['image']
                )
            );
            foreach($productImages as $image) {
                $arrayImages[] = array(
                    "alt" => "",
                    "date_created" => "",
                    "date_modified" => "",
                    "id" => "",
                    "name" => "",
                    "src" => $base.'image/'.$image['image']
                );
            }
            $productReturn = array (
                "id"                  => (int) $product['product_id'],
                "name"                => $product['name'],
                "slug"                => "",
                "array_categories_id" => $this->getCategoriesIdsByProductId($productId),
                "permalink"           => '',
                "date_created"        => $product['date_added'],
                "date_modified"       => $product['date_modified'],
                "type"                => $this->getProductType($productId),
                "status"              => "",
                "featured"            => "",
                "catalog_visibility"  => "visiable",
                "description"         => html_entity_decode($product['description']),
                "short_description"   => "",
                "sku"                 => "",
                "price"               => $product['special']?:$product['price'],
                "regular_price"       => $product['price'],
                "sale_price"          => $product['special']?:$product['price'],
                "date_on_sale_from"   => $product['date_available'],
                "date_on_sale_to"     => "",
                "price_html"          => "",
                "on_sale"             => ($product['special'] && (float)$product['special'] < (float)$product['price'])?true:false,
                "purchasable"         => true,
                "total_sales"         => "",
                "virtual"             => "",
                "downloadable"        => "",
                "downloads"           => array(),
                "download_limit"      => "",
                "download_expiry"     => "",
                "download_type"       => "",
                "external_url"        => "",
                "button_text"         => "",
                "tax_status"          => "",
                "tax_class"           => "",
                "manage_stock"        => (bool) false,
                "stock_quantity"      => $product['quantity'],
                "in_stock"            => true,
                "backorders"          => 'no',
                "backorders_allowed"  => (bool) false,
                "backordered"         => (bool) false,
                "sold_individually"   => (bool) false,
                "weight"              => $product['weight'],
                "dimensions"          => array(
                    "length" => $product['length'],
                    "width"  => $product['width'],
                    "height" => $product['height']
                ),
                "shipping_required"   => true,
                "shipping_taxable"    => true,
                "shipping_class"      => "",
                "shipping_class_id"   => "",
                "reviews_allowed"     => true,
                "average_rating"      => $product['rating'],
                "rating_count"        => $product['reviews'],
                "rating_star_html"    => '',
                "rating_star_html"    => $this->get_rating_html($product['rating'], $product['reviews']),
                "related_ids"         => $this->getProductRelatedIds($productId),
                "upsell_ids"          => array(),
                "cross_sell_ids"      => array(),
                "parent_id"           => "",
                "purchase_note"       => "",
                "categories"          => $this->getArrayCategoriesForProduct($productId),
                "tags"                => $product['tag'],
                "images"              => $arrayImages,
                "attributes"          => $this->getAllOptionsOfProduct($productId),
                "default_attributes"  => $this->getAllDefaultOptions($productId),
                "variations"          => $this->getAllVariationsOfProduct($productId),
                "grouped_products"    => array(),
                "menu_order"          => 0,
                "_links"              => array(
                    "self"       => array(
                        array(
                            "href" => '',
                        )
                    ),
                    "collection" => array(
                        array(
                            "href" => ""
                        )
                    )
                )
            );
            return $productReturn;
        }
        
        /**
         * Recursive get combinations from attributes required
         * 
         * @param array $attrsForVariant general array include all attribute for variant
         * @param int $key key of $attrsForVariant of previous called
         * @param array $attr value of key of previous called
         * @param array $resultArrayVariant reference result
         * @param int $keyResult key of $resultArrayVariant of previous called
         */
        public function getRecursiveVariant(array $attrsForVariant, $key, $attr, &$resultArrayVariant, $keyResult)
        {
            foreach ($attrsForVariant as $key1 => $attr1) {
                if($key1 <= $key) {
                    continue;
                }
                foreach($attr['product_option_value'] as $key2 => $option2) {
                    foreach($attr1['product_option_value'] as $key3 => $option3) {
                        if($keyResult == 0) {
                            $resultArrayVariant[$key.$key2.$key1.$key3] = array($option2, $option3);
                            $this->getRecursiveVariant($attrsForVariant, $key1, $attr1, $resultArrayVariant, $key.$key2.$key1.$key3); 
                        } else {
                            if(isset($resultArrayVariant[$keyResult])) {
                                unset($resultArrayVariant[$keyResult]);
                                $resultArrayVariant[$keyResult.$key1.$key3] = array($option2, $option3);
                                $this->getRecursiveVariant($attrsForVariant, $key1, $attr1, $resultArrayVariant, $keyResult.$key1.$key3);
                            } else {
                                $resultArrayVariant[$key.$key2.$key1.$key3] = array($option2, $option3);
                                $this->getRecursiveVariant($attrsForVariant, $key1, $attr1, $resultArrayVariant, $key.$key2.$key1.$key3);   
                            }
                        }
                    }
                }
            }
            
        }
        
        /**
         * Get array of variant of product
         * 
         * @param int $productId
         * @return array
         */
        public function getAllVariationsOfProduct($productId)
        {
            $this->load->model('catalog/product');
            $options = $this->model_catalog_product->getProductOptions($productId);
            $variations = array();
            $product = $this->model_catalog_product->getProduct($productId);
            
            $attributesForVariation = array();
            foreach ($options as $option) {
                if($option['required'] == 1 && ($option['type'] == 'radio' || $option['type'] == 'select')) {
                    $attributesForVariation[] = $option;
                }
            }
            $countAllAttributes = count($attributesForVariation);
            
            $keyResult = '';
            for($i=0;$i<$countAllAttributes;$i++) {
                $keyResult .= '11';
            }
            $resultArray = array();
            $this->getRecursiveVariant($attributesForVariation, 0, @$attributesForVariation[0], $resultArray, (int)0, array(@$attributesForVariation[0]['product_option_value'][0]));
            
            foreach($resultArray as $key => $combination) {
            
                $variantPriceCurrent = $productPriceCurrent = $product['special']?:$product['price'];
                $variantPrice = $productPrice = $product['price'];
                $variantWeight = $productWeight = $product['weight'];
                
                
                $attributeForShow = array();
                foreach($combination as $option) {
                    $variantPriceCurrent = eval('return '.$variantPriceCurrent.$option['price_prefix'].$option['price'].' ;');
                    $variantPrice = eval('return '.$variantPrice.$option['price_prefix'].$option['price'].' ;');
                    $variantWeight = eval('return '.$variantWeight.$option['weight_prefix'].$option['weight'].' ;');
                    $attributeForShow[] = array(
                        "id" => (int) $option['product_option_value_id'],
                        "name" => $option['name'],
                        "option" => $option['name']
                    );
                }
                
                $variations[] = array(
                        "id" => (int) ($productId.$key),
                        "date_created" => $product['date_added'],
                        "date_modified" => $product['date_modified'],
                        "permalink" => "",
                        "sku" => "",
                        "price" => $variantPriceCurrent,
                        "regular_price" => $variantPrice,
                        "sale_price" => $variantPriceCurrent,
                        "date_on_sale_from" => $product['date_available'],
                        "date_on_sale_to" => "",
                        "on_sale" => true,
                        "purchasable" => true,
                        "visible" => true,
                        "virtual" => false,
                        "downloadable" => false,
                        "downloads" => [],
                        "download_limit" => -1,
                        "download_expiry" => -1,
                        "tax_status" => "taxable",
                        "tax_class" => "",
                        "manage_stock" => false,
                        "stock_quantity" => null,
                        "in_stock" => true,
                        "backorders" => "",
                        "backorders_allowed" => false,
                        "backordered" => false,
                        "weight" => $variantWeight,
                        "dimensions" => array(
                            "length" => $product['length'],
                            "width"  => $product['width'],
                            "height" => $product['height']
                        ),
                        "shipping_class" => "",
                        "shipping_class_id" => 0,
                        "image" => array(
                            array(
                                "id" => 0,
                                "date_created" => $product['date_added'],
                                "date_modified" => $product['date_modified'],
                                "src" => $product['image'],
                                "name" => "",
                                "alt" => "",
                                "position" => 0
                            )
                        ),
                        "attributes" => $attributeForShow
                );

            }
            return $variations;
        }
        
        public function getAllDefaultOptions($productId)
        {
            return array();
        }
        
        public function getAllOptionsOfProduct($productId)
        {
            $this->load->model('catalog/product');
            $options = $this->model_catalog_product->getProductOptions($productId);
            $attributes = array();
            foreach($options as $option) {
                if ( $option['required'] != 1 || ($option['type'] != 'radio' && $option['type'] != 'select')) {
                    continue;
                }
                $attribute['id'] = (int) $option['option_id'];
                $attribute['name'] = $option['name'];
                $attribute['type'] = 'dropdown';
                $attribute['variation'] = false;
                $attribute['visible'] = true;
                $attribute['options'] = array();
                if(is_array($option['product_option_value']) && !empty($option['product_option_value'])) {
                    foreach($option['product_option_value'] as $valueOptions) {
                        $attribute['options'][] = array(
                            'name' => $valueOptions['name'],
                            'value' => $valueOptions['name']
                        );
                    }
                }
                if($option['required'] == 1) {
                    $attribute['variation'] = true;
                }
                $attributes[] = $attribute;
            }
            return $attributes;
        }

        /**
         * Get All products
         * 
         * @param int $page
         * @param int $perPage
         * @param str $orderBy
         * @param str $order
         * @return array
         */
        protected function _getAllProduct($page, $perPage, $orderBy, $order)
        {
            if (!$page || $page < 1) {
                $page = 1;
            }
            if (!$perPage || $perPage < 1) {
                $perPage = 10;
            }
            $start = ($page - 1) * $perPage;
            if (!$orderBy) {
                $orderBy = 'product_id';
            }
            if (!$order) {
                $order = 'asc';
            }
            
            $this->load->model('catalog/product');
            $filterData = array(
                'sort'               => $orderBy,
                'order'              => $order,
                'start'              => $start,
                'limit'              => $perPage
            );
            $productsData = $this->model_catalog_product->getProducts($filterData);
            
            $products = array();
            if (!empty($productsData) && is_array($productsData)) {
                foreach ($productsData as $product) {
                    $products[] = $this->_getOneProductForApi($product['product_id']);
                }
            }
            return $products;
        }

        /**
         * 
         * @param string $param
         * @param int $page
         * @param int $perPage
         * @param string $order
         * @param string $orderBy
         * @return array
         */
        protected function _searchProduct($param, $page, $perPage, $order, $orderBy, $id_category = null)
        {
            $this->load->model('catalog/product');
            $filterData = array(
                'filter_name'        => $param,
                'sort'               => 'desc',
                'order'              => 'date_added',
                'start'              => ($page - 1) * $perPage,
                'limit'              => $perPage
            );
            if($id_category != null && is_int($id_category)) {
                $filterData['filter_category_id'] = $id_category;
            }
            $productsData = $this->model_catalog_product->getProducts($filterData);
            
            $products = array();
            if (!empty($productsData) && is_array($productsData)) {
                foreach ($productsData as $product) {
                    $products[] = $this->_getOneProductForApi($product['product_id']);
                }
            }
            return $products;
        }

        /**
         * 
         * @param type $param
         * @param type $page
         * @param type $perPage
         * @param type $orderBy
         * @param type $order
         * @return type
         */
        private function _getProductWtTag($param, $page, $perPage, $orderBy, $order)
        {
            $this->load->model('catalog/product');
            $filterData = array(
                'filter_tag'         => $param,
                'sort'               => $orderBy,
                'order'              => $order,
                'start'              => ($page - 1) * $perPage,
                'limit'              => $perPage
            );
            $productsData = $this->model_catalog_product->getProducts($filterData);
            
            $products = array();
            if (!empty($productsData) && is_array($productsData)) {
                foreach ($productsData as $product) {
                    $products[] = $this->_getOneProductForApi($product['product_id']);
                }
            }
            return $products;
        }

        #  
        #  ----- for Type 
        #  
        
        protected function _getOnsale()
        {
            
        }
        
        protected function _getFeatured()
        {
            $this->load->model('icymobi/setting');
            $productIds = $this->model_icymobi_setting->getFeaturedModuleProducts();
            
            $result = array();
            foreach($productIds as $productId) {
                $result[] = $this->_getOneProductForApi($productId);
            }
            return $result;
        }
        
        protected function _getBestseller()
        {
            $this->load->model('catalog/product');
            $limit = 10;
            $productsData = $this->model_catalog_product->getBestSellerProducts($limit);

            $products = array();

            if (!empty($productsData) && is_array($productsData)) {
                foreach ($productsData as $product) {
                    $products[] = $this->_getOneProductForApi($product['product_id']);
                }
            }
            return $products;
        }
        
        protected function _getMostview($page, $perPage)
        {
            $this->load->model('catalog/product');
            $filterData = array(
                'sort'               => 'desc',
                'order'              => 'viewed',
                'start'              => ($page - 1) * $perPage,
                'limit'              => $perPage
            );
            $productsData = $this->model_catalog_product->getProducts($filterData);
            
            $products = array();
            if (!empty($productsData) && is_array($productsData)) {
                foreach ($productsData as $product) {
                    $products[] = $this->_getOneProductForApi($product['product_id']);
                }
            }
            return $products;
        }
        
        protected function _getNew($page, $perPage)
        {
            $this->load->model('catalog/product');
            $filterData = array(
                'filter_filter'      => '',
                'sort'               => 'desc',
                'order'              => 'date_added',
                'start'              => ($page - 1) * $perPage,
                'limit'              => $perPage
            );
            $productsData = $this->model_catalog_product->getProducts($filterData);
            
            $products = array();
            if (!empty($productsData) && is_array($productsData)) {
                foreach ($productsData as $product) {
                    $products[] = $this->_getOneProductForApi($product['product_id']);
                }
            }
            return $products;
        }
    }
    