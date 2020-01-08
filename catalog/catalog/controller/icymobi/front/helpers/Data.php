<?php
/**
 * Copyright © 2016 Inspius. All rights reserved.
 * Author: Phong Nguyen
 * Author URI: http://inspius.com
 */

class IcymobiData
{
    protected $_data;

    public function __construct()
    {
        $this->_data = array();
    }

    public function addElement($name, $value)
    {
        if ($name) {
            $this->_data[$name] = $value ? $value : '';
        }
    }

    public function addElements($data = array())
    {
        foreach ($data as $name => $value) {
            $this->addElement($name, $value);
        }
    }

    public function removeElement($name)
    {
        if (isset($this->_data[$name])) unset($this->_data[$name]);
    }

    public function getData()
    {
        return $this->_data;
    }
}