<?php
/**
 * Copyright © 2016 Inspius. All rights reserved.
 * Author: Phong Nguyen
 * Author URI: http://inspius.com
 */

class IcymobiSetting
{
    protected $_settings;

    public function __construct()
    {
        $this->_settings = array();
    }

    public function addElement($name, $value)
    {
        if ($name) {
            $this->_settings[$name] = $value ? $value : '';
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
        if (isset($this->_settings[$name])) unset($this->_settings[$name]);
    }

    public function getSettings()
    {
        return $this->_settings;
    }
}