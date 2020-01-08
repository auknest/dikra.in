<?php

/**
 * Description of notifications
 * 
 * @author leometric
 * 
 * developed by V2
 * Copyright 2018 Leometric Technology. All Rights Reserved.
 */
class ModelAccountNotifications extends Model {

    public function get_notifications($data = [], $param = []) {
        $implode = array();
        $sql = "SELECT * FROM " . DB_PREFIX . "notifications";
        if (!empty($data['customer_id'])) {
            $implode[] = " FIND_IN_SET('" . $data['customer_id'] . "', customers)";
        }
        if ($implode) {
            $sql .= " WHERE " . implode(" AND ", $implode);
        }
        
        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function get_notifications_total($data = []) {
        $sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "notifications";

        $implode = array();
//
        if (!empty($data['customer_id'])) {
            $implode[] = " FIND_IN_SET('" . $data['customer_id'] . "', customers)";
        }
//		if (!empty($data['filter_name'])) {
//			$implode[] = "name LIKE '" . $this->db->escape($data['filter_name']) . "'";
//		}
//
//		if (!empty($data['filter_code'])) {
//			$implode[] = "code = '" . $this->db->escape($data['filter_code']) . "'";
//		}
//
//		if (!empty($data['filter_date_added'])) {
//			$implode[] = "DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
//		}
//
        if ($implode) {
            $sql .= " WHERE " . implode(" AND ", $implode);
        }

        $query = $this->db->query($sql);
        return ($query->row) ? $query->row['total'] : 0;
    }

    public function get_notification($notification_id) {
        $query = $this->db->query("SELECT  * FROM " . DB_PREFIX . "notifications WHERE notification_id = '" . (int) $notification_id . "'");

        return $query->row;
    }

    public function add_notification($data) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "notifications SET customers = '" . $this->db->escape($data['customers']) . "', title = '" . $this->db->escape($data['title']) . "', description = '" . $this->db->escape($data['description']) . "', image = '" . $this->db->escape($data['image']) . "', date_added = NOW()");

        return $this->db->getLastId();
    }

    public function update_notification($data, $notification_id) {
        $this->db->query("UPDATE " . DB_PREFIX . "marketing SET customers = '" . $this->db->escape($data['customers']) . "', title = '" . $this->db->escape($data['title']) . "', description = '" . $this->db->escape($data['description']) . "', image = '" . $this->db->escape($data['image']) . "', WHERE notification_id = '" . (int) $notification_id . "'");
    }

    public function delete_notification($notification_id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "notifications WHERE notification_id = '" . (int) $notification_id . "'");
    }

    public function push_notification($id, $msg = []) {
        $msg['description'] = $msg['body'];
        $api_key = $this->config->get('config_google_fcm_key');
        $fields = array
            (
            'to' => $id,
            //            'notification' => $msg,
            'data' => $msg,
        );
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => "https://fcm.googleapis.com/fcm/send",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => json_encode($fields),
            CURLOPT_HTTPHEADER => array(
                "authorization: key=$api_key",
                "cache-control: no-cache",
                "content-type: application/json",
            ),
        ));

        $response = curl_exec($curl);
        $err = curl_error($curl);

        curl_close($curl);
    }

}
