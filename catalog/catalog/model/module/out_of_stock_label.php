<?php

class ModelModuleOutOfStockLabel extends Model {

    public function getLabel($language_id) {
        $q = $this->db->query("SELECT label FROM `" . DB_PREFIX . "out_of_stock_label` WHERE language_id = $language_id");
        return $q->row['label'];
    }
    
    public function getQuantity($data){
        
        
        if (isset($data['has_option']) && $data['has_option'] == 1){
            $product_id = $data['product_id'];
            $q = $this->db->query("SELECT stock FROM `" . DB_PREFIX . "product_option_variant` WHERE product_id = $product_id AND active = 1");
            $stock = 0;
            foreach ($q->rows as $row) {
                $stock += (int)$row['stock'];
            }
            return $stock;
        }else{
            return $data['quantity'];
        }
        
        
    }

}
