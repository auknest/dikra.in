<?php
$stylePrefix = $j3->document->isPopup('quickview') ? 'quickviewPageStyle' : 'productPageStyle';
$direction = $j3->settings->get($stylePrefix . 'AdditionalImagesPosition') == 'left' || $j3->settings->get($stylePrefix . 'AdditionalImagesPosition') == 'right' ? 'vertical' : 'horizontal';
$carousel = $direction == 'vertical' || $j3->settings->get($stylePrefix . 'AdditionalImagesCarousel');
$carouselOptions = array(
  'slidesPerView' => 'auto',
  'spaceBetween'  => (int)$j3->settings->get($stylePrefix . 'AdditionalImagesSpacing'),
  'direction'     => $direction,
);
$galleryOptions = array(
  'thumbWidth'     => $j3->settings->get('image_dimensions_popup_thumb.width'),
  'thumbConHeight' => $j3->settings->get('image_dimensions_popup_thumb.height'),
  'addClass'       => 'lg-product-images',
);
$quickviewExpand = $j3->settings->get('globalExpandCharactersLimit') > 0 && $description && utf8_strlen($description) <= $j3->settings->get('globalExpandCharactersLimit') ? 'no-expand': '';
?>
<?php echo $header; ?>
<?php if (!$j3->document->isPopup()): ?>
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
<div id="product-product" class="container">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>">
      <?php endif; ?>
      <?php echo $content_top; ?>
      <?php if (!$j3->document->isPopup('options')): ?>
      <?php if ($j3->settings->get('pageTitlePosition') === 'default' || $j3->document->isPopup('quickview')): ?>
        <h1 class="title page-title"><?php echo $heading_title; ?></h1>
      <?php endif; ?>
      <?php endif; ?>
      <?php $classes = $j3->classes(array(
        'out-of-stock'     => $product_quantity <= 0,
        'has-countdown'    => $date_end,
        'has-zero-price'   => !$product_price_value,
        'has-extra-button' => $product_extra_buttons,
      )); ?>
      <div class="product-info <?php echo $classes; ?>">
        <?php if (!$j3->document->isPopup('options')): ?>
        <div class="product-left">
          <div class="product-image direction-<?php echo $direction; ?> position-<?php echo $j3->settings->get($stylePrefix . 'AdditionalImagesPosition'); ?>">
            <div class="swiper main-image" data-options='<?php echo json_encode($j3->carousel($j3->document->getJs(), $stylePrefix . 'ImageCarouselStyle'), JSON_FORCE_OBJECT); ?>' <?php if (count($images) > 1 && $j3->settings->get($stylePrefix . 'AdditionalImagesStatus') && $carousel && $direction == 'vertical'): ?>style="width: calc(100% - <?php echo $j3->settings->get('image_dimensions_additional.width'); ?>px)"<?php endif; ?>>
              <div class="swiper-container" <?php if ($j3->isRTL()): ?>dir="rtl"<?php endif; ?>>
                <div class="swiper-wrapper">
                  <?php $gallery = array(); $index = 0; ?>
                  <?php foreach ($images as $image): ?>
                    <?php $gallery[] = array('src' => $image['popup'], 'thumb' => $image['galleryThumb'], 'subHtml' => $heading_title); ?>
                    <div class="swiper-slide" <?php if (!$j3->document->isPopup() && $j3->settings->get($stylePrefix . 'GalleryStatus')): ?> data-gallery=".lightgallery-product-images" data-index="<?php echo $index++; ?>" <?php endif; ?>>
                      <img src="<?php echo $image['image']; ?>" <?php if (isset($image['image2x']) && $image['image2x']): ?>srcset="<?php echo $image['image']; ?> 1x, <?php echo $image['image2x']; ?> 2x"<?php endif; ?> data-largeimg="<?php echo $image['popup']; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" width="<?php echo $j3->settings->get('image_dimensions_thumb.width'); ?>" height="<?php echo $j3->settings->get('image_dimensions_thumb.height'); ?>"/>
                    </div>
                  <?php endforeach; ?>
                </div>
              </div>
              <div class="swiper-buttons">
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
              </div>
              <div class="swiper-pagination"></div>
              <?php if ($product_labels): ?>
                <div class="product-labels">
                  <?php foreach ($product_labels as $id => $label): ?>
                    <span class="product-label product-label-<?php echo $id; ?> product-label-<?php echo $label['display']; ?>"><b><?php echo $label['label']; ?></b></span>
                  <?php endforeach; ?>
                </div>
              <?php endif; ?>
            </div>
            <?php if (count($images) > 1 && $j3->settings->get($stylePrefix . 'AdditionalImagesStatus')): ?>
              <?php if ($carousel): ?>
                <div class="swiper additional-images" data-options='<?php echo json_encode($carouselOptions, JSON_FORCE_OBJECT); ?>' <?php if ($direction == 'vertical'): ?>style="width: <?php echo $j3->settings->get('image_dimensions_additional.width'); ?>px"<?php endif; ?>>
                  <div class="swiper-container" <?php if ($j3->isRTL()): ?>dir="rtl"<?php endif; ?>>
                    <div class="swiper-wrapper">
                      <?php $index = 0; foreach ($images as $image): ?>
                        <div class="swiper-slide additional-image" data-index="<?php echo $index++; ?>">
                          <img src="<?php echo $image['thumb']; ?>" <?php if (isset($image['thumb2x']) && $image['thumb2x']): ?>srcset="<?php echo $image['thumb']; ?> 1x, <?php echo $image['thumb2x']; ?> 2x"<?php endif; ?> alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>"/>
                        </div>
                      <?php endforeach; ?>
                    </div>
                  </div>
                  <div class="swiper-buttons">
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                  </div>
                  <div class="swiper-pagination"></div>
                </div>
              <?php else: ?>
                <div class="additional-images">
                  <?php $index = 0; foreach ($images as $image): ?>
                    <div class="additional-image" data-index="<?php echo $index++; ?>">
                      <img src="<?php echo $image['thumb']; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>"/>
                    </div>
                  <?php endforeach; ?>
                </div>
              <?php endif; ?>
            <?php endif; ?>
          </div>
          <?php if (!$j3->document->isPopup() && $j3->settings->get($stylePrefix . 'GalleryStatus')): ?>
          <div class="lightgallery lightgallery-product-images" data-images='<?php echo htmlspecialchars(json_encode($gallery), ENT_QUOTES, 'UTF-8'); ?>' data-options='<?php echo json_encode($galleryOptions, JSON_FORCE_OBJECT); ?>'></div>
          <?php endif; ?>
          <?php if (!$j3->document->isPopup('options')): ?>
          <div class="product-blocks blocks-image">
          <?php echo implode(' ', \Journal3\Utils\Arr::get($product_blocks, 'image', array())); ?>
          </div>
          <?php endif; ?>
          <?php if ($j3->document->isPopup('quickview') && ($j3->settings->get('quickviewDescription') && $j3->settings->get('quickviewDescriptionPosition') == 'image')): ?>
            <div class="description expand-block <?php echo $quickviewExpand; ?>">
              <div class="expand-content">
                <?php echo $description; ?>
              </div>
              <?php if ($j3->settings->get('quickviewExpandButton')): ?>
                <div class="block-expand-overlay"><a class="block-expand btn"></a></div>
              <?php endif; ?>
            </div>
          <?php endif; ?>
          <?php if (($tags && !$j3->document->isPopup()) && ($j3->settings->get($stylePrefix . 'TagsPosition') == 'image')): ?>
          <div class="tags">
          <span class="tags-title"><?php echo $text_tags; ?>
            <?php for ($i = 0; $i < count($tags); $i++) { ?>
            <?php if ($i < (count($tags) - 1)) { ?>
            <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a><b>,</b>
            <?php } else { ?>
            <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
            <?php } ?>
            <?php } ?>
          </div>
          <?php endif; ?>
        </div>
        <?php endif; ?>
        <div class="product-right">
          <div id="product" class="product-details">
            <?php if (!$j3->document->isPopup('options')): ?>
            
                <style>
                 .title-divider{
        display: none !important;
    }
.temp_product::after{
                    background: unset;
              
                }
                .temp_product{
                   text-transform: unset;
                }
                   
                </style>
               <div class="title temp_product" style="display:block;    text-decoration: none;"><?php echo $heading_title; ?></div>

            <?php echo implode(' ', \Journal3\Utils\Arr::get($product_blocks, 'top', array())); ?>
            <?php endif; ?>
            <?php if ($j3->document->isPopup('quickview') && ($j3->settings->get('quickviewDescription') && $j3->settings->get('quickviewDescriptionPosition') == 'top')): ?>
              <div class="description expand-block <?php echo $quickviewExpand; ?>">
                <div class="expand-content">
                  <?php echo $description; ?>
                </div>
                <?php if ($j3->settings->get('quickviewExpandButton')): ?>
                  <div class="block-expand-overlay"><a class="block-expand btn"></a></div>
                <?php endif; ?>
              </div>
            <?php endif; ?>
          <?php if (!$j3->document->isPopup('options') && $j3->settings->get($stylePrefix . 'Stats') && ($j3->settings->get($stylePrefix . 'StatsPosition') == 'default')): ?>
            <div class="product-stats">
              <ul class="list-unstyled">
                <?php if ($j3->settings->get($stylePrefix . 'ProductStock')): ?>
                  <li class="product-stock <?php if ($product_quantity > 0): ?>in-stock<?php else: ?>out-of-stock<?php endif; ?>"><b><?php echo $text_stock; ?></b> <span><?php echo $stock; ?></span></li>
                <?php endif; ?>
                <?php if ($manufacturer && $j3->settings->get($stylePrefix . 'ProductManufacturer') && ($j3->settings->get($stylePrefix . 'ProductManufacturerDisplay') == 'list')): ?>
                <li class="product-manufacturer"><b><?php echo $text_manufacturer; ?></b> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductReward') && $reward): ?>
                  <li class="product-reward"><b><?php echo $text_reward; ?></b> <span><?php echo $reward; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductModel') && $model): ?>
                  <li class="product-model"><b><?php echo $text_model; ?></b> <span><?php echo $model; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductWeight') && $product_weight): ?>
                  <li class="product-weight"><b><?php echo $text_weight; ?>:</b> <span><?php echo $product_weight; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductDimension')): ?>
                  <li class="product-dimension"><b><?php echo $text_dimension; ?>:</b> <span><?php echo $product_length; ?> x <?php echo $product_width; ?> x <?php echo $product_height; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductSKU') && $product_sku): ?>
                  <li class="product-sku"><b><?php echo $j3->settings->get($stylePrefix . 'ProductSKUText'); ?>:</b> <span> <?php echo $product_sku; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductUPC') && $product_upc): ?>
                  <li class="product-upc"><b><?php echo $j3->settings->get($stylePrefix . 'ProductUPCText'); ?>:</b> <span><?php echo $product_upc; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductEAN') && $product_ean): ?>
                  <li class="product-ean"><b><?php echo $j3->settings->get($stylePrefix . 'ProductEANText'); ?>:</b> <span><?php echo $product_ean; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductJAN') && $product_jan): ?>
                  <li class="product-jan"><b><?php echo $j3->settings->get($stylePrefix . 'ProductJANText'); ?>:</b> <span><?php echo $product_jan; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductISBN') && $product_isbn): ?>
                  <li class="product-isbn"><b><?php echo $j3->settings->get($stylePrefix . 'ProductISBNText'); ?>:</b> <span><?php echo $product_isbn; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductMPN') && $product_mpn): ?>
                  <li class="product-mpn"><b><?php echo $j3->settings->get($stylePrefix . 'ProductMPNText'); ?>:</b> <span><?php echo $product_mpn; ?></span></li>
                <?php endif; ?>
              </ul>
              <?php if ($manufacturer && $j3->settings->get($stylePrefix . 'ProductManufacturer') && ($j3->settings->get($stylePrefix . 'ProductManufacturerDisplay') == 'image')): ?>
                <div class="brand-image product-manufacturer">
                  <a href="<?php echo $manufacturers; ?>">
                    <?php if ($manufacturer_image): ?>
                      <img src="<?php echo $manufacturer_image; ?>" <?php if (isset($manufacturer_image2x) && $manufacturer_image2x): ?>srcset="<?php echo $manufacturer_image; ?> 1x, <?php echo $manufacturer_image2x; ?> 2x"<?php endif; ?> alt="<?php echo $manufacturer; ?>"/>
                    <?php endif; ?>
                    <span><?php echo $manufacturer; ?></span>
                  </a>
                </div>
              <?php endif; ?>
              <?php if ($j3->settings->get($stylePrefix . 'CustomStats')): ?>
                <div class="custom-stats">
                  <?php if ($j3->settings->get($stylePrefix . 'ProductSold')): ?>
                    <div class="product-sold"><b><?php echo $j3->settings->getWithValue($stylePrefix . 'SoldText', $products_sold); ?></b></div>
                  <?php endif; ?>
                  <?php if ($j3->settings->get($stylePrefix . 'ProductViews')): ?>
                    <div class="product-views"><b><?php echo $j3->settings->getWithValue($stylePrefix . 'ViewsText', $product_views); ?></b></div>
                  <?php endif; ?>
                </div>
              <?php endif; ?>
            </div>
          <?php endif; ?>
          <?php if ($review_status && !$j3->document->isPopup()): ?>
            
                <div class="rating hidden">

              <div class="rating-stars">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
              <?php if ($rating < $i) { ?>
              <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
              <?php } else { ?>
              <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
              <?php } ?>
              <?php } ?>
              </div>
              <div class="review-links">
                <a><?php echo $reviews; ?></a>
                <b><?php echo $j3->settings->get($stylePrefix . 'RatingSeparator'); ?></b>
                <a><?php echo $text_write; ?></a>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($date_end && $j3->settings->get($j3->document->isPopup() ? 'quickviewCountdown' : 'countdownStatus')): ?>
            <div class="countdown-wrapper">
              <?php if ($j3->settings->get($stylePrefix . 'CountdownText')): ?>
              <h5 class="countdown-title title"><?php echo $j3->settings->get($stylePrefix . 'CountdownText'); ?></h5>
              <?php endif; ?>
              <div class="countdown" data-date="<?php echo $date_end; ?>">
                <div><i class="fa fa-spinner fa-spin"></i><span><?php echo $j3->settings->get('countdownDay'); ?></span></div>
                <div><i class="fa fa-spinner fa-spin"></i><span><?php echo $j3->settings->get('countdownHour'); ?></span></div>
                <div><i class="fa fa-spinner fa-spin"></i><span><?php echo $j3->settings->get('countdownMin'); ?></span></div>
                <div><i class="fa fa-spinner fa-spin"></i><span><?php echo $j3->settings->get('countdownSec'); ?></span></div>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($price && !$j3->document->isPopup('options')): ?>
          <div class="product-price-group">
            <div class="price-wrapper">
              <div class="price-group">
                <?php if (!$special): ?>
                <div class="product-price"><?php echo $price; ?></div>
                <?php else: ?>
                <div class="product-price-old"><?php echo $price; ?></div>
                <div class="product-price-new"><?php echo $special; ?></div>
                <?php endif; ?>
              </div>
              <?php if ($tax): ?>
              <div class="product-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></div>
              <?php endif; ?>
              <?php if ($points): ?>
              <div class="product-points"><?php echo $text_points; ?> <?php echo $points; ?></div>
              <?php endif; ?>

              <?php if ($discounts): ?>
              <div class="discounts">
                <?php foreach ($discounts as $discount): ?>
                <div class="product-discount"><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></div>
                <?php endforeach; ?>
              </div>
              <?php endif; ?>
            </div>
            <?php if (!$j3->document->isPopup('options') && $j3->settings->get($stylePrefix . 'Stats') && ($j3->settings->get($stylePrefix . 'StatsPosition') == 'price')): ?>
            <div class="product-stats">
              <ul class="list-unstyled">
                <?php if ($j3->settings->get($stylePrefix . 'ProductStock')): ?>
                <li class="product-stock <?php if ($product_quantity): ?>in-stock<?php else: ?>out-of-stock<?php endif; ?>"><b><?php echo $text_stock; ?></b> <span><?php echo $stock; ?></span></li>
                <?php endif; ?>
                <?php if ($manufacturer && $j3->settings->get($stylePrefix . 'ProductManufacturer') && ($j3->settings->get($stylePrefix . 'ProductManufacturerDisplay') == 'list')): ?>
                <li class="product-manufacturer"><b><?php echo $text_manufacturer; ?></b> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductReward') && $reward): ?>
                <li class="product-reward"><b><?php echo $text_reward; ?></b> <span><?php echo $reward; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductModel') && $model): ?>
                <li class="product-model"><b><?php echo $text_model; ?></b> <span><?php echo $model; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductWeight') && $product_weight): ?>
                <li class="product-weight"><b><?php echo $text_weight; ?>:</b> <span><?php echo $product_weight; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductDimension')): ?>
                <li class="product-dimension"><b><?php echo $text_dimension; ?>:</b> <span><?php echo $product_length; ?> x <?php echo $product_width; ?> x <?php echo $product_height; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductSKU') && $product_sku): ?>
                <li class="product-sku"><b><?php echo $j3->settings->get($stylePrefix . 'ProductSKUText'); ?>:</b> <span> <?php echo $product_sku; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductUPC') && $product_upc): ?>
                <li class="product-upc"><b><?php echo $j3->settings->get($stylePrefix . 'ProductUPCText'); ?>:</b> <span><?php echo $product_upc; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductEAN') && $product_ean): ?>
                  <li class="product-ean"><b><?php echo $j3->settings->get($stylePrefix . 'ProductEANText'); ?>:</b> <span><?php echo $product_ean; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductJAN') && $product_jan): ?>
                <li class="product-jan"><b><?php echo $j3->settings->get($stylePrefix . 'ProductJANText'); ?>:</b> <span><?php echo $product_jan; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductISBN') && $product_isbn): ?>
                <li class="product-isbn"><b><?php echo $j3->settings->get($stylePrefix . 'ProductISBNText'); ?>:</b> <span><?php echo $product_isbn; ?></span></li>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductMPN') && $product_mpn): ?>
                <li class="product-mpn"><b><?php echo $j3->settings->get($stylePrefix . 'ProductMPNText'); ?>:</b> <span><?php echo $product_mpn; ?></span></li>
                <?php endif; ?>
              </ul>
              <?php if ($manufacturer && $j3->settings->get($stylePrefix . 'ProductManufacturer') && ($j3->settings->get($stylePrefix . 'ProductManufacturerDisplay') == 'image')): ?>
              <div class="brand-image product-manufacturer">
                <a href="<?php echo $manufacturers; ?>">
                  <?php if ($manufacturer_image): ?>
                  <img src="<?php echo $manufacturer_image; ?>" <?php if (isset($manufacturer_image2x) && $manufacturer_image2x): ?>srcset="<?php echo $manufacturer_image; ?> 1x, <?php echo $manufacturer_image2x; ?> 2x"<?php endif; ?> alt="<?php echo $manufacturer; ?>"/>
                  <?php endif; ?>
                  <span><?php echo $manufacturer; ?></span>
                </a>
              </div>
              <?php endif; ?>
              <?php if ($j3->settings->get($stylePrefix . 'CustomStats')): ?>
              <div class="custom-stats">
                <?php if ($j3->settings->get($stylePrefix . 'ProductSold')): ?>
                <div class="product-sold"><b><?php echo $j3->settings->getWithValue($stylePrefix . 'SoldText', $products_sold); ?></b></div>
                <?php endif; ?>
                <?php if ($j3->settings->get($stylePrefix . 'ProductViews')): ?>
                <div class="product-views"><b><?php echo $j3->settings->getWithValue($stylePrefix . 'ViewsText', $product_views); ?></b></div>
                <?php endif; ?>
              </div>
              <?php endif; ?>
            </div>
            <?php endif; ?>
          </div>
          <?php endif; ?>
          <?php if ($options): ?>
          <div class="product-options">
            <h3 class="options-title title"><?php echo $text_option; ?></h3>
            <?php foreach ($options as $option): ?>
            <?php if ($option['type'] == 'select'): ?>
            <div class="form-group<?php if ($option['required']): ?> required <?php endif; ?> product-option-<?php echo $option['type']; ?> <?php if ($j3->settings->get($stylePrefix . 'OptionsPushSelect')): ?>push-option<?php endif; ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($option['product_option_value'] as $option_value): ?>
                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']): ?>
                <!--(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>) -->
                <?php endif; ?> </option>
                <?php endforeach; ?>
              </select>
            </div>
            <?php endif; ?>
            <?php if ($option['type'] == 'radio'): ?>
            <div class="form-group<?php if ($option['required']): ?> required <?php endif; ?> product-option-<?php echo $option['type']; ?> <?php if ($j3->settings->get($stylePrefix . 'OptionsPushRadio')): ?>push-option<?php endif; ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>"> <?php foreach ($option['product_option_value'] as $option_value): ?>
                <div class="radio">
                  <label>
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <?php if ($option_value['image']): ?> <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name']; ?> <!--<?php if ($option_value['price']): ?> <?php echo $option_value['price_prefix']; ?> <?php echo $option_value['price']; ?> <?php endif; ?>-->" data-toggle="tooltip" data-tooltip-class="push-tooltip" data-placement="<?php echo $j3->settings->get($stylePrefix . 'PushTooltipPosition'); ?>" title="<?php echo $option_value['name']; ?> <?php if ($option_value['price']): ?> <!--(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>) --> <?php endif; ?>"/> <?php endif; ?>
                    <span class="option-value">
                      <?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']): ?>
                       <!-- <span class="option-price">
                          (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>) 
                        </span>-->
                      <?php endif; ?>
                    </span>
                  </label>
                </div>
                <?php endforeach; ?> </div>
            </div>
            <?php endif; ?>
            <?php if ($option['type'] == 'checkbox'): ?>
            <div class="form-group<?php if ($option['required']): ?> required <?php endif; ?> product-option-<?php echo $option['type']; ?> <?php if ($j3->settings->get($stylePrefix . 'OptionsPushCheckbox')): ?>push-option<?php endif; ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>"> <?php foreach ($option['product_option_value'] as $option_value): ?>
                <div class="checkbox">
                  <label>
                    <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <?php if ($option_value['image']): ?> <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name']; ?> <?php if ($option_value['price']): ?> <!-- <?php echo $option_value['price_prefix']; ?> <?php echo $option_value['price']; ?> --><?php endif; ?>" data-toggle="tooltip" data-tooltip-class="push-tooltip" data-placement="<?php echo $j3->settings->get($stylePrefix . 'PushTooltipPosition'); ?>" title="<?php echo $option_value['name']; ?> <?php if ($option_value['price']): ?> <!--(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>) --> <?php endif; ?>"/> <?php endif; ?>
                    <span class="option-value">
                      <?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']): ?>
                       <!-- <span class="option-price">(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)</span> -->
                      <?php endif; ?>
                    </span>
                  </label>
                </div>
                <?php endforeach; ?> </div>
            </div>
            <?php endif; ?>
            <?php if ($option['type'] == 'text'): ?>
            <div class="form-group<?php if ($option['required']): ?> required <?php endif; ?> product-option-<?php echo $option['type']; ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
            </div>
            <?php endif; ?>
            <?php if ($option['type'] == 'textarea'): ?>
            <div class="form-group<?php if ($option['required']): ?> required <?php endif; ?> product-option-<?php echo $option['type']; ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
            </div>
            <?php endif; ?>
            <?php if ($option['type'] == 'file'): ?>
            <div class="form-group<?php if ($option['required']): ?> required <?php endif; ?> product-option-<?php echo $option['type']; ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
            </div>
            <?php endif; ?>
            <?php if ($option['type'] == 'date'): ?>
            <div class="form-group<?php if ($option['required']): ?> required <?php endif; ?> product-option-<?php echo $option['type']; ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group date" data-picker-class="product-options pp-date-time-picker">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php endif; ?>
            <?php if ($option['type'] == 'datetime'): ?>
            <div class="form-group<?php if ($option['required']): ?> required <?php endif; ?> product-option-<?php echo $option['type']; ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group datetime" data-picker-class="product-options pp-date-time-picker">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php endif; ?>
            <?php if ($option['type'] == 'time'): ?>
            <div class="form-group<?php if ($option['required']): ?> required <?php endif; ?> product-option-<?php echo $option['type']; ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group time" data-picker-class="product-options pp-date-time-picker">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php endif; ?>
            <?php endforeach; ?>
            </div>
            <?php endif; ?>
            <?php if ($recurrings): ?>
            <h3><?php echo $text_payment_recurring; ?></h3>
            <div class="form-group required">
              <select name="recurring_id" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($recurrings as $recurring): ?>
                <option value="<?php echo $recurring['recurring_id']; ?>"><?php echo $recurring['name']; ?></option>
                <?php endforeach; ?>
              </select>
              <div class="help-block" id="recurring-description"></div>
            </div>
          <?php endif; ?>
          <?php if ($j3->settings->get('catalogCartStatus') || $j3->settings->get('catalogWishlistStatus') || $j3->settings->get('catalogCompareStatus') || ($product_extra_buttons && !$j3->document->isPopup())): ?>
          <div class="button-group-page">
            <div class="buttons-wrapper">
            <div class="stepper-group">
              <?php if ($j3->settings->get('catalogCartStatus')): ?>
              <div class="stepper">
                <input id="product-quantity" type="text" name="quantity" value="<?php echo $minimum; ?>" data-minimum="<?php echo $minimum; ?>" class="form-control"/>
                <input id="product-id" type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                <span>
                  <i class="fa fa-angle-up"></i>
                  <i class="fa fa-angle-down"></i>
                </span>
              </div>
              <a id="button-cart" data-loading-text="<span class='btn-text'><?php echo $button_cart; ?></span>" class="btn btn-cart" <?php if (($j3->settings->get($stylePrefix . 'CartDisplay') == "icon") && ($j3->settings->get($stylePrefix . 'CartTooltipStatus'))): ?> data-toggle="tooltip" data-tooltip-class="pp-cart-tooltip" data-placement="<?php echo $j3->settings->get($stylePrefix . 'CartTooltipPosition'); ?>" title="<?php echo $button_cart; ?>" <?php endif; ?>><span class="btn-text"><?php echo $button_cart; ?></span></a>
              <?php endif; ?>

              <?php if ($product_extra_buttons && !$j3->document->isPopup()): ?>
                <div class="extra-group">
                <?php $index = 0; foreach ($product_extra_buttons as $id => $extra_button): $index++; ?>
                  <a class="btn btn-extra btn-extra-<?php echo $id; ?> btn-<?php echo $index; ?>-extra" <?php if (($j3->settings->get($stylePrefix . 'Extra' . $index . 'ButtonDisplay') == "icon" && $j3->settings->get($stylePrefix . 'ExtraTooltipStatus'))): ?> data-toggle="tooltip" data-tooltip-class="extra-tooltip pp-extra-tooltip" data-placement="<?php echo $j3->settings->get($stylePrefix . 'ExtraTooltipPosition'); ?>" title="<?php echo $extra_button['label']; ?>"<?php endif; ?> <?php if( $extra_button['action'] == 'quickbuy'): ?>data-quick-buy<?php endif; ?> <?php if( $extra_button['action'] == 'link' && $extra_button['link']['href']): ?>href="<?php echo $extra_button['link']['href']; ?>" <?php echo $j3->linkAttrs($extra_button['link']); ?> data-product_id="<?php echo $product_id; ?>"<?php endif; ?> data-loading-text="<span class='btn-text'><?php echo $extra_button['label']; ?></span>"><span class="btn-text"><?php echo $extra_button['label']; ?></span></a>
                <?php endforeach; ?>
                </div>
              <?php endif; ?>
            </div>
            <?php if ($j3->settings->get('catalogWishlistStatus') || $j3->settings->get('catalogCompareStatus')): ?>
            <div class="wishlist-compare">
              <?php if (!$j3->document->isPopup('options')): ?>
              <?php if ($j3->settings->get('catalogWishlistStatus')): ?>
              <a class="btn btn-wishlist" <?php if (($j3->settings->get($stylePrefix . 'WishlistDisplay') == "icon") && ($j3->settings->get($stylePrefix . 'WishlistTooltipStatus'))): ?> data-toggle="tooltip" data-tooltip-class="pp-wishlist-tooltip" data-placement="<?php echo $j3->settings->get($stylePrefix . 'WishlistTooltipPosition'); ?>" title="<?php echo $button_wishlist; ?>" <?php endif; ?> onclick="parent.wishlist.add(<?php echo $product_id; ?>);"><span class="btn-text"><?php echo $button_wishlist; ?></span></a>
              <?php endif; ?>
              <?php if ($j3->settings->get('catalogCompareStatus')): ?>
              <a class="btn btn-compare" <?php if (($j3->settings->get($stylePrefix . 'CompareDisplay') == "icon") && ($j3->settings->get($stylePrefix . 'CompareTooltipStatus'))): ?> data-toggle="tooltip" data-tooltip-class="pp-compare-tooltip" data-placement="<?php echo $j3->settings->get($stylePrefix . 'CompareTooltipPosition'); ?>" title="<?php echo $button_compare; ?>" <?php endif; ?> onclick="parent.compare.add(<?php echo $product_id; ?>);"><span class="btn-text"><?php echo $button_compare; ?></span></a>
              <?php endif; ?>
              <?php endif; ?>
              <?php if ($j3->document->isPopup('quickview')): ?>
                <a class="btn btn-more-details" href="<?php echo $view_more_url; ?>" target="_top" <?php if (($j3->settings->get($stylePrefix . 'MoreDetailsDisplay') == "icon") && ($j3->settings->get($stylePrefix . 'MoreDetailsTooltipStatus'))): ?> data-toggle="tooltip" data-tooltip-class="more-details-tooltip" data-placement="<?php echo $j3->settings->get($stylePrefix . 'MoreDetailsTooltipPosition'); ?>" title="<?php echo $j3->settings->get('quickviewExtraText'); ?>" <?php endif; ?>><span class="btn-text"><?php echo $j3->settings->get('quickviewExtraText'); ?></span></a>
              <?php endif; ?>
            </div>
            <?php endif; ?>
            </div>
          </div>
          <?php endif; ?>
          <?php if ($minimum > 1): ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
          <?php endif; ?>
        </div>
        <?php if (!$j3->document->isPopup('options')): ?>
          <div class="product-blocks blocks-bottom">

          <?php if ($review_status && !$j3->document->isPopup()): ?>
            <div class="rating" style="margin:2%">
              <div class="rating-stars">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
              <?php if ($rating < $i) { ?>
              <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
              <?php } else { ?>
              <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
              <?php } ?>
              <?php } ?>
              </div>
              <div class="review-links">
                <a><?php echo $reviews; ?></a>
                <b><?php echo $j3->settings->get($stylePrefix . 'RatingSeparator'); ?></b>
                <a><?php echo $text_write; ?></a>
              </div>
            </div>
          <?php endif; ?>	

          <?php echo implode(' ', \Journal3\Utils\Arr::get($product_blocks, 'bottom', array())); ?>
          </div>
        <?php endif; ?>
        <?php if (($tags && !$j3->document->isPopup()) && ($j3->settings->get($stylePrefix . 'TagsPosition') == 'details')): ?>
        <div class="tags">
          <span class="tags-title"><?php echo $text_tags; ?></span>
          <?php for ($i = 0; $i < count($tags); $i++) { ?>
          <?php if ($i < (count($tags) - 1)) { ?>
          <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a><b>,</b>
          <?php } else { ?>
          <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
          <?php } ?>
          <?php } ?>
        </div>
        <?php endif; ?>
        </div>
      </div>
      <?php if ($j3->document->isPopup('quickview') && $j3->settings->get('quickviewDescription') && ($j3->settings->get('quickviewDescriptionPosition') == 'default')): ?>
        <div class="description expand-block <?php echo $quickviewExpand; ?>">
          <div class="expand-content">
            <?php echo $description; ?>
          </div>
          <?php if ($j3->settings->get('quickviewExpandButton')): ?>
            <div class="block-expand-overlay"><a class="block-expand btn"></a></div>
          <?php endif; ?>
        </div>
      <?php endif; ?>
      <?php if (!$j3->document->isPopup('options')): ?>
      <?php echo implode(' ', \Journal3\Utils\Arr::get($product_blocks, 'default', array())); ?>
      <?php endif; ?>
      <?php if (($tags && !$j3->document->isPopup()) && ($j3->settings->get($stylePrefix . 'TagsPosition') == 'default')): ?>
        <div class="tags">
        <span class="tags-title"><?php echo $text_tags; ?>
          <?php for ($i = 0; $i < count($tags); $i++) { ?>
          <?php if ($i < (count($tags) - 1)) { ?>
          <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a><b>,</b>
          <?php } else { ?>
          <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
          <?php } ?>
          <?php } ?>
        </div>
        <?php endif; ?>
      <?php if (!$j3->document->isPopup()): ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php endif; ?>
<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('#button-cart, [data-quick-buy]').on('click', function () {
  var $btn = $(this);
  $.ajax({
    url: 'index.php?route=checkout/cart/add',
    type: 'post',
    data: $(
      '#product .button-group-page input[type=\'text\'], #product .button-group-page input[type=\'hidden\'], #product .button-group-page input[type=\'radio\']:checked, #product .button-group-page input[type=\'checkbox\']:checked, #product .button-group-page select, #product .button-group-page textarea, ' +
      '#product .product-options input[type=\'text\'], #product .product-options input[type=\'hidden\'], #product .product-options input[type=\'radio\']:checked, #product .product-options input[type=\'checkbox\']:checked, #product .product-options select, #product .product-options textarea, ' +
      '#product select[name="recurring_id"]'
    ),
    dataType: 'json',
    beforeSend: function () {
      $('#button-cart').button('loading');
    },
    complete: function () {
      $('#button-cart').button('reset');
    },
    success: function (json) {
      $('.alert-dismissible, .text-danger').remove();
      $('.form-group').removeClass('has-error');

      if (json['error']) {
        if (json['error']['option']) {
          for (i in json['error']['option']) {
            var element = $('#input-option' + i.replace('_', '-'));

            if (element.parent().hasClass('input-group')) {
              element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
            } else {
              element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
            }
          }
        }

        if (json['error']['recurring']) {
          $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
        }

        // Highlight any found errors
        $('.text-danger').parent().addClass('has-error');
      }

      if (json['success']) {
        if ($('html').hasClass('popup-options')) {
          parent.$(".popup-options .popup-close").trigger('click');
        }

        if (json['notification']) {
          parent.show_notification(json['notification']);
        } else {
          parent.$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
        }

        parent.$('#cart-total').html(json['total']);
        parent.$('#cart-items').html(json['items_count']);

        if (Journal['scrollToTop']) {
          parent.$('html, body').animate({ scrollTop: 0 }, 'slow');
        }

        parent.$('.cart-content ul').load('index.php?route=common/cart/info ul li');

        if (window.location.href.indexOf('quick_buy=true') !== -1) {
          parent.location.href = 'index.php?route=checkout/checkout';
        }

        if ($btn.data('quick-buy') !== undefined) {
          location = 'index.php?route=checkout/checkout';
        }

        if (parent.window['_QuickCheckout']) {
          parent.window['_QuickCheckout'].save();
        }
      }
    },
    error: function (xhr, ajaxOptions, thrownError) {
      alert(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
    }
  });
});
//--></script>
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').val(json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<script type="text/javascript"><!--
$(function () {
  $('#review').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
  });

  $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

  $('#button-review').on('click', function() {
    $.ajax({
      url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
      type: 'post',
      dataType: 'json',
      data: $("#form-review").serialize(),
      beforeSend: function() {
        $('#button-review').button('loading');
      },
      complete: function() {
        $('#button-review').button('reset');
      },
      success: function(json) {
        $('.alert-success, .alert-danger').remove();

        if (json['error']) {
          $('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
        }

        if (json['success']) {
          $('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

          $('input[name=\'name\']').val('');
          $('textarea[name=\'text\']').val('');
          $('input[name=\'rating\']:checked').prop('checked', false);
        }
      }
    });
  });
});

$(document).ready(function() {
	$('.thumbnails').magnificPopup({
		type:'image',
		delegate: 'a',
		gallery: {
			enabled:true
		}
	});
});

$(document).ready(function () {
  $('.review-links a').on('click', function () {
    var $review = $('#review');
    if ($review.length) {
      $('a[href="#' + $review.closest('.module-item').attr('id') + '"]').trigger('click');
      $('a[href="#' + $review.closest('.tab-pane').attr('id') + '"]').trigger('click');
      $('a[href="#' + $review.closest('.panel-collapse').attr('id') + '"]').trigger('click');

      $([document.documentElement, document.body]).animate({
        scrollTop: $review.offset().top - 100
      }, 200);
    }
  });
});
//--></script>
<?php if (!$j3->document->isPopup()): ?>
<?php echo $j3->loadController('journal3/seo/rich_snippets', $breadcrumbs); ?>
<?php endif; ?>

                <style>
                .color-red{
color:red;                
}
                </style>
       <script type="text/javascript">
    var html = '<div class="form-group custom-field" id="pincode_content" style="border-bottom: 1px solid;display: -webkit-inline-box;">';
    html += '<i class="fa fa-map-marker fa-2x" style=""></i>';
    html += '<input type="text" id="dilivery_pincode" value="" placeholder="pincode"  class="form-control" autocomplete="off" style="width: 70%;border: none !important;border-width: unset !important;border-style: none !important;border-color: unset !important;background: none !important;border-radius: unset !important;height: auto;text-align: left;">';
    html += '<a id="check_delivery" style="cursor: pointer;text-decoration: underline;" onclick="checkpincode()">check</a>';
    html += '</div>';
    html += '<div class="form-group custom-field" id="pincode_msg">';
    html += '</div>';
    $(".grid-item-233-1-2-1").html(html);
    $(".grid-item-141-1-2-1").html(html);
                <?php if(isset($pincode)){
?>
      $("#dilivery_pincode").val('<?php echo $pincode ?>');
       $('#check_delivery').html('change');          <?php                
}?>
                var msg="<?php if(isset($pincode)){ echo $pin_check_result; if(isset($pin_check_delivery) && $pin_check_delivery != ''){echo $pin_check_delivery;}echo"</font></font><br /></div>";}?>";
               
 $('#pincode_msg').html(msg);
                if( $("#dilivery_pincode").val()==''){
                $('#pincode_msg').html('<span class="color-red">Please enter Pincode</span>');
                }
    function checkpincode() {
        var pincode = $("#dilivery_pincode").val();
                if(pincode==''){
               $('#pincode_msg').html('<span class="color-red">Please enter Pincode</span>');
                return false;
}
        $.ajax({
            url: 'index.php?route=product/product/pinCheck',
            type: 'post',
                       data:{ 
                pincode:pincode
            },
            beforeSend: function () {
                $('#check_delivery').html('checking');
            },
            complete: function () {
             $('#check_delivery').html('change');
            },
            success: function (json) {

                    $('#pincode_msg').html(json);
                
            }
        });
    }
</script>    
                
            
<?php echo $footer; ?>
