<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of pincode
 * 
 * @author leometric
 * 
 * developed by V2
 * Copyright 2018 Leometric Technology. All Rights Reserved.
 */
class ModelCatalogPincode extends Model{

    public function getPin($pincode = NULL) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "serviceable_pincodes WHERE pincode = '" . (int) $pincode . "' AND service='Express'");
        return $query->row;
    }

}
