<?php $context = get_defined_vars(); ?>
<?php foreach ($products as $product): ?>
  <?php $classes = $j3->classes(array(
    'out-of-stock'     => !$product['quantity'],
    'has-zero-price'   => !$product['price_value'],
  )); ?>
  <div class="product-layout <?php echo $j3->classes($product['classes']); ?> <?php echo $classes; ?>">
    <div class="side-product">
      <div class="image">
        <a href="<?php echo $product['href']; ?>" class="product-img">
          <?php if ($j3->settings->get('performanceLazyLoadImagesStatus')): ?>
            <img src="<?php echo $dummy_image; ?>" data-src="<?php echo $product['thumb']; ?>" <?php if ($product['thumb2x']): ?>data-srcset="<?php echo $product['thumb']; ?> 1x, <?php echo $product['thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-first lazyload"/>
          <?php else: ?>
            <img src="<?php echo $product['thumb']; ?>" <?php if ($product['thumb2x']): ?>srcset="<?php echo $product['thumb']; ?> 1x, <?php echo $product['thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-first"/>
          <?php endif; ?>
        </a>

        <?php if ($j3->settings->get('quickviewStatus')): ?>
          <div class="quickview-button">
            <a class="btn btn-quickview" <?php if ($j3->settings->getIn('SideProductQuickviewTooltipStatus', $context)): ?>data-toggle="tooltip" data-tooltip-class="<?php echo 'module-side_products-' . $module_id; ?> quickview-tooltip" data-placement="<?php echo $j3->settings->getIn('SideProductQuickviewTooltipPosition', $context); ?>" title="<?php echo $j3->settings->get('quickviewText'); ?>"<?php endif; ?> onclick="quickview('<?php echo $product['product_id']; ?>')"><span class="btn-text"><?php echo $j3->settings->get('quickviewText'); ?></span></a>
          </div>
        <?php endif; ?>
      </div>

      <div class="caption">
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>

        <?php if ($product['price']): ?>
          <div class="price">
            <?php if ($product['special']): ?>
              <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
            <?php else: ?>
              <span class="price-normal"><?php echo $product['price']; ?></span>
            <?php endif; ?>
            <?php if ($product['tax']): ?>
              <span class="price-tax"><?php echo $text_tax; ?><?php echo $product['tax']; ?></span>
            <?php endif; ?>
          </div>
        <?php endif; ?>

        <?php if ($product['rating']): ?>
          <div class="rating <?php if ($j3->settings->getIn('SideProductRatingPosition', $context) == "hover"): ?>rating-hover<?php endif; ?>">
            <div class="rating-stars">
              <?php for ($i = 1; $i <= 5; $i++): ?>
                <?php if ($product['rating'] < $i): ?>
                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php else: ?>
                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php endif; ?>
              <?php endfor; ?>
            </div>
          </div>
        <?php else: ?>
          <div class="rating no-rating <?php if ($j3->settings->getIn('SideProductRatingPosition', $context) == "hover"): ?>rating-hover<?php endif; ?>">
            <div class="rating-stars">
              <?php for ($i = 1; $i <= 5; $i++): ?>
                <?php if ($product['rating'] < $i): ?>
                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php else: ?>
                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php endif; ?>
              <?php endfor; ?>
            </div>
          </div>
        <?php endif; ?>

        <?php if ($j3->settings->get('catalogCartStatus') || $j3->settings->get('catalogWishlistStatus') || $j3->settings->get('catalogCompareStatus')): ?>
          <div class="button-group">
            <?php if ($j3->settings->get('catalogCartStatus')): ?>
              <a class="btn btn-cart" <?php if ($j3->settings->getIn('SideProductCartTooltipStatus', $context)): ?> data-toggle="tooltip" data-tooltip-class="<?php echo 'module-side_products-' . $module_id; ?> cart-tooltip" data-placement="<?php echo $j3->settings->getIn('SideProductCartTooltipPosition', $context); ?>" title="<?php echo $button_cart; ?>" <?php endif; ?> onclick="cart.add('<?php echo $product['product_id']; ?>//', $(this).closest('.button-group').find('input[name=\'quantity\']').val());" data-loading-text="<span class='btn-text'><?php echo $button_cart; ?></span>"><span class="btn-text"><?php echo $button_cart; ?></span></a>
            <?php endif; ?>
            <?php if ($j3->settings->get('catalogWishlistStatus')): ?>
              <a class="btn btn-wishlist" <?php if ($j3->settings->getIn('SideProductWishlistTooltipStatus', $context)): ?> data-toggle="tooltip" data-tooltip-class="<?php echo 'module-side_products-' . $module_id; ?> wishlist-tooltip" data-placement="<?php echo $j3->settings->getIn('SideProductWishlistTooltipPosition', $context); ?>" title="<?php echo $button_wishlist; ?>" <?php endif; ?> onclick="wishlist.add('<?php echo $product['product_id']; ?>//')"><span class="btn-text"><?php echo $button_wishlist; ?></span></a>
            <?php endif; ?>
            <?php if ($j3->settings->get('catalogCompareStatus')): ?>
              <a class="btn btn-compare" <?php if ($j3->settings->getIn('SideProductCompareTooltipStatus', $context)): ?> data-toggle="tooltip" data-tooltip-class="<?php echo 'module-side_products-' . $module_id; ?> compare-tooltip" data-placement="<?php echo $j3->settings->getIn('SideProductCompareTooltipPosition', $context); ?>" title="<?php echo $button_compare; ?>" <?php endif; ?> onclick="compare.add('<?php echo $product['product_id']; ?>//')"><span class="btn-text"><?php echo $button_compare; ?></span></a>
            <?php endif; ?>
          </div>
        <?php endif; ?>

      </div>
    </div>
  </div>
<?php endforeach; ?>
