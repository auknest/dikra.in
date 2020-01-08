<?php echo $header; ?>
<ul class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
  <?php } ?>
</ul>
<?php if ($j3->settings->get('pageTitlePosition') === 'top'): ?>
  <h1 class="title page-title">
    <span ><?php echo $heading_title; ?>
    <?php if ($weight) { ?>
      &nbsp;(<?php echo $weight; ?>)
    <?php } ?>
    </span>
  </h1>
<?php endif; ?>
<?php echo $j3->loadController('journal3/layout', 'top'); ?>
<div id="checkout-cart" class="container">
  <?php if ($attention) { ?>
  <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>">
      <?php if ($j3->settings->get('pageTitlePosition') === 'default'): ?>
      <h1 class="title page-title"><?php echo $heading_title; ?>
        <?php if ($weight) { ?>
        &nbsp;(<?php echo $weight; ?>)
        <?php } ?>
      </h1>
      <?php endif; ?>
      <?php echo $content_top; ?>
<div class="cart-page">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="cart-table">
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <td class="text-center td-image"><?php echo $column_image; ?></td>
                    <td class="text-left td-name"><?php echo $column_name; ?></td>
                    <td class="text-center td-model"><?php echo $column_model; ?></td>
                    <td class="text-center td-qty"><?php echo $column_quantity; ?></td>
                    <td class="text-center td-price"><?php echo $column_price; ?></td>
                    <td class="text-center td-total"><?php echo $column_total; ?></td>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($products as $product) { ?>
                    <tr>
                        <td class="text-center td-image"><?php if ($product['thumb']): ?> <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a> <?php endif; ?></td>
                        <td class="text-left td-name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a> <?php if (!$product['stock']): ?> <span class="text-danger">***</span> <?php endif; ?>
                            <?php if ($product['option']): ?>
                                <?php foreach ($product['option'] as $option): ?> <br />
                                    <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small> <?php endforeach; ?>
                            <?php endif; ?>
                            <?php if ($product['reward']): ?> <br />
                                <small><?php echo $product['reward']; ?></small> <?php endif; ?>
                            <?php if ($product['recurring']): ?> <br />
                                <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small> <?php endif; ?></td>
                        <td class="text-center td-model"><?php echo $product['model']; ?></td>
                        <td class="text-center td-qty">
                            <div class="input-group btn-block">
                                <div class="stepper">
                                    <input type="text" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control" />
                                    <span>
                      <i class="fa fa-angle-up"></i>
                      <i class="fa fa-angle-down"></i>
                    </span>
                                </div>
                                <span class="input-group-btn">
                    <button type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-update"><i class="fa fa-refresh"></i></button>
                    <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-remove" onclick="cart.remove('<?php echo $product['cart_id']; ?>');"><i class="fa fa-times-circle"></i></button>
                  </span>
                            </div>
                        </td>
                        <td class="text-center td-price"><?php echo $product['price']; ?></td>
                        <td class="text-center td-total"><?php echo $product['total']; ?></td>
                    </tr>
                <?php } ?>
                <?php foreach ($vouchers as $voucher) { ?>
                    <tr>
                        <td></td>
                        <td class="text-left td-voucher"><?php echo $voucher['description']; ?></td>
                        <td class="text-left td-voucher"></td>
                        <td class="text-left td-voucher"><div class="input-group btn-block" style="max-width: 200px;">
                                <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                                <span class="input-group-btn">
                    <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="voucher.remove('<?php echo $voucher['key']; ?>');"><i class="fa fa-times-circle"></i></button>
                    </span></div></td>
                        <td class="text-right td-voucher"><?php echo $voucher['amount']; ?></td>
                        <td class="text-right td-voucher"><?php echo $voucher['amount']; ?></td>
                    </tr>
                <?php } ?>
                </tbody>
            </table>
        </div>
    </form>
    <div class="cart-bottom">
        <div class="panels-total">
            <?php if ($modules && $j3->settings->get('cartPanelsStatus')) { ?>
                <div class="cart-panels">
                    <h2 class="title"><?php echo $text_next; ?></h2>
                    <p><?php echo $text_next_choice; ?></p>
                    <div class="panel-group" id="accordion">
                        <?php foreach ($modules as $module) { ?>
                            <?php echo $module; ?>
                        <?php } ?>
                    </div>
                </div>
            <?php } ?>
            <div class="row cart-total">
                <table class="table table-bordered">
                    <?php foreach ($totals as $total) { ?>
                        <tr>
                            <td class="text-right"><strong><?php echo $total['title']; ?>:</strong></td>
                            <td class="text-right"><?php echo $total['text']; ?></td>
                        </tr>
                    <?php } ?>
                </table>
            </div>
        </div>
        <div class="buttons clearfix">
            <div class="pull-left"><a href="<?php echo $continue; ?>" class="btn btn-default"><span><?php echo $button_shopping; ?></span></a></div>
            <div class="pull-right"><a href="<?php echo $checkout; ?>" class="btn btn-primary"><span><?php echo $button_checkout; ?></span></a></div>
        </div>
    </div>
</div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
