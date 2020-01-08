<?php echo $header; ?>
<ul class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
  <?php } ?>
</ul>
<?php if ($j3->settings->get('pageTitlePosition') === 'top'): ?>
  <h1 class="title page-title"><span><?php echo $heading_title; ?></span></h1>
<?php endif; ?>
<?php echo $j3->loadController('journal3/layout', 'top'); ?>
<div class="container">
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <div id="content">
      <?php if ($j3->settings->get('pageTitlePosition') === 'default'): ?>
        <h1 class="title page-title"><?php echo $heading_title; ?></h1>
      <?php endif; ?>
      <?php echo $content_top; ?>
      <div class="quick-checkout-wrapper">
        <div class="quick-checkout">
          <div class="journal-loading"><i class="fa fa-spinner fa-spin"></i></div>
        </div>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/html" id="quick-checkout">
  <div v-bind:class="[(account === '') && !customer_id ? 'login-active' : '']">
    <div class="left">
      <form>
      <?php echo $login_block; ?>

      <?php echo $register_block; ?>

      <?php echo $payment_address_block; ?>

      <?php echo $shipping_address_block; ?>
      </form>
    </div>

    <div class="right">

      <div class="checkout-section shipping-payment">
        <?php echo $shipping_method_block; ?>

        <?php echo $payment_method_block; ?>
      </div>

      <?php echo $coupon_voucher_reward_block; ?>

      <?php echo $cart_block; ?>

      <div class="checkout-section checkout-payment-details" v-bind:class="[order_data.payment_method ? 'payment-' + order_data.payment_code : '']">
        <div class="title section-title"><?php echo $j3->settings->get('sectionTitlePaymentDetails'); ?></div>
        <div class="quick-checkout-payment">
          <div class="journal-loading-overlay">
            <div class="journal-loading"><i class="fa fa-spinner fa-spin"></i></div>
          </div>
        </div>
      </div>

      <?php echo $confirm_block; ?>
    </div>

  </div>
</script>
<script>window['_QuickCheckoutData'] = <?php echo json_encode($checkout_data); ?>;</script>
<?php echo $footer; ?>
