<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); 
include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_top.tpl'); ?>

<h1><?php echo $heading_title; ?></h1>
<p><?php echo $text_account_verified; ?></p>
<p><a class="btn btn-primary" href="<?php echo $login; ?>"><?php echo 'Login'; ?></a></p>

<?php include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_bottom.tpl'); ?>
<?php echo $footer; ?>