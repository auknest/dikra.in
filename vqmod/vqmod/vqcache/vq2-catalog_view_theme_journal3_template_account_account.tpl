<?php echo $header; ?>
<ul class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
  <?php } ?>
</ul>
<?php if ($j3->settings->get('pageTitlePosition') === 'top'): ?>
  
                <style>
                
                .title-divider-bottom {
    display: block;
    height: 3px;
    background: #db8fb3;
    margin-top: 15px;
    margin-bottom: 15px;
    margin-left: auto;
    margin-right: 36%;
}
                .title-divider-top {
    display: block;
    height: 3px;
    background: #db8fb3;
    margin-top: 15px;
    margin-bottom: 15px;
    margin-left: 36%;
    margin-right: auto;
}
                .refine-categories,.category-description,.products-filter{
display:none;              
  }
                .title-wrapper-top {
    margin: unset;
    text-align: center;
                    padding-left: 20px;
                    padding-right: 20px;
}
                </style>
                <div class="title-wrapper-top">
      <div class="title-divider-top"></div>
    <h3><?php echo $heading_title; ?></h3>
    <div class="title-divider"></div>
    <div class="title-divider-bottom"></div>
  </div>			

<?php endif; ?>
<?php echo $j3->loadController('journal3/layout', 'top'); ?>
<div id="account-account" class="container">
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="account-page <?php echo $class; ?>">
      <?php if ($j3->settings->get('pageTitlePosition') === 'default'): ?>
        <h1 class="title page-title"><?php echo $heading_title; ?></h1>
      <?php endif; ?>
      <?php echo $content_top; ?>
      <div class="my-account">
        <h2 class="title"><?php echo $text_my_account; ?></h2>
        <ul class="list-unstyled account-list">
          <li class="edit-info"><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
          <li class="edit-pass"><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
          <li class="edit-address"><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
          <li class="edit-wishlist"><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
        </ul>
      </div>
      <?php if ($credit_cards): ?>
      <div class="my-cards">
        <h2 class="title"><?php echo $text_credit_card; ?></h2>
        <ul class="list-unstyled account-list">
          <?php foreach ($credit_cards as $credit_card) { ?>
          <li><a href="<?php echo $credit_card['href']; ?>"><?php echo $credit_card['name']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
      <?php endif; ?>
        <div class="my-orders">
        <h2 class="title"><?php echo $text_my_orders; ?></h2>
        <ul class="list-unstyled account-list">
          <li class="edit-order"><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li class="edit-downloads"><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
          <?php if ($reward) { ?>
          <li class="edit-rewards"><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
          <?php } ?>
          <li class="edit-returns"><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li class="edit-transactions"><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
          <li class="edit-recurring"><a href="<?php echo $recurring; ?>"><?php echo $text_recurring; ?></a></li>
        </ul>
      </div>
      <div class="my-newsletter">
        <h2 class="title"><?php echo $text_my_newsletter; ?></h2>
        <ul class="list-unstyled account-list">
          <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
        </ul>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
