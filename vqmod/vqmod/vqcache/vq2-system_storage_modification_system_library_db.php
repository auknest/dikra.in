<?php
class DB {
	private $adaptor;

                public static $log = array();
                public static $time = 0;
            

	public function __construct($adaptor, $hostname, $username, $password, $database, $port = NULL) {
		$class = 'DB\\' . $adaptor;

		if (class_exists($class)) {
			$this->adaptor = new $class($hostname, $username, $password, $database, $port);

              $query = $this->adaptor->query("SELECT value FROM " . DB_PREFIX . "setting WHERE `code` = 'config' AND `key` = 'config_timezone' ");
            if (!empty($query->row)) {
                $timezone = $query->row['value'];
                date_default_timezone_set($timezone);

                $now = new DateTime();
                $mins = $now->getOffset() / 60;
                $sgn = ($mins < 0 ? -1 : 1);
                $mins = abs($mins);
                $hrs = floor($mins / 60);
                $mins -= $hrs * 60;
                $offset = sprintf('%+d:%02d', $hrs * $sgn, $mins);
                $this->adaptor->query("SET time_zone='" . $offset . "'");
            }
            
		} else {
			throw new \Exception('Error: Could not load database adaptor ' . $adaptor . '!');
		}
	}

	public function query($sql, $params = array()) {
		
                $start = microtime(true);

                $backtrace = debug_backtrace();

                $file = (isset($backtrace[1]['file']) ? $backtrace[1]['file'] : $backtrace[0]['file']) . ': ' . (isset($backtrace[1]['line']) ? $backtrace[1]['line'] : $backtrace[0]['line']);

                $file = str_replace(realpath(DIR_SYSTEM . '..') . '/', '', $file);

                $query = $this->adaptor->query($sql, $params);

                $end = microtime(true);

                $time = $end - $start;

                //static::$log[] = sprintf("%3.1f @ %s - %s", $time, $file, $sql);

                static::$log[] = array(
                    'time' => sprintf("%.6f", $time),
                    'file' => $file,
                    'sql' => $sql
                );

                static::$time += $time;

                return $query;
            
	}

	public function escape($value) {
		return $this->adaptor->escape($value);
	}

	public function countAffected() {
		return $this->adaptor->countAffected();
	}

	public function getLastId() {
		return $this->adaptor->getLastId();
	}
	
	public function connected() {
		return $this->adaptor->connected();
	}
}