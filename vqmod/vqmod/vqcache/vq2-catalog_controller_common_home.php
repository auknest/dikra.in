<?php
class ControllerCommonHome extends Controller {
	public function index() {

                if ($this->request->server['HTTPS']) {
			$img_url=$this->config->get('config_ssl') . 'image/' ;
		} else {
			$img_url=$this->config->get('config_url') . 'image/' ;
		}
                  $this->load->model('design/custom_banner');
               $banner_images = $this->model_design_custom_banner->getBannerImages();
         $data['banner_images'] = array();
                $this->load->model('tool/image');
        foreach ($banner_images as  $banner_image) {
                if (is_file(DIR_IMAGE . $banner_image['image'])) {
                    $image = $banner_image['image'];
                    $thumb = $banner_image['image'];
                } else {
                    $image = '';
                    $thumb = 'no_image.png';
                }

                $data['banner_images'][] = array(
                    'title' => $banner_image['title'],
                    'link' => $banner_image['link'],
                    'image' => $img_url.$image,
                    'sort_order' => $banner_image['sort_order']
                );
            }
               
                

		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));

		if (isset($this->request->get['route'])) {
			$this->document->addLink($this->config->get('config_url'), 'canonical');
		}

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('common/home', $data));
	}
}
