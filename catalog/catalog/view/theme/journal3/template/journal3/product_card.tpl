<?php $context = get_defined_vars(); ?>
<?php $prefix = $display === 'grid' ? 'ProductGrid' : 'ProductList'; ?>
<?php foreach ($products as $product): ?>
  <?php $classes = $j3->classes(array(
    'out-of-stock'     => $product['quantity'] <= 0,
    'has-countdown'    => $product['date_end'],
    'has-zero-price'   => !$product['price_value'],
    'has-extra-button' => $product['extra_buttons'],
  )); ?>
  <div class="product-layout <?php echo $j3->classes(\Journal3\Utils\Arr::get($product, 'classes')); ?> <?php echo $classes; ?>">
    <div class="product-thumb">
      <?php if ($j3->settings->getIn($prefix . 'NamePosition', $context) == "image"): ?>
      <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
      <?php endif; ?>
      <div class="image">
        <?php if ($j3->settings->get('quickviewStatus')): ?>
          <div class="quickview-button">
            <a class="btn btn-quickview" <?php if ($j3->settings->getIn($prefix . 'QuickviewDisplay', $context) == 'icon' && $j3->settings->getIn($prefix . 'QuickviewTooltipStatus', $context)): ?>data-toggle="tooltip" data-tooltip-class="<?php echo isset($module_id) ? 'module-products-' . $module_id . ' module-products-grid' : 'product-grid'; ?> quickview-tooltip" data-placement="<?php echo $j3->settings->getIn($prefix . 'QuickviewTooltipPosition', $context); ?>" title="<?php echo $j3->settings->get('quickviewText'); ?>"<?php endif; ?> onclick="quickview('<?php echo $product['product_id']; ?>')"><span class="btn-text"><?php echo $j3->settings->get('quickviewText'); ?></span></a>
          </div>
        <?php endif; ?>

        <a href="<?php echo $product['href']; ?>" class="product-img <?php if ($product['second_thumb']): ?>has-second-image<?php endif; ?>">
          <div>
            <?php if ($j3->settings->get('performanceLazyLoadImagesStatus')): ?>
              <img src="<?php echo $dummy_image; ?>" data-src="<?php echo $product['thumb']; ?>" <?php if ($product['thumb2x']): ?>data-srcset="<?php echo $product['thumb']; ?> 1x, <?php echo $product['thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive img-first lazyload"/>
            <?php else: ?>
              <img src="<?php echo $product['thumb']; ?>" <?php if ($product['thumb2x']): ?>srcset="<?php echo $product['thumb']; ?> 1x, <?php echo $product['thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive img-first"/>
            <?php endif; ?>

            <?php if ($product['second_thumb']): ?>
              <?php if ($j3->settings->get('performanceLazyLoadImagesStatus')): ?>
                <img src="<?php echo $dummy_image; ?>" data-src="<?php echo $product['second_thumb']; ?>" <?php if ($product['second_thumb2x']): ?>data-srcset="<?php echo $product['second_thumb']; ?> 1x, <?php echo $product['second_thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive img-second lazyload"/>
              <?php else: ?>
                <img data-src="<?php echo $product['second_thumb']; ?>" <?php if ($product['second_thumb2x']): ?>srcset="<?php echo $product['second_thumb']; ?> 1x, <?php echo $product['second_thumb2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive img-second"/>
              <?php endif; ?>
            <?php endif; ?>
          </div>
        </a>

        <?php if ($product['labels']): ?>
          <div class="product-labels">
            <?php foreach ($product['labels'] as $id => $label): ?>
              <span class="product-label product-label-<?php echo $id; ?> product-label-<?php echo $label['display']; ?>"><b><?php echo $label['label']; ?></b></span>
            <?php endforeach; ?>
          </div>
        <?php endif; ?>

        <?php if ($j3->settings->get('countdownStatus') && $product['date_end']): ?>
          <div class="countdown" data-date="<?php echo $product['date_end']; ?>"></div>
        <?php endif; ?>
      </div>

      <div class="caption">

        <?php if ($product['stat1'] || $product['stat2']): ?>
          <div class="stats">
            <?php if ($product['stat1']): ?>
              <span class="stat-1"><span class="stats-label"><?php echo $product['stat1']['label']; ?>:</span> <span><?php echo $product['stat1']['text']; ?></span></span>
            <?php endif; ?>
            <?php if ($product['stat2']): ?>
              <span class="stat-2"><span class="stats-label"><?php echo $product['stat2']['label']; ?>:</span> <span><?php echo $product['stat2']['text']; ?></span></span>
            <?php endif; ?>
          </div>
        <?php endif; ?>

        <?php if ($j3->settings->getIn($prefix . 'NamePosition', $context) == "default"): ?>
          <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php endif; ?>

        <div class="description"><?php echo $product['description']; ?></div>

        <?php if ($product['price']): ?>
          <div class="price">
            <?php if ($product['special']): ?>
              <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
            <?php else: ?>
              <span class="price-normal"><?php echo $product['price']; ?></span>
            <?php endif; ?>
            <?php if ($product['tax']): ?>
              <span class="price-tax"><?php echo $text_tax; ?><?php echo $product['tax']; ?></span>
            <?php endif; ?>
          </div>
        <?php endif; ?>

        <?php if ($product['rating']): ?>
          <div class="rating <?php if ($j3->settings->getIn($prefix . 'RatingPosition', $context) == "hover"): ?>rating-hover<?php endif; ?>">
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
          <div class="rating no-rating <?php if ($j3->settings->getIn($prefix . 'RatingPosition', $context) == "hover"): ?>rating-hover<?php endif; ?>">
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
        <div class="buttons-wrapper">
          <div class="button-group">
            <?php if ($j3->settings->get('catalogCartStatus')): ?>
            <div class="cart-group">
              <div class="stepper">
                <input type="text" name="quantity" value="<?php echo $product['minimum']; ?>" data-minimum="<?php echo $product['minimum']; ?>" class="form-control"/>
                <input type="hidden" name="product_id" value="<?php echo $product['product_id']; ?>"/>
                <span>
                <i class="fa fa-angle-up"></i>
                <i class="fa fa-angle-down"></i>
              </span>
              </div>
              <a class="btn btn-cart" <?php if (($j3->settings->getIn($prefix . 'CartDisplay', $context) == "icon") && ($j3->settings->getIn($prefix . 'CartTooltipStatus', $context))): ?> data-toggle="tooltip" data-tooltip-class="<?php echo isset($module_id) ? 'module-products-' . $module_id . ' module-products-grid' : 'product-grid'; ?> cart-tooltip" data-placement="<?php echo $j3->settings->getIn($prefix . 'CartTooltipPosition', $context); ?>" title="<?php echo $button_cart; ?>" <?php endif; ?> onclick="cart.add('<?php echo $product['product_id']; ?>', $(this).closest('.button-group').find('input[name=\'quantity\']').val());" data-loading-text="<span class='btn-text'><?php echo $button_cart; ?></span>"><span class="btn-text"><?php echo $button_cart; ?></span></a>
            </div>
            <?php endif; ?>

            <?php if ($j3->settings->get('catalogWishlistStatus') || $j3->settings->get('catalogCompareStatus')): ?>
            <div class="wish-group">
              <?php if ($j3->settings->get('catalogWishlistStatus')): ?>
              <a class="btn btn-wishlist" <?php if (($j3->settings->getIn($prefix . 'WishlistDisplay', $context) == "icon") && ($j3->settings->getIn($prefix . 'WishlistTooltipStatus', $context))): ?> data-toggle="tooltip" data-tooltip-class="<?php echo isset($module_id) ? 'module-products-' . $module_id . ' module-products-grid' : 'product-grid'; ?> wishlist-tooltip" data-placement="<?php echo $j3->settings->getIn($prefix . 'WishlistTooltipPosition', $context); ?>" title="<?php echo $button_wishlist; ?>" <?php endif; ?> onclick="wishlist.add('<?php echo $product['product_id']; ?>')"><span class="btn-text"><?php echo $button_wishlist; ?></span></a>
              <?php endif; ?>
              <?php if ($j3->settings->get('catalogCompareStatus')): ?>
              <a class="btn btn-compare" <?php if (($j3->settings->getIn($prefix . 'CompareDisplay', $context) == "icon") && ($j3->settings->getIn($prefix . 'CompareTooltipStatus', $context))): ?> data-toggle="tooltip" data-tooltip-class="<?php echo isset($module_id) ? 'module-products-' . $module_id . ' module-products-grid' : 'product-grid'; ?> compare-tooltip" data-placement="<?php echo $j3->settings->getIn($prefix . 'CompareTooltipPosition', $context); ?>" title="<?php echo $button_compare; ?>" <?php endif; ?> onclick="compare.add('<?php echo $product['product_id']; ?>')"><span class="btn-text"><?php echo $button_compare; ?></span></a>
              <?php endif; ?>
            </div>
            <?php endif; ?>
          </div>
        </div>
        <?php endif; ?>

        <?php if ($product['extra_buttons']): ?>
          <div class="extra-group">
            <div>
              <?php $index = 0; foreach ($product['extra_buttons'] as $id => $extra_button): $index++; ?>
                <a class="btn btn-extra btn-extra-<?php echo $id; ?>"
                  <?php if (($j3->settings->getIn($prefix . 'ExtraButtonDisplay' . $index, $context) == "icon") && ($j3->settings->getIn($prefix . 'ExtraButtonTooltipStatus', $context))): ?> data-toggle="tooltip" data-tooltip-class="<?php echo isset($module_id) ? 'module-products-' . $module_id . ' module-products-grid' : 'product-grid'; ?> extra-tooltip" data-placement="<?php echo $j3->settings->getIn($prefix . 'ExtraButtonTooltipPosition', $context); ?>" title="<?php echo $extra_button['label']; ?>" <?php endif; ?>
                   <?php if ($extra_button['action'] == 'quickbuy'): ?>onclick="cart.add('<?php echo $product['product_id']; ?>', $(this).closest('.button-group').find('input[name=\'quantity\']').val(), true);"<?php endif; ?>
                   <?php if ($extra_button['action'] == 'link' && $extra_button['link']['href']): ?>href="<?php echo $extra_button['link']['href']; ?>" <?php echo $j3->linkAttrs($extra_button['link']); ?> data-product_id="<?php echo $product['product_id']; ?>" data-product_url="<?php echo $product['href']; ?>"<?php endif; ?>
                   data-loading-text="<span class='btn-text'><?php echo $extra_button['label']; ?></span>">
                  <span class="btn-text"><?php echo $extra_button['label']; ?></span>
                </a>
              <?php endforeach; ?>
            </div>
          </div>
        <?php endif; ?>
      </div>
    </div>
  </div>
<?php endforeach; ?>
