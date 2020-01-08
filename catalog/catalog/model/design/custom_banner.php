<?php

/**
 * Description of custom_banner
 * 
 * @author leometric
 * 
 * developed by V2
 * Copyright 2018 Leometric Technology. All Rights Reserved.
 */
class ModelDesignCustomBanner extends Model{

    public function editBanner($data) {
        if (isset($data['banner_image'])) {
         $this->db->query("DELETE FROM " . DB_PREFIX . "custom_banner");
            foreach ($data['banner_image'] as $language_id => $value) {
                foreach ($value as $banner_image) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "custom_banner SET language_id = '" . (int) $language_id . "', title = '" . $this->db->escape($banner_image['title']) . "', link = '" . $this->db->escape($banner_image['link']) . "', image = '" . $this->db->escape($banner_image['image']) . "', sort_order = '" . (int) $banner_image['sort_order'] . "'");
                }
            }
        }
    }



    public function getBannerImages() {
        $banner_image_data = array();

        $banner_image_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "custom_banner  ORDER BY sort_order ASC");

        foreach ($banner_image_query->rows as $banner_image) {
            $banner_image_data[] = array(
                'id' => $banner_image['banner_image_id'],
                'title' => $banner_image['title'],
                'link' => $banner_image['link'],
                'image' => $banner_image['image'],
                'sort_order' => $banner_image['sort_order']
            );
        }

        return $banner_image_data;
    }


}
