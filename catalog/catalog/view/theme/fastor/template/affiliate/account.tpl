<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); 
include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_top.tpl'); ?>

<h2><?php echo $text_my_account; ?></h2>
<ul class="list-unstyled">
  <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
  <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
  <li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
</ul>
<h2><?php echo $text_my_tracking; ?></h2>
<ul class="list-unstyled">
  <li><a href="<?php echo $tracking; ?>"><?php echo $text_tracking; ?></a></li>
</ul>
<h2><?php echo $text_my_transactions; ?></h2>
<ul class="list-unstyled">
  <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
</ul>
  
<?php include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_bottom.tpl'); ?>
<?php echo $footer; ?>