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

<style>
                div#bottom {
    display: none;
}
                </style>


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
