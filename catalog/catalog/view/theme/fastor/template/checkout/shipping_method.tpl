
<?php if ($error_warning) {
    ?>
    <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods) { ?>
    <p><?php echo $text_shipping_method; ?></p>
    <?php
    $m_key = NULL;
    foreach ($shipping_methods as $shipping_method) {
        foreach ($shipping_method['quote'] as $quote_key => $quote) {
            if ($quote['code'] == $code || !$code) {
                $m_key = $quote_key;
            }
        }
        ?>

        <?php if (!$shipping_method['error']) { ?>

            <?php foreach ($shipping_method['quote'] as $nct_key => $quote) { ?>
                <?php if ($m_key == $nct_key) { ?>          
                    <p><strong><?php echo $shipping_method['title']; ?></strong></p>
                    <div class="radio">
                        <label>

                            <?php if ($quote['code'] == $code || !$code) { ?>
                                <?php
                                $code = $quote['code'];
                                ?>
                            <input type="radio" class="hidden" name="shipping_method" value="<?php echo $quote['code']; ?>" checked="checked" />
                            <?php } else { ?>
                                <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" />
                            <?php } ?>
                            <?php echo $quote['title']; ?> - <?php echo $quote['text']; ?></label>
                    </div>
                <?php } ?>
            <?php } ?>
        <?php } else { ?>
            <div class="alert alert-danger"><?php echo $shipping_method['error']; ?></div>
        <?php } ?>
    <?php } ?>
<?php } ?>
<p style="padding-top: 15px"><strong><?php echo $text_comments; ?></strong></p>
<p>
    <textarea name="comment" rows="8" class="form-control"><?php echo $comment; ?></textarea>
</p>
<div class="buttons">
    <div class="pull-right">
        <input type="button" value="<?php echo $button_continue; ?>" id="button-shipping-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
    </div>
</div>
