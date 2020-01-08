<?php

    /**
     * Copyright © 2016 Inspius. All rights reserved.
     * Author: Khanh Tran
     * Author URI: http://inspius.com
     */
    require_once('api.php');
    require_once('helpers/Data.php');
    
//    class FreeOrder extends PaymentModule
//    {
//
//        public $active = 1;
//        public $name = 'free_order';
//        public $displayName = 'free_order';
//
//    }

    class ControllerIcymobiFrontOrders extends ControllerIcymobiFrontApi
    {

        const REQUEST_CREATE_CART = 'create_cart';
        const REQUEST_GET_PRICE = 'get_price';
        const REQUEST_CREATE_ORDER = 'create_order';
        const REQUEST_GET_ORDER = 'get_order';
        const REQUEST_LIST_CUSTOMER_ORDER = 'list_customer_order';
        const REQUEST_LIST_COUNTRIES = 'list_countries';
        const REQUEST_CHANGE_ORDER_STATUS = 'change_order_status';

        public $id_lang_default;

//        public function __construct()
//        {
//            parent::__construct();
//            $this->id_lang_default = Configuration::get('PS_LANG_DEFAULT');
//        }

        protected function _getResponse()
        {
//            return $this->request->request;
//            return $this->createOrder();
//            return $this->createCart();
//            return $this->getPrice();
//            $data = $this->_getCountryList();
//            return $data;
            $data = array();
            $task = $this->request->get['task'];

            // main parameter
            $param = isset($this->request->request['param']) ? $this->request->request['param'] : '';
            // other parameter
            // get product by type
            switch ($task) {
                case self::REQUEST_CREATE_CART:
                    if (!$this->request->request['line_items'] || !$this->request->request['billing'] || !$this->request->request['shipping']) {
                        throw new Exception('Invalid parameters');
                    }
                    return $this->createCart();
                case self::REQUEST_GET_PRICE:
                    if (!$this->request->request['line_items'] || !$this->request->request['cart_id']) {
                        throw new Exception('Invalid parameters');
                    }
                    $data = $this->getPrice();
                    break;
                case self::REQUEST_CREATE_ORDER:
                    if (!$this->request->request['line_items'] || !$this->request->request['billing'] || !$this->request->request['shipping'] || !$this->request->request['payment_method'] || !$this->request->request['payment_method_title'] || !$this->request->request['shipping_lines']
                    ) {
                        throw new Exception('Invalid parameters');
                    }
                    $data = $this->createOrder();
                    break;
                case self::REQUEST_CHANGE_ORDER_STATUS:
                    if (!$this->request->request['id'] || !$this->request->request['status']) {
                        throw new Exception('Invalid parameters');
                    }
                    $data = $this->changeOrderStatus();
                    break;
                case self::REQUEST_LIST_CUSTOMER_ORDER:
                    $customer_id = intval($this->request->request['customer_id']);
                    if (!$customer_id) {
                        throw new Exception('Invalid Parameter');
                    }
                    $data = $this->getListCustomerOrder($customer_id);
                    break;
                case self::REQUEST_LIST_COUNTRIES:
                    $data = $this->_getCountryList();
                    break;
                default:
                    $data['OrderObject'] = $this;
                    $result = $this->event->trigger('model/checkout/order/addOrderHistory/after', array($task, &$data));
                    if($result !== null){
                        $data = $result;
                    }
                    break;
            }
            return $data;
        }

        public function _getCountryList()
        {
            $this->load->model('localisation/country');
            $this->load->model('localisation/zone');
            
            $countries = $this->model_localisation_country->getCountries();
            foreach($countries as &$country) {
                $country['id'] = $country['iso_code_2'];
                $country['state'] = array();
                $zone = $this->model_localisation_zone->getZonesByCountryId($country['country_id']);
                foreach($zone as $state) {
                    $country['state'][$state['code']] = $state['name'];
                }
                unset($country['iso_code_2']);
                unset($country['iso_code_3']);
                unset($country['address_format']);
                unset($country['postcode_required']);
                unset($country['status']);
                unset($country['country_id']);
            }
            return $countries;
            
            
            
            if (Configuration::get('PS_RESTRICT_DELIVERED_COUNTRIES')) {
                $arrayCountries = Carrier::getDeliveredCountries($this->id_lang_default, true, true);
            } else {
                $arrayCountries = Country::getCountries($this->id_lang_default, true);
            }

            foreach ($arrayCountries as &$country) {
                $country['id'] = $country['iso_code'];
                $country['state'] = array();
                if ($country['contains_states'] == 1) {
                    foreach ($country['states'] as $state) {
                        $country['state'][$state['iso_code']] = $state['name'];
                    }
                }
                unset($country['id_country']);
                unset($country['states']);
                unset($country['id_lang']);
                unset($country['id_zone']);
                unset($country['iso_code']);
                unset($country['id_currency']);
                unset($country['call_prefix']);
                unset($country['active']);
                unset($country['contains_states']);
                unset($country['need_identification_number']);
                unset($country['need_zip_code']);
                unset($country['zip_code_format']);
                unset($country['display_tax_label']);
                unset($country['country']);
                unset($country['zone']);
            }
            return ($arrayCountries);
        }

        public function getPrice()
        {   
            $billing = json_decode(htmlspecialchars_decode($this->request->request['billing']), true);
            $shippingAddress = json_decode(htmlspecialchars_decode($this->request->request['shipping']), true);
            $line_items = json_decode(htmlspecialchars_decode($this->request->request['line_items']), true);
            $customerId = @$this->request->request['customer_id'];
            $coupon = $this->request->request['coupon'];
            
            $this->referenceFormatBillingAndShipping($billing, $shippingAddress);
            $this->removeCurrentCart();
            if(isset($this->session->data['coupon'])) {
                unset($this->session->data['coupon']);
            }
            
            
            foreach($line_items as $item) {
                $this->addOneProductIntoCart($item);
            }
            
            $totalData = $this->executeTotalForCart();
            
            $totals = $totalData['totals'];
            $total = $totalData['total'];
            
            $discount = 0;
            $subtotal = 0;
            $tax = 0;
            $shipping = 0;
            
            foreach ($totals as $total1) {
                if($total1['code'] == 'coupon') {
                    $discount += (float) $total1['value'];
                } elseif ($total1['code'] == 'sub_total') {
                    $subtotal += (float) $total1['value'];
                } elseif ($total1['code'] == 'tax') {
                    $tax += (float) $total1['value'];
                } elseif ($total1['code'] == 'shipping') {
                    $shipping += (float) $total1['value'];
                }
            }
            
            return array(
                'currency'       => $this->config->get('config_currency'),
                'discount_total' => (float) $discount,
                'subtotal'       => (float) $subtotal,
                'tax'            => (float) $tax,
                'total'          => (float) $total - $shipping,
            );
        }
        
        public function executeTotalForCart()
        {
            $coupon = '';
            if(isset($this->request->request['coupon'])) {
                $coupon = $this->request->request['coupon'];
            }
            
            $this->load->model('extension/total/coupon');
            $couponInfo = $this->model_extension_total_coupon->getCoupon($coupon);
            
            if($couponInfo) {
                $this->session->data['coupon'] = $coupon;
            }
            $this->load->model('extension/extension');

            $totals = array();
            $taxes = $this->cart->getTaxes();
            $total = 0;

            // Because __call can not keep var references so we put them into an array. 			
            $total_data = array(
                    'totals' => &$totals,
                    'taxes'  => &$taxes,
                    'total'  => &$total
            );

            $sort_order = array();

            $results = $this->model_extension_extension->getExtensions('total');

            foreach ($results as $key => $value) {
                    $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }

            array_multisort($sort_order, SORT_ASC, $results);

            foreach ($results as $result) {
                    if ($this->config->get($result['code'] . '_status')) {
                            $this->load->model('extension/total/' . $result['code']);

                            // We have to put the totals in an array so that they pass by reference.
                            $this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
                    }
            }

            $sort_order = array();

            foreach ($totals as $key => $value) {
                    $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $totals);
            return $total_data;
        }
        
        public function removeCurrentCart()
        {
            $currentCarts = $this->cart->getProducts();
            if(!empty($currentCarts)) {
                foreach($currentCarts as $currentCart) {
                    $this->cart->remove($currentCart['cart_id']);
                }
            }
        }
        
        public function createCart()
        {
            $billing = json_decode(htmlspecialchars_decode($this->request->request['billing']), true);
            $shipping = json_decode(htmlspecialchars_decode($this->request->request['shipping']), true);
            $line_items = json_decode(htmlspecialchars_decode($this->request->request['line_items']), true);
            $customerId = @$this->request->request['customer_id'];
            $coupon = $this->request->request['coupon'];
            
            $this->referenceFormatBillingAndShipping($billing, $shipping);
            $this->removeCurrentCart();
            
            $totals = $this->createCartObjectAndSave($line_items, $customerId, $coupon);
            $shippingRawMethod = $this->getDeliveryOptionList($shipping);
            $shippingMethod = $this->formatShippingMethod($shippingRawMethod);
            $paymentMethod = $this->getPaymentMethod($billing);
            
            $currentCarts = $this->cart->getProducts();
            $cartIds = array();
            if(!empty($currentCarts)) {
                foreach($currentCarts as $currentCart) {
                    $cartIds[] = $currentCart['cart_id'];
                }
            }

            $data = array(
                'cart_id'          => join(',', $cartIds),
                'price'            => $totals,
                'shipping_methods' => $shippingMethod,
                'payment_methods'  => $paymentMethod
            );
            return $data;
        }
        
        public function referenceFormatBillingAndShipping(&$billing, &$shipping)
        {
            $countryInfo = $this->getCountryInfoByIsoCode2($billing['country']);
            if(isset($billing['state'])) {
                $stateInfo = $this->getStateCountryByIsoCode($billing['state'], $countryInfo['country_id']);
                $billing['zone_code'] = isset($stateInfo['code']) ? $stateInfo['code'] : '';
                $billing['zone'] = isset($stateInfo['name']) ? $stateInfo['name'] : '';
                $billing['zone_id'] = isset($stateInfo['zone_id']) ? $stateInfo['zone_id'] : '';
            }
            
            $billing['firstname'] = $billing['first_name'];
            $billing['lastname'] = $billing['last_name'];
            $billing['custom_field'] = array();
            $billing['address_format'] = '';
            $billing['iso_code_2'] = $billing['country'];
            $billing['iso_code_3'] = $countryInfo['iso_code_3'];
            $billing['country'] = $countryInfo['name'];
            $billing['country_id'] = $countryInfo['country_id'];
            $billing['telephone'] = $billing['phone'];
            
            unset($billing['first_name']);
            unset($billing['last_name']);
            
            if(isset($shipping['state'])) {
                $stateInfo = $this->getStateCountryByIsoCode($shipping['state'], $countryInfo['country_id']);
                $shipping['zone_code'] = isset($stateInfo['code']) ? $stateInfo['code'] : '';
                $shipping['zone'] = isset($stateInfo['name']) ? $stateInfo['name'] : '';
                $shipping['zone_id'] = isset($stateInfo['zone_id']) ? $stateInfo['zone_id'] : '';
            }
            
            $shipping['firstname'] = $shipping['first_name'];
            $shipping['lastname'] = $shipping['last_name'];
            $shipping['custom_field'] = array();
            $shipping['address_format'] = '';
            $shipping['iso_code_2'] = $shipping['country'];
            $shipping['iso_code_3'] = $countryInfo['iso_code_3'];
            $shipping['country'] = $countryInfo['name'];
            $shipping['country_id'] = $countryInfo['country_id'];
            $shipping['telephone'] = $shipping['phone'];
            
            unset($shipping['first_name']);
            unset($shipping['last_name']);

            
        }
        
        public function getStateCountryByIsoCode($isoCode, $countryId)
        {
            $this->load->model('icymobi/setting');
            $stateInfo = $this->model_icymobi_setting->getStateCountryByIsoCode($isoCode, $countryId);
            return $stateInfo;
        }
        
        public function getCountryInfoByIsoCode2($isoCode2)
        {
            $this->load->model('icymobi/setting');
            $countryInfo = $this->model_icymobi_setting->getCountryInfoByIsoCode2($isoCode2);
            return $countryInfo;
        }
        
        public function getDeliveryOptionList($shipingAdress)
        {
            // Shipping Methods
            $method_data = array();

            $this->load->model('extension/extension');

            $results = $this->model_extension_extension->getExtensions('shipping');

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('extension/shipping/' . $result['code']);

                    $quote = $this->{'model_extension_shipping_' . $result['code']}->getQuote($shipingAdress);

                    if ($quote) {
                        $method_data[$result['code']] = array(
                                'title'      => $quote['title'],
                                'quote'      => $quote['quote'],
                                'sort_order' => $quote['sort_order'],
                                'error'      => $quote['error']
                        );
                    }
                }
            }

            $sort_order = array();

            foreach ($method_data as $key => $value) {
                    $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $method_data);
            $this->session->data['shipping_methods'] = $method_data;
            
            return $method_data;
        }
        
        public function createCartObjectAndSave($line_items, $customerId, $coupon)
        {
            if(isset($this->session->data['coupon'])) {
                unset($this->session->data['coupon']);
            }
            foreach($line_items as $item) {
                $this->addOneProductIntoCart($item);
            }
            $totalData = $this->executeTotalForCart();
            
            $totals = $totalData['totals'];
            $total = $totalData['total'];
            
            $discount = 0;
            $subtotal = 0;
            $tax = 0;
            $shipping = 0;
            
            foreach ($totals as $total1) {
                if($total1['code'] == 'coupon') {
                    $discount += (float) $total1['value'];
                } elseif ($total1['code'] == 'sub_total') {
                    $subtotal += (float) $total1['value'];
                } elseif ($total1['code'] == 'tax') {
                    $tax += (float) $total1['value'];
                } elseif ($total1['code'] == 'shipping') {
                    $shipping += (float) $total1['value'];
                }
            }
            
            return array(
                'currency'       => $this->config->get('config_currency'),
                'discount_total' => (float) $discount,
                'subtotal'       => (float) $subtotal,
                'tax'            => (float) $tax,
                'total'          => (float) $total - $shipping,
            );
        }
        
        public function addOneProductIntoCart($item)
        {
            $this->load->model('catalog/product');
            
            $productId = (string) $item['product_id'];
            if(isset($item['variation_id'])) {
                $productIdConcatoptionId  = (string) $item['variation_id'];
                
                $optionId = substr($productIdConcatoptionId, strlen($productId));
                $option = $this->makeOptionArrayToAddCartOriginal($optionId, $productId);
                $this->cart->add($productId,(int) $item['quantity'],$option);
            } else {
                $this->cart->add((int)$productId,(int) $item['quantity']);
            }
            
        }
        
        public function makeOptionArrayToAddCartOriginal($optionId, $productId)
        {
            $this->load->model('catalog/product');
            $allOptions = $this->model_catalog_product->getProductOptions($productId);
            $attributesForVariation = array();
            foreach ($allOptions as $option) {
                if($option['required'] == 1 && ($option['type'] == 'radio' || $option['type'] == 'select')) {
                    $attributesForVariation[] = $option;
                }
            }
            $arrayKeyOption = str_split($optionId);
            $result = array();
            foreach ($arrayKeyOption as $key => $Key) {
                if($key%2 != 0) {
                    continue;
                } else {
                    $result[$attributesForVariation[$Key]['product_option_id']] = $attributesForVariation[$Key]['product_option_value'][$arrayKeyOption[$key+1]]['product_option_value_id'];
                }
            }
            return $result;
        }
        
        public function formatShippingMethod($shippingRawMethods)
        {
            $arrayShipping = array();
            foreach ($shippingRawMethods as $key => $shippingRawMethod) {
                $shippingRawMethod['quote'] = array_values($shippingRawMethod['quote']); 
                $r = array();
                $r['cost'] = $shippingRawMethod['quote'][0]['cost'];
                $r['availability'] = 1;
                $r['countries'] = array();
                $r['enabled'] = 'yes';
                $r['errors'] = array();
                $r['fee'] = null;
                $r['form_fields'] = array();
                $r['has_settings'] = true;
                $r['id'] = $shippingRawMethod['quote'][0]['code'];
                $r['instance_form_fields'] = array(
                    'min_amount' => array(
                        'default'     => "0",
                        'desc_tip'    => true,
                        'description' => "",
                        'placeholder' => "",
                        'title'       => "",
                        'type'        => ""
                    ),
                    'title'      => array(
                        'title' => "Title",
                        'type'  => "text"
                    ),
                    'requires'   => array(
                        'class'   => "",
                        'default' => ""
                    )
                );
                $r['instance_id'] = $shippingRawMethod['quote'][0]['code'];
                $r['instance_settings'] = array(
                    'title'      => "",
                    'requires'   => "",
                    'min_amount' => "0"
                );
                $r['method_description'] = "";
                $r['method_order'] = 1;
                $r['method_title'] = "";
                $r['min_amount'] = "0";
                $r['minimum_fee'] = null;
                $r['plugin_id'] = "";
                $r['rates'] = array();
                $r['requires'] = "";
                $r['settings'] = array();
                $r['settings_html'] = '';
                $r['supports'] = array();
                $r['tax_status'] = "";
                $r['title'] = $shippingRawMethod['title'];
                $arrayShipping[$key] = $r;
            }
            $return = array(
                'default' => array(
                    'meta_data'        => array(),
                    'zone_id'          => 0,
                    'zone_locations'   => array(),
                    'zone_name'        => '',
                    'zone_order'       => '',
                    'shipping_methods' => $arrayShipping
                ),
                'zones'   => array()
            );
            return $return;
        }
        
        public function getPaymentMethod($billingAddress)
        {
            // Totals
            $totals = array();
            $taxes = $this->cart->getTaxes();
            $total = 0;

            // Because __call can not keep var references so we put them into an array.
            $total_data = array(
                    'totals' => &$totals,
                    'taxes'  => &$taxes,
                    'total'  => &$total
            );

            $this->load->model('extension/extension');

            $sort_order = array();

            $results = $this->model_extension_extension->getExtensions('total');

            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }

            array_multisort($sort_order, SORT_ASC, $results);

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('extension/total/' . $result['code']);

                    // We have to put the totals in an array so that they pass by reference.
                    $this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
                }
            }

            // Payment Methods
            $method_data = array();

            $this->load->model('extension/extension');

            $results = $this->model_extension_extension->getExtensions('payment');

            $recurring = $this->cart->hasRecurringProducts();

            foreach ($results as $result) {
                $paymentDefault = array('cod','pumcp', 'cheque', 'bank_transfer');
                if(!in_array($result['code'], $paymentDefault)) {
                    continue;
                }
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('extension/payment/' . $result['code']);

                    $method = $this->{'model_extension_payment_' . $result['code']}->getMethod($billingAddress, $total);

                    if ($method) {
                        if ($recurring) {
                            if (property_exists($this->{'model_extension_payment_' . $result['code']}, 'recurringPayments') && $this->{'model_extension_payment_' . $result['code']}->recurringPayments()) {
                                    $method_data[$result['code']] = $method;
                            }
                        } else {
                            $method_data[$result['code']] = $method;
                        }
                    }
                }
            }

            $sort_order = array();

            foreach ($method_data as $key => $value) {
                    $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $method_data);
            
            $this->session->data['payment_methods'] = $method_data;
            
            $return = array();
            foreach($method_data as $key => $med) {
                $return[$key] = array(
                    'id' => $med['code'],
                    'title' => $med['title'],
                    'description' => ''
                );
            }
            $result = $this->event->trigger('model/checkout/order/addOrderHistory/after', array('icymobi_payment', &$return));
            if(!is_null($result)) {
                $return = $results;
            }
            return $return;
        }
        
        public function createOrder() {
            
            $billing = json_decode(htmlspecialchars_decode($this->request->request['billing']), true);
            $shipping = json_decode(htmlspecialchars_decode($this->request->request['shipping']), true);
            $line_items = json_decode(htmlspecialchars_decode($this->request->request['line_items']), true);
            $shipping_line = json_decode(htmlspecialchars_decode($this->request->request['shipping_lines']), true);
            $paymentMethod = $this->request->request['payment_method'];
            $paymentMethodTitle = $this->request->request['payment_method_title'];
            $paymentMethodData = $this->request->request['payment_method_data'];
            $customerId = intval($this->request->request['customer_id']);
            $coupon = $this->request->request['coupon'];
            $deviceToken = $this->request->request['device_token'];
            
            $this->referenceFormatBillingAndShipping($billing, $shipping);
            $this->removeCurrentCart();
            
            $this->load->model('extension/total/voucher');
            
            $voucherInfo = $this->model_extension_total_voucher->getVoucher($coupon);

            if ($voucherInfo) {
                    $this->session->data['voucher'] = $coupon;       
            }
            $this->createCartObjectAndSave($line_items, $customerId, $coupon);

            // Validate cart has products and has stock.
            if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
                throw new Exception(MessageIcy::CART_UNAVAILBLE_STOCK);
            }

            // Validate minimum quantity requirements.
            $products = $this->cart->getProducts();

            foreach ($products as $product) {
                $productTotal = 0;

                foreach ($products as $product_2) {
                    if ($product_2['product_id'] == $product['product_id']) {
                            $productTotal += $product_2['quantity'];
                    }
                }

                if ($product['minimum'] > $productTotal) {
                    throw new Exception(MessageIcy::ORDER_PRODUCT_QUANTITY_LESS_THAN_MIN);
                }
            }

            $orderData = array();

            $totals = array();
            $taxes = $this->cart->getTaxes();
            $total = 0;

            // Because __call can not keep var references so we put them into an array.
            $total_data = array(
                    'totals' => &$totals,
                    'taxes'  => &$taxes,
                    'total'  => &$total
            );

            $this->load->model('extension/extension');

            $sort_order = array();

            $results = $this->model_extension_extension->getExtensions('total');

            foreach ($results as $key => $value) {
                    $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }

            array_multisort($sort_order, SORT_ASC, $results);

            foreach ($results as $result) {
                    if ($this->config->get($result['code'] . '_status')) {
                            $this->load->model('extension/total/' . $result['code']);

                            // We have to put the totals in an array so that they pass by reference.
                            $this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
                    }
            }

            $sort_order = array();

            foreach ($totals as $key => $value) {
                    $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $totals);

            $orderData['totals'] = $totals;

            $this->load->language('checkout/checkout');

            $orderData['invoice_prefix'] = $this->config->get('config_invoice_prefix');
            $orderData['store_id'] = $this->config->get('config_store_id');
            $orderData['store_name'] = $this->config->get('config_name');

            if ($orderData['store_id']) {
                $orderData['store_url'] = $this->config->get('config_url');
            } else {
                if ($this->request->server['HTTPS']) {
                    $orderData['store_url'] = HTTPS_SERVER;
                } else {
                    $orderData['store_url'] = HTTP_SERVER;
                }
            }

            if ($customerId) {
                $this->load->model('account/customer');

                $customer_info = $this->model_account_customer->getCustomer($customerId);

                $orderData['customer_id'] = $customerId;
                $orderData['customer_group_id'] = $customer_info['customer_group_id'];
                $orderData['firstname'] = $customer_info['firstname'];
                $orderData['lastname'] = $customer_info['lastname'];
                $orderData['email'] = $customer_info['email'];
                $orderData['telephone'] = $customer_info['telephone'];
                $orderData['fax'] = $customer_info['fax'];
                $orderData['custom_field'] = json_decode($customer_info['custom_field'], true);
            } else {
                    $orderData['customer_id'] = 0;
                    $orderData['customer_group_id'] = $this->config->get('config_customer_group_id');;
                    $orderData['firstname'] = $billing['firstname'];
                    $orderData['lastname'] = $billing['lastname'];
                    $orderData['email'] = $billing['email'];
                    $orderData['telephone'] = $billing['telephone'];
                    $orderData['fax'] = '';
                    $orderData['custom_field'] = $billing['custom_field'];
            }

            $orderData['payment_firstname'] = $billing['firstname'];
            $orderData['payment_lastname'] = $billing['lastname'];
            $orderData['payment_company'] = $billing['company'];
            $orderData['payment_address_1'] = $billing['address_1'];
            $orderData['payment_address_2'] = $billing['address_2'];
            $orderData['payment_city'] = $billing['city'];
            $orderData['payment_postcode'] = $billing['postcode'];
            $orderData['payment_zone'] = $billing['zone'];
            $orderData['payment_zone_id'] = $billing['zone_id'];
            $orderData['payment_country'] = $billing['country'];
            $orderData['payment_country_id'] = $billing['country_id'];
            $orderData['payment_address_format'] = $billing['address_format'];
            $orderData['payment_custom_field'] = array();


            $orderData['payment_method'] = $paymentMethodTitle;

            $orderData['payment_code'] = $paymentMethod;


            if ($this->cart->hasShipping()) {
                    $orderData['shipping_firstname'] = $billing['firstname'];
                    $orderData['shipping_lastname'] = $billing['lastname'];
                    $orderData['shipping_company'] = $billing['company'];
                    $orderData['shipping_address_1'] = $billing['address_1'];
                    $orderData['shipping_address_2'] = $billing['address_2'];
                    $orderData['shipping_city'] = $billing['city'];
                    $orderData['shipping_postcode'] = $billing['postcode'];
                    $orderData['shipping_zone'] = $billing['zone'];
                    $orderData['shipping_zone_id'] = $billing['zone_id'];
                    $orderData['shipping_country'] = $billing['country'];
                    $orderData['shipping_country_id'] = $billing['country_id'];
                    $orderData['shipping_address_format'] = $billing['address_format'];
                    $orderData['shipping_custom_field'] = array();


                    $orderData['shipping_method'] = $shipping_line[0]['method_title'];

                    $orderData['shipping_code'] = $shipping_line[0]['method_id'];
            } else {
                    $orderData['shipping_firstname'] = '';
                    $orderData['shipping_lastname'] = '';
                    $orderData['shipping_company'] = '';
                    $orderData['shipping_address_1'] = '';
                    $orderData['shipping_address_2'] = '';
                    $orderData['shipping_city'] = '';
                    $orderData['shipping_postcode'] = '';
                    $orderData['shipping_zone'] = '';
                    $orderData['shipping_zone_id'] = '';
                    $orderData['shipping_country'] = '';
                    $orderData['shipping_country_id'] = '';
                    $orderData['shipping_address_format'] = '';
                    $orderData['shipping_custom_field'] = array();
                    $orderData['shipping_method'] = '';
                    $orderData['shipping_code'] = '';
            }

            $orderData['products'] = array();

            foreach ($this->cart->getProducts() as $product) {
                    $optionData = array();

                    foreach ($product['option'] as $option) {
                            $optionData[] = array(
                                    'product_option_id'       => $option['product_option_id'],
                                    'product_option_value_id' => $option['product_option_value_id'],
                                    'option_id'               => $option['option_id'],
                                    'option_value_id'         => $option['option_value_id'],
                                    'name'                    => $option['name'],
                                    'value'                   => $option['value'],
                                    'type'                    => $option['type']
                            );
                    }

                    $orderData['products'][] = array(
                            'product_id' => $product['product_id'],
                            'name'       => $product['name'],
                            'model'      => $product['model'],
                            'option'     => $optionData,
                            'download'   => $product['download'],
                            'quantity'   => $product['quantity'],
                            'subtract'   => $product['subtract'],
                            'price'      => $product['price'],
                            'total'      => $product['total'],
                            'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
                            'reward'     => $product['reward']
                    );
            }

            // Gift Voucher
            $orderData['vouchers'] = array();

            if ($voucherInfo) {
                $orderData['vouchers'][] = array(
                        'description'      => $voucherInfo['description'],
                        'code'             => token(10),
                        'to_name'          => $voucherInfo['to_name'],
                        'to_email'         => $voucherInfo['to_email'],
                        'from_name'        => $voucherInfo['from_name'],
                        'from_email'       => $voucherInfo['from_email'],
                        'voucher_theme_id' => $voucherInfo['voucher_theme_id'],
                        'message'          => $voucherInfo['message'],
                        'amount'           => $voucherInfo['amount']
                );
            }

            $orderData['comment'] = '';
            $orderData['total'] = $total_data['total'];

            $orderData['affiliate_id'] = 0;
            $orderData['commission'] = 0;
            $orderData['marketing_id'] = 0;
            $orderData['tracking'] = '';

            $orderData['language_id'] = $this->config->get('config_language_id');
            $orderData['currency_id'] = $this->currency->getId($this->config->get('config_currency'));
            $orderData['currency_code'] = $this->config->get('config_currency');
            $orderData['currency_value'] = $this->currency->getValue($this->config->get('config_currency'));
            $orderData['ip'] = $this->request->server['REMOTE_ADDR'];

            if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
                    $orderData['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
            } elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
                    $orderData['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
            } else {
                    $orderData['forwarded_ip'] = '';
            }

            if (isset($this->request->server['HTTP_USER_AGENT'])) {
                    $orderData['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
            } else {
                    $orderData['user_agent'] = '';
            }

            if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
                    $orderData['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
            } else {
                    $orderData['accept_language'] = '';
            }

            $this->load->model('checkout/order');

            $orderId = $this->session->data['order_id'] = $this->model_checkout_order->addOrder($orderData);

            switch ($orderData['payment_code']) {
                case 'cheque':
                    $this->load->language('extension/payment/cheque');

                    $comment  = $this->language->get('text_payable') . "\n";
                    $comment .= $this->config->get('cheque_payable') . "\n\n";
                    $comment .= $this->language->get('text_address') . "\n";
                    $comment .= $this->config->get('config_address') . "\n\n";
                    $comment .= $this->language->get('text_payment') . "\n";

                    $this->model_checkout_order->addOrderHistory($orderId, $this->config->get('cheque_order_status_id'), $comment, true);
                    break;
                case 'bank_transfer':
                    $this->load->language('extension/payment/bank_transfer');

                    $comment  = $this->language->get('text_instruction') . "\n\n";
                    $comment .= $this->config->get('bank_transfer_bank' . $this->config->get('config_language_id')) . "\n\n";
                    $comment .= $this->language->get('text_payment');

                    $this->model_checkout_order->addOrderHistory($orderId, $this->config->get('bank_transfer_order_status_id'), $comment, true);
                    break;
                case 'cod':
                    
                    $this->model_checkout_order->addOrderHistory($orderId, $this->config->get('cod_order_status_id'));
                    break;
                default :
                    
                    $this->model_checkout_order->addOrderHistory($orderId, 1); /* Pending Status */
                    break;
            }
            
//            if($deviceToken) {
//                $this->load->model('icymobi/setting');
//                $this->model_icymobi_setting->updateIcymobiOrderDeviceToken($orderId, $deviceToken);
//            }
            
            $orderDetail = $this->model_checkout_order->getOrder($orderId);
            
            $this->formatOrderByReference($orderDetail, $line_items, $shipping_line);
            
            return $orderDetail;
	}
        
        public function formatOrderByReference(&$orderDetail, $line_items, $shipping_line)
        {
            $this->load->model('catalog/product');
            foreach($line_items as &$item) {
                $product = $this->model_catalog_product->getProduct($item['product_id']);
                $item['subtotal'] = $product['special']?:$product['price'];
            }
            $this->load->model('icymobi/setting');
            $totals = $this->model_icymobi_setting->getOrderTotals($orderDetail['order_id']);
            
            $subTotal = 0;
            $tax = 0;
            $total = 0;
            
            foreach ($totals as $orderTotal) {
                if($orderTotal['code'] == 'tax') {
                    $tax += (float) $orderTotal['value'];
                } elseif ($orderTotal['code'] == 'sub_total') {
                    $subTotal += (float) $orderTotal['value'];
                } elseif ($orderTotal['code'] == 'total') {
                    $total += (float) $orderTotal['value'];
                }
            }
            
            $orderDetail['id'] = $orderDetail['order_id'];
            $orderDetail['parent_id'] = 0;
            $orderDetail['status'] = $orderDetail['order_status'];
            $orderDetail['order_key'] = '';
            $orderDetail['number'] = $orderDetail['order_id'];
            $orderDetail['currency'] = $orderDetail['currency_code'];
            $orderDetail['version'] = VERSION?:'0';
            $orderDetail['prices_include_tax'] = false;
            $orderDetail['date_created'] = $orderDetail['date_added'];
            $orderDetail['date_modified'] = $orderDetail['date_modified'];
            $orderDetail['customer_id'] = $orderDetail['customer_id'];
            $orderDetail['discount_total'] = 0;
            $orderDetail['discount_tax'] = 0;
            $orderDetail['shipping_total'] = 0;
            $orderDetail['shipping_tax'] = 0;
            $orderDetail['cart_tax'] = 0;
            $orderDetail['total'] = $total;
            $orderDetail['total_tax'] = $tax;
            $orderDetail['billing'] = $orderDetail['currency_code'];
            $orderDetail['shipping'] = $orderDetail['currency_code'];
            $orderDetail['payment_method_title'] = $orderDetail['payment_method'];
            $orderDetail['payment_method'] = $orderDetail['payment_code'];
            $orderDetail['transaction_id'] = '';
            $orderDetail['customer_ip_address'] = $orderDetail['ip'];
            $orderDetail['customer_user_agent'] = $orderDetail['user_agent'];
            $orderDetail['created_via'] = 'icymobi_opencart';
            $orderDetail['customer_note'] = $orderDetail['comment'];
            $orderDetail['date_completed'] = null;
            $orderDetail['date_paid'] = null;
            $orderDetail['cart_hash'] = null;
            $orderDetail['line_items'] = $line_items;
            $orderDetail['tax_lines'] = array();
            $orderDetail['shipping_lines'] = $shipping_line;
            $orderDetail['fee_lines'] = array();
            $orderDetail['coupon_lines'] = array();
            $orderDetail['refunds'] = array();
            $orderDetail['_links'] = array(
                'self' => array(
                    'href' => ''
                ),
                'collection' => array(
                    'href' => ''
                ),
                'customer' => array(
                    'href' => ''
                )
            );
            $orderDetail['status_text'] = $orderDetail['order_status'];
        }
        
        public function getAndFormatOrderByOrderId($orderId)
        {
            $this->load->model('checkout/order');
            $orderDetail = $this->model_checkout_order->getOrder($orderId);
            
            $this->load->model('icymobi/setting');
            $totals = $this->model_icymobi_setting->getOrderTotals($orderDetail['order_id']);
            
            $subTotal = 0;
            $tax = 0;
            $total = 0;
            $discount = 0;
            $shipping = 0;
            
            foreach ($totals as $orderTotal) {
                if($orderTotal['code'] == 'tax') {
                    $tax += (float) $orderTotal['value'];
                } elseif ($orderTotal['code'] == 'sub_total') {
                    $subTotal += (float) $orderTotal['value'];
                } elseif ($orderTotal['code'] == 'total') {
                    $total += (float) $orderTotal['value'];
                } elseif ($orderTotal['code'] == 'coupon') {
                    $discount += (float) $orderTotal['value'];
                } elseif ($orderTotal['code'] == 'shiipping') {
                    $shipping += (float) $orderTotal['value'];
                }
            }

            $return = array(
                "id"                   => (int) $orderId,
                "parent_id"            => 0,
                "status"               => $orderDetail['order_status'],
                "status_text"          => $orderDetail['order_status'],
                "order_key"            => $orderId,
                "number"               => 0,
                "currency"             => $orderDetail['currency_code'],
                "version"              => null,
                "prices_include_tax"   => $total,
                "date_created"         => $orderDetail['date_added'],
                "date_modified"        => $orderDetail['date_modified'],
                "customer_id"          => (int) $orderDetail['customer_id'],
                "discount_total"       => $discount,
                "discount_tax"         => '',
                "shipping_total"       => $shipping,
                "shipping_tax"         => '',
                "cart_tax"             => '',
                   "subTotal" => $subTotal,
                "total"                => $total,
                "total_tax"            => $tax,
                "billing" => array(
                "first_name" => $orderDetail['payment_firstname'],
                "last_name" => $orderDetail['payment_lastname'],
                "company" => $orderDetail['payment_company'],
                "address_1" => $orderDetail['payment_address_1'],
                "address_2" => $orderDetail['payment_address_2'],
                "city" => $orderDetail['payment_city'],
                "state" => $orderDetail['payment_zone_id'],
                "postcode" => $orderDetail['payment_postcode'],
                "country" => $orderDetail['payment_country'],
                "email" => $orderDetail['email'],
                "phone" => $orderDetail['telephone'],
            ),
            "shipping" => array(
                "first_name" => $orderDetail['shipping_firstname'],
                "last_name" => $orderDetail['shipping_lastname'],
                "company" => $orderDetail['shipping_company'],
                "address_1" => $orderDetail['shipping_address_1'],
                "address_2" => $orderDetail['shipping_address_2'],
                "city" => $orderDetail['shipping_city'],
                "state" => $orderDetail['shipping_zone_id'],
                "postcode" => $orderDetail['shipping_postcode'],
                "country" => $orderDetail['shipping_country'],
                "email" => $orderDetail['email'],
                "phone" => $orderDetail['telephone'],
            ),
                "payment_method"       => $orderDetail['payment_code'],
                "payment_method_title" => $orderDetail['payment_method'],
                "transaction_id"       => "",
                "customer_ip_address"  => "",
                "customer_user_agent"  => "",
                "created_via"          => "rest-api",
                "customer_note"        => "",
                "date_completed"       => "",
                "date_paid"            => "",
                "cart_hash"            => 0,
                "line_items"           => array(),
                "tax_lines"            => array(),
                "shipping_lines"       => array(),
                "fee_lines"            => array(),
                "coupon_lines"         => array(),
                "refunds"              => array(),
                "_links"               => array(
                    "self"        => array(
                        0 => array(
                            "href" => ""
                        )
                    ),
                    "collection"  => array(
                        0 => array(
                            "href" => ""
                        )
                    ),
                    "status_text" => $orderDetail['order_status']
            ));
            return $return;
        }

        public function formatShipping($shipping)
        {
            foreach ($shipping as &$val) {
                $val['id'] = (int) $val['id_carrier'];
                $val['method_id'] = $val['carrier_name'];
                $val['method_title'] = $val['carrier_name'];
                $val['total'] = $val['shipping_cost_tax_incl'];
                $val['total_tax'] = $val['shipping_cost_tax_incl'] - $val['shipping_cost_tax_excl'];
                $val['taxes'] = array();
                unset($val['id_order_invoice']);
                unset($val['weight']);
                unset($val['shipping_cost_tax_excl']);
                unset($val['shipping_cost_tax_incl']);
                unset($val['url']);
                unset($val['id_carrier']);
                unset($val['carrier_name']);
                unset($val['date_add']);
                unset($val['type']);
                unset($val['can_edit']);
                unset($val['tracking_number']);
                unset($val['id_order_carrier']);
                unset($val['order_state_name']);
                unset($val['state_name']);
            }
            return $shipping;
        }

        public function formatProducts($products)
        {
            foreach ($products as &$product) {
                foreach ($product as $field => &$value) {
                    if ($field != 'id_order_detail' &&
                            $field != 'product_name' &&
                            $field != 'product_id' &&
                            $field != 'product_attribute_id' &&
                            $field != 'product_quantity' &&
                            $field != 'product_price' &&
                            $field != 'total_price_tax_incl' &&
                            $field != 'total_price_tax_excl') {
                        unset($products[$field]);
                    }
                }

                $product['id'] = (int) $product['id_order_detail'];
                $product['name'] = $product['product_name'];
                $product['sku'] = '';
                $product['product_id'] = (int) $product['product_id'];
                $product['variation_id'] = (int) $product['product_attribute_id'];
                $product['quantity'] = $product['product_quantity'];
                $product['tax_class'] = '';
                $product['price'] = $product['product_price'];
                $product['subtotal'] = $product['total_price_tax_incl'];
                $product['subtotal_tax'] = '';
                $product['total'] = $product['total_price_tax_incl'];
                $product['total_tax'] = $product['total_price_tax_incl'] - $product['total_price_tax_excl'];
                $product['taxes'] = array();
                $product['meta'] = array();
                unset($product['product_name']);
                unset($product['product_id']);
                unset($product['product_attribute_id']);
                unset($product['product_quantity']);
                unset($product['product_price']);
                unset($product['total_price_tax_incl']);
                unset($product['total_price_tax_excl']);
            }
            return $products;
        }

        /**
         * 
         * @param type $billing
         * @see AuthController processSubmitAccount()
         * @return int id_customer
         */
        public function createAccountForGuest($billing)
        {
            Hook::exec('actionBeforeSubmitAccount');
            $guest_email = $billing['email'];

            if (Validate::isEmail($guest_email) && !empty($guest_email)) {
                if (Customer::customerExists($guest_email)) {
                    throw new Exception('An account using this email address has already been registered.');
                }
            }
            // Preparing customer
            $customer = new Customer();
            $customer->lastname = $billing['last_name'];
            $customer->firstname = $billing['first_name'];
            $customer->email = $guest_email;
            $customer->active = 1;
            $customer->is_guest = 1;
            $customer->passwd = md5(time() . _COOKIE_KEY_);
            if (!$customer->add($autodate = true, $null_values = true)) {
                throw new Exception('create Guest Account Failed!');
            }
            return $customer->id;
        }

        public function changeOrderStatus()
        {
            $orderId = $this->request->request['id'];
            $orderState = $this->request->request['status'];
//            $orderInfo = new Order($orderId);
            
            $this->load->model('checkout/order');
            
            $orderInfo = $this->model_checkout_order->getOrder($orderId);
            $paymentMethod = '';

            if ($orderInfo) {
                $paymentMethod = $orderInfo['payment_code'];
                $statusId = 15; /* Processed */

                $this->model_checkout_order->addOrderHistory($orderId, $statusId, '');
            }
            
            return $this->getAndFormatOrderByOrderId($orderId);
        }

        public function getListCustomerOrder($customerId)
        {
            $this->load->model('account/customer');
            $this->load->model('account/order');
            $this->load->model('icymobi/setting');
            
            $customerInfo = $this->model_account_customer->getCustomer($customerId);
            
            if (!$customerInfo) {
                throw new Exception('User not found');
            }
            
            $page = isset($this->request->request['page'])?intval($this->request->request['page']):1;
            $perPage = isset($this->request->request['per_page'])?intval($this->request->request['per_page']):1;
            
            $userOrder = $this->model_icymobi_setting->getUserOrders($customerId, $page, $perPage);
            
            $return = array();
            foreach ($userOrder as $order) {
                $return[] = $this->getAndFormatOrderByOrderId($order['order_id']);
            }
            return $return;
        }
        
    }
    