<?php

    /**
     * Copyright © 2016 Inspius. All rights reserved.
     * Author: Khanh Tran
     * Author URI: http://inspius.com
     */
    require_once("api.php");

    class ControllerIcymobiFrontSettings extends ControllerIcymobiFrontApi
    {

        protected function _getResponse()
        {
            $device_token = NULL;
            if(isset($this->request->request['token'])) {
                $device_token = $this->request->request['token'];
            }
            $this->updateDeviceToken($device_token);
            
            $samplePriceHtml = $this->currency->format(10000,$this->config->get('config_currency'));
            preg_match("/(\d){2}([,.']){1}(\d){3}([,.']){1}(\d){2}/", $samplePriceHtml, $match);
            $samplePrice = $match[0];
            $decimal_separator = $match[4];
            $thousand_separator = $match[2];
          
// sliders
            $this->load->model('catalog/product');
        $this->load->model('extension/module');
        $this->load->model('design/banner');
        $this->load->model('tool/image');
            $slideshows = $this->model_catalog_product->getModulesByCode('slideshow');
        $banners = array();
        $index = 0;

        if (count($slideshows)) {
            foreach ($slideshows as $slideshow) {
                $module_info = $this->model_extension_module->getModule($slideshow['module_id']);
               $results = $this->model_design_banner->getBanner($module_info['banner_id']);
                if(!empty($results) &&  $module_info['status']==1) {
                    foreach ($results as $result) {
                                            if (is_file(DIR_IMAGE . $result['image'])) {

                            $banners[]['src'] =  $this->model_tool_image->resize($result['image'], $module_info['width'], $module_info['height']);
                            
                        }
                    }

                }

                $index++;
            }
        }
       // print_r($banners);
// sliders
     
            $data = array(
                "thousand_separator"  => $thousand_separator,
                "decimal_separator"   => $decimal_separator,
                "number_decimals"     => 2,
                "samplePrice"         => $samplePrice,
                "samplePriceHtml"     => $samplePriceHtml,
                "contact_map_lat"     => $this->config->get('icymobi_contact_map_lat'),
                "contact_map_lng"     => $this->config->get('icymobi_contact_map_lng'),
                "contact_map_title"   => $this->config->get('icymobi_contact_title'),
                "contact_map_content" => $this->config->get('icymobi_contact_content'),
                "disable_app"         => $this->config->get('icymobi_maintenance_mode_value'),
                "disable_app_message" => $this->config->get('icymobi_maintenance_mode_text_value'),
                "category_display"    => $this->config->get('icymobi_category_page_display_value'),
                "contact_email"       => $this->config->get('icymobi_contact_email'),
                "contact_phone"       => $this->config->get('icymobi_contact_phone'),
                "blog_display"        => 'posts',
                "enableSliderFromServer"=>true,
                'slider'=>$banners,
            );
            
            $result = $this->event->trigger('model/checkout/order/addOrderHistory/after', array('settings', &$data));
             
            if($result !== null){
                $data = $result;
            }
            return $data;
        }
        
        public function updateDeviceToken($device_token)
        {
            if ($device_token != null) {
                $this->load->model('icymobi/setting');
                
                $rawDeviceToken = $this->config->get('icymobi_device_token');
                $arrayDeviceToken = json_decode($rawDeviceToken);

                if (empty($arrayDeviceToken)) {
                    $arrayDeviceToken = array ();
                }
                if (!in_array($device_token, $arrayDeviceToken)) {
                    $arrayDeviceToken[] = $device_token;
                }
                $this->model_icymobi_setting->editSetting('icymobi_device', array('icymobi_device_token' => json_encode($arrayDeviceToken)));
            }
        }

    }