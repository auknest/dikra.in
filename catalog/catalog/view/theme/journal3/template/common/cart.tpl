<?php if ($j3->settings->get('catalogMiniCartStatus')): ?>
<div id="cart" class="dropdown">
  <a data-toggle="dropdown" data-loading-text="<?php echo $text_loading; ?>" class="dropdown-toggle cart-heading" <?php if ($j3->settings->get('cartStyleCartCheckoutLink')): ?>href="<?php echo $cart; ?>"<?php endif; ?>>
    <?php if ($j3->settings->get('cartStyleCartCustomText') == 'default'): ?>
    <span id="cart-total"><?php echo $text_items; ?></span>
    <?php endif; ?>
    <span id="cart-items" class="count-badge"><?php echo $items_count; ?></span>
    <i class="fa fa-shopping-cart">
      <?php if ($j3->settings->get('cartStyleCartCustomText') == 'custom'): ?>
        <span class="cart-label"><?php echo $j3->settings->get('cartStyleCartLabel'); ?></span>
      <?php endif; ?>
    </i>
  </a>
  <div id="cart-content" class="dropdown-menu cart-content j-dropdown">
    <ul>
    <?php if ($products || $vouchers) { ?>
    <li class="cart-products">
      <table class="table">
        <?php foreach ($products as $product) { ?>
        <tr>
          <td class="text-center td-image"><?php if ($product['thumb']) { ?>
            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>"/></a>
            <?php } ?></td>
          <td class="text-left td-name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a><br />
            <?php if ($product['option']) { ?>
            <?php foreach ($product['option'] as $option) { ?>
            <span><?php echo $option['name']; ?></span><small> <?php echo $option['value']; ?></small><br />
            <?php } ?>
            <?php } ?>
            <?php if ($product['recurring']) { ?>
            <span><?php echo $text_recurring; ?></span><small> <?php echo $product['recurring']; ?></small>
            <?php } ?></td>
          <td class="text-right td-qty">x <?php echo $product['quantity']; ?></td>
          <td class="text-right td-total"><?php echo $product['total']; ?></td>
          <td class="text-center td-remove"><button type="button" onclick="cart.remove('<?php echo $product['cart_id']; ?>');" title="<?php echo $button_remove; ?>" class="cart-remove"><i class="fa fa-times-circle"></i></button></td>
        </tr>
        <?php } ?>
        <?php foreach ($vouchers as $voucher) { ?>
        <tr>
          <td class="text-center"></td>
          <td class="text-left"><?php echo $voucher['description']; ?></td>
          <td class="text-right">x&nbsp;1</td>
          <td class="text-right"><?php echo $voucher['amount']; ?></td>
          <td class="text-center text-danger"><button type="button" onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td>
        </tr>
        <?php } ?>
      </table>
    </li>
    <li class="cart-totals">
      <div>
        <table class="table table-bordered">
          <?php foreach ($totals as $total) { ?>
          <tr>
            <td class="text-right td-total-title"><?php echo $total['title']; ?></td>
            <td class="text-right td-total-text"><?php echo $total['text']; ?></td>
          </tr>
          <?php } ?>
        </table>
        <div class="cart-buttons">
          <a class="btn-cart btn" href="<?php echo $cart; ?>"><i class="fa"></i><span><?php echo $text_cart; ?></span></a>
          <a class="btn-checkout btn" href="<?php echo $checkout; ?>"><i class="fa"></i><span><?php echo $text_checkout; ?></span></a>
        </div>
      </div>
    </li>
    <?php } else { ?>
    <li>
      <p class="text-center cart-empty"><?php echo $text_empty; ?></p>
    </li>
    <?php } ?>
    </ul>
  </div>
</div>
<?php endif; ?>
