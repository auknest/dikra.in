<div class="col-md-8">  
    <div class="table-responsive table1">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th colspan="7" class="text-center"><i class="fa fa-shopping-cart" aria-hidden="true"></i>  Cart</th>

                </tr>
            </thead>
            <thead>
                <tr>
                    <td class="text-center"><?php echo $column_image; ?></td>
                    <td class="text-center hidden-xs"><?php echo $column_name; ?></td>
                    <td class="text-center"><?php echo $column_quantity; ?></td>
                    <td class="text-center hidden-xs"><?php echo $column_price; ?></td>
                    <td class="text-center"><?php echo $column_total; ?></td>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($products as $product) { ?>
                <tr>
                    <td class="text-center"><?php if ($product['thumb']) { ?>
                        <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
                        <?php } ?>
                        <div class="visible-xs"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?><div>
                                    </td>
                                    <td class="text-center hidden-xs"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                        <?php if (!$product['stock']) { ?>
                                        <span class="text-danger">***</span>
                                        <?php } ?>
                                        <?php if ($product['option']) { ?>
                                        <?php foreach ($product['option'] as $option) { ?>
                                        <br />
                                        <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                        <?php } ?>
                                        <?php } ?>
                                        <?php if ($product['reward']) { ?>
                                        <br />
                                        <small><?php echo $product['reward']; ?></small>
                                        <?php } ?>
                                        <?php if ($product['recurring']) { ?>
                                        <br />
                                        <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
                                        <?php } ?></td>
                                    <!--  <td class="text-center hidden-xs"><?php echo $product['model']; ?></td>-->
                                    <td class="text-center bold">
                                        <?php echo $product['quantity']; ?>

                                    </td>
                                    <td class="text-center hidden-xs"><?php echo $product['price']; ?></td>
                                    <td class="text-center"><?php echo $product['total']; ?></td>
                                    </tr>
                                    <?php } ?>
                                    <?php foreach ($vouchers as $voucher) { ?>
                                    <tr>
                                        <td></td>
                                        <td class="text-left"><?php echo $voucher['description']; ?></td>
                                        <td class="text-left"></td>
                                        <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                                                <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                                                <span class="input-group-btn">
                                                    <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="voucher.remove('<?php echo $voucher['key']; ?>');"><i class="fa fa-times-circle"></i></button>
                                                </span></div></td>
                                        <td class="text-right"><?php echo $voucher['amount']; ?></td>
                                        <td class="text-right"><?php echo $voucher['amount']; ?></td>
                                    </tr>
                                    <?php } ?>
                                    </tbody>

                                    </table>
                                </div>
                                <div class="col-md-12 " id="coupon_details">
                                    <label class="col-sm-2 control-label" for="input-coupon">Enter your coupon here</label>
                                    <div class="input-group">
                                        <input type="text" name="coupon" value="<?php echo $coupon; ?>" placeholder="Enter your coupon here" id="input-coupon" class="form-control" />
                                        <span class="input-group-btn">
                                            <input type="button" value="Apply Coupon" id="button-coupon" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-primary" />
                                        </span></div>
                                </div>
                        </div>
                        <div class="col-md-4" id="cart_total">
                            <div class="table-responsive table1">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th colspan="2"  class="text-center">Total</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($totals as $total) { ?>
                                        <tr>
                                            <td  class="text-right"><strong><?php echo $total['title']; ?>:</strong></td>
                                            <td class="text-right"><?php echo $total['text']; ?></td>
                                        </tr>
                                        <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <script type="text/javascript"><!--
$('#button-coupon').on('click', function () {
                                $.ajax({
                                    url: 'index.php?route=extension/total/coupon/coupon',
                                    type: 'post',
                                    data: 'coupon=' + encodeURIComponent($('input[name=\'coupon\']').val()),
                                    dataType: 'json',
                                    beforeSend: function () {
                                        $('#button-coupon').button('loading');
                                    },
                                    complete: function () {
                                        $('#button-coupon').button('reset');
                                    },
                                    success: function (json) {
                                        $('.alert').remove();
                                        if (json['error']) {
                                            $('.center-column > *:first-child').before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                                            $('html, body').animate({scrollTop: 0}, 'slow');
                                        }

                                        if (json['redirect']) {
                                            loadcart();
                                        }
                                    }
                                });
                            });
//--></script>