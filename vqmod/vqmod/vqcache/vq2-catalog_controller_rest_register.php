<?php

/**
 * register.php
 *
 * Registration management
 *
 * @author     Opencart-api.com
 * @copyright  2017
 * @license    License.txt
 * @version    2.0
 * @link       https://opencart-api.com/product/shopping-cart-rest-api/
 * @documentations https://opencart-api.com/opencart-rest-api-documentations/
 */
require_once(DIR_SYSTEM . 'engine/restcontroller.php');

class ControllerRestRegister extends RestController {

    public function register() {

        $this->checkPlugin();

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            //add customer
            $post = $this->getPost();
            $this->registerCustomer($post);
        } else {
            $this->statusCode = 405;
            $this->allowedHeaders = array("POST");
        }

        return $this->sendResponse();
    }


                  public function get_otp() {
        $this->checkPlugin();
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            //add customer
            $post = $this->getPost();
            if (isset($post['telephone']) && $post['telephone']) {
                $otp = rand(000000, 999999);
                $message = "Your OTP for Dikra Shopping Application is $otp";
                send_sms($message, $post['telephone']);
                $this->json['status'] = TRUE;
               // $this->json['otp'] = $otp;
                $this->session->data['otp_' . $post['telephone']] = $otp;
            } else {
                $this->statusCode = 400;
           $this->allowedHeaders = array("POST");  
            }
        } else {
            $this->statusCode = 405;
            $this->allowedHeaders = array("POST");
        }


        return $this->sendResponse();
    }
			
    public function registerCustomer($data) {

        $this->language->load('checkout/checkout');
        $this->language->load('checkout/cart');
        $this->load->model('account/customer');


        // Validate if customer is logged in.
        if ($this->customer->isLogged()) {
            $this->json['error'][] = "User is logged.";
            $this->statusCode = 400;
        } else {

            // Validate minimum quantity requirments.
            $products = $this->cart->getProducts();

            foreach ($products as $product) {
                $product_total = 0;

                foreach ($products as $product_2) {
                    if ($product_2['product_id'] == $product['product_id']) {
                        $product_total += $product_2['quantity'];
                    }
                }

                if ($product['minimum'] > $product_total) {
                    $this->json['error'][] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
                    break;
                }
            }

            if (empty($this->json['error'])) {
                if (!isset($data['firstname']) || (utf8_strlen(trim($data['firstname'])) < 1) || (utf8_strlen(trim($data['firstname'])) > 32)) {
                    $this->json['error'][] = $this->language->get('error_firstname');
                }

                if (!isset($data['lastname']) || (utf8_strlen(trim($data['lastname'])) < 1) || (utf8_strlen(trim($data['lastname'])) > 32)) {
                    $this->json['error'][] = $this->language->get('error_lastname');
                }

                if (!isset($data['email']) || (utf8_strlen($data['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $data['email'])) {
                    $this->json['error'][] = $this->language->get('error_email');
                } else {
                    if ($this->model_account_customer->getTotalCustomersByEmail($data['email'])) {
                        $this->json['error'][] = $this->language->get('error_exists');
                    }
                }


              if (!isset($data['telephone']) || (utf8_strlen($data['telephone']) < 3) || (utf8_strlen($data['telephone']) > 32)) {
                    $this->json['error'][] = $this->language->get('error_telephone');
                }
                if ($this->model_account_customer->getTotalCustomersByTelephone($data['telephone'])) {
                    $this->json['error']['telephone'] = "Warning: Number  is already registered!";
                } else {
                    if (!isset($this->session->data['otp_' . $data['telephone']])) {
                        $this->json['error']['telephone'] = 'Verify Mobile Number';
                    }
                    if (!isset($data['telephone_otp'])) {
                        $this->json['error']['telephone_otp'] = 'Please Enter OTP';
                    }
                    if (isset($this->session->data['otp_' . $data['telephone']]) && $data['telephone'] && isset($data['telephone_otp']) && trim($data['telephone_otp']) != $this->session->data['otp_' . $data['telephone']]) {
                        $this->json['error']['telephone_otp'] = 'Invalid OTP...! Please Try Again';
                    }
                }
	
                if (!isset($data['telephone']) || (utf8_strlen($data['telephone']) < 3) || (utf8_strlen($data['telephone']) > 32)) {
                    $this->json['error'][] = $this->language->get('error_telephone');
                }

                if (!isset($data['address_1']) || (utf8_strlen(trim($data['address_1'])) < 3) || (utf8_strlen(trim($data['address_1'])) > 128)) {
                    
                // $this->json['error'][] = $this->language->get('error_address_1');
			
                }

                if (!isset($data['city']) || (utf8_strlen(trim($data['city'])) < 2) || (utf8_strlen(trim($data['city'])) > 128)) {
                    
                // 
                // 
                // $this->json['error'][] = $this->language->get('error_city');
			
			
			
                }

                
                /* if (isset($data['country_id'])) {
			
                    $this->load->model('localisation/country');
                    $country_info = $this->model_localisation_country->getCountry($data['country_id']);

                    if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($data['postcode'])) < 2 || utf8_strlen(trim($data['postcode'])) > 10)) {
                        $this->json['error'][] = $this->language->get('error_postcode');
                    }

                    if ($data['country_id'] == '') {
                        $this->json['error'][] = $this->language->get('error_country');
                    }
                } else {
                    $this->json['error'][] = $this->language->get('error_country');
                }

                if (!isset($data['zone_id']) || $data['zone_id'] == '') {
                    $this->json['error'][] = $this->language->get('error_zone');
                }


                */ 
			
                if (!isset($data['password']) || (utf8_strlen($data['password']) < 4) || (utf8_strlen($data['password']) > 20)) {
                    $this->json['error'][] = $this->language->get('error_password');
                }

                if (!isset($data['confirm']) || $data['confirm'] != $data['password']) {
                    $this->json['error'][] = $this->language->get('error_confirm');
                }

                if ($this->config->get('config_account_id')) {
                    $this->load->model('catalog/information');

                    $information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));

                    if ($information_info && (!isset($data['agree']) || empty($data['agree']))) {
                        $this->json['error'][] = sprintf($this->language->get('error_agree'), $information_info['title']);
                    }
                }

                // Customer Group
                if (isset($data['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($data['customer_group_id'], $this->config->get('config_customer_group_display'))) {
                    $customer_group_id = $data['customer_group_id'];
                } else {
                    $customer_group_id = $this->config->get('config_customer_group_id');
                }

                // Custom field validation
                $this->load->model('account/custom_field');

                $custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);

                foreach ($custom_fields as $custom_field) {
                    if ($this->opencartVersion < 2300) {
                        if ($custom_field['required'] && empty($data['custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {
                            $this->json['error'][] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
                        }
                    } else {
                        if (($custom_field['location'] == 'address') && $custom_field['required'] && empty($data['custom_field'][$custom_field['custom_field_id']])) {
                            $this->json['error'][] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
                        } elseif (($custom_field['location'] == 'address') && ($custom_field['type'] == 'text') && !empty($custom_field['validation']) && !filter_var($data['custom_field'][$custom_field['custom_field_id']], FILTER_VALIDATE_REGEXP, array('options' => array('regexp' => $custom_field['validation'])))) {
                            $this->json['error'][] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
                        }
                    }
                }
            }

            if (empty($this->json['error'])) {

                 $data["address_1"] = ""; 
                 $data["address_2"] = ""; 
                 $data["city"] = ""; 
                 $data["postcode"] = ""; 
                 $data["country_id"] = ""; 
                 $data["zone_id"] = ""; 
			
                if (!isset($data['fax'])) {
                    $data["fax"] = "";
                }

                if (!isset($data['company_id'])) {
                    $data["company_id"] = "";
                }

                if (!isset($data['company'])) {
                    $data["company"] = "";
                }

                if (!isset($data['tax_id'])) {
                    $data["tax_id"] = 1;
                }

                $customer_id = $this->model_account_customer->addCustomer($data);

                $this->session->data['account'] = 'register';

                $this->load->model('account/customer_group');

                $customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);

                if ($customer_group_info && !$customer_group_info['approval']) {
                    $this->customer->login($data['email'], $data['password']);
                    $data['customer_id'] = $customer_id;
                    $data['address_id'] = $this->customer->getAddressId();

                    unset($data['password']);
                    unset($data['confirm']);
                    unset($data['agree']);

                    $this->json['data'] = $data;

                    // Default Payment Address
                    $this->load->model('account/address');

                    $this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());

                    if (!empty($data['shipping_address'])) {
                        $this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
                    }
                }

                unset($this->session->data['guest']);
                unset($this->session->data['shipping_method']);
                unset($this->session->data['shipping_methods']);
                unset($this->session->data['payment_method']);
                unset($this->session->data['payment_methods']);
            }
        }
    }

}
    