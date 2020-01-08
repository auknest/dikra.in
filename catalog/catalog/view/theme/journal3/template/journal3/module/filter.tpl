<div class="<?php echo $j3->classes($classes); ?>">
  <h3 class="title module-title">
    <span><?php echo $title; ?></span>
    <button class="reset-filter btn"><?php echo $resetText; ?></button>
    <a class="x"></a>
  </h3>
  <div class="module-body">
    <div class="panel-group">
      <?php $index = 0;
      foreach ($items as $item): $index++; ?>
        <?php $item_input = $item['input'] ? $item['input'] : $input; ?>
        <div class="<?php echo $j3->classes($item['classes']); ?>">
          <div class="panel-heading">
            <div class="panel-title">
              <a href="#<?php echo $id; ?>-collapse-<?php echo $index; ?>" class="accordion-toggle <?php if ($item['collapsed']): ?>collapsed<?php endif; ?>" data-toggle="collapse" aria-expanded="<?php if ($item['collapsed']): ?>false<?php else: ?>true<?php endif; ?>" data-filter="<?php echo $item['key']; ?>">
                <?php echo $item['title']; ?>
                <i class="fa fa-caret-down"></i>
              </a>
            </div>
          </div>
          <div class="<?php echo $j3->classes($item['panel_classes']); ?>" id="<?php echo $id; ?>-collapse-<?php echo $index; ?>">
            <div class="panel-body">
              <?php if ($item['type'] == 'p'): ?>
                <div class="filter-price" id="filter-<?php echo $id; ?>-<?php echo $index; ?>">
                  <div class="range-slider">
                    <input type="text" class="js-range-slider" value=""/>
                  </div>
                  <div class="extra-controls">
                    <?php if ($currency_left): ?>
                      <span class="currency-symbol currency-left"><?php echo $currency_left; ?></span>
                    <?php endif; ?>

                    <input type="text" class="filter-price-min" name="min" data-min="<?php echo $item['price_range']['min']; ?>" value="<?php echo $item['current_price_range']['min']; ?>"/>

                    <?php if ($currency_right): ?>
                      <span class="currency-symbol currency-right"><?php echo $currency_right; ?></span>
                    <?php endif; ?>

                    <?php if ($currency_left): ?>
                      <span class="currency-symbol currency-left"><?php echo $currency_left; ?></span>
                    <?php endif; ?>

                    <input type="text" class="filter-price-max" name="max" data-max="<?php echo $item['price_range']['max']; ?>" value="<?php echo $item['current_price_range']['max']; ?>"/>

                    <?php if ($currency_right): ?>
                      <span class="currency-symbol currency-right"><?php echo $currency_right; ?></span>
                    <?php endif; ?>
                  </div>
                </div>
              <?php elseif ($item['type'] == 'r'): ?>
                <div class="filter-rating" id="filter-<?php echo $id; ?>-<?php echo $index; ?>">
                  <?php foreach ($item['items'] as $subitem): ?>
                    <label>
                      <input type="<?php echo $item['input']; ?>" data-filter-trigger name="<?php echo $item['key']; ?>" value="<?php echo $subitem['id']; ?>" <?php if ($subitem['checked']): ?>checked<?php endif; ?>>
                      <span class="links-text rating-stars">
                        <?php for ($i = 1; $i <= 5; $i++): ?>
                          <?php if ($subitem['id'] < $i): ?>
                            <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                          <?php else: ?>
                            <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                          <?php endif; ?>
                        <?php endfor; ?>
                      </span>
                      <span class="count-badge"><?php echo $subitem['total']; ?></span>
                    </label>
                  <?php endforeach; ?>
                </div>
              <?php else: ?>
                <?php if (($item_input == 'checkbox') || ($item_input == 'radio')): ?>
                  <div class="filter-<?php echo $item_input; ?>">
                    <?php foreach ($item['items'] as $subitem): ?>
                      <label>
                        <input type="<?php echo $item_input; ?>" data-filter-trigger name="<?php echo $item['key']; ?>" value="<?php echo $subitem['id']; ?>" <?php if ($subitem['checked']): ?>checked<?php endif; ?>>
                        <?php if (\Journal3\Utils\Arr::get($subitem, 'image')): ?>
                          <img src="<?php echo $subitem['image']; ?>" <?php if ($subitem['image2x']): ?>srcset="<?php echo $subitem['image']; ?> 1x, <?php echo $subitem['image2x']; ?> 2x" <?php endif; ?> width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $subitem['value']; ?>" title="<?php echo $subitem['value']; ?>" class="img-responsive" <?php if ($item['image_only']): ?>data-toggle="tooltip" data-tooltip-class="filter-tooltip-<?php echo $module_id; ?>" data-placement="top"<?php endif; ?>/>
                        <?php endif; ?>
                        <?php echo $j3->countBadge($subitem['value'], $subitem['total']); ?>
                      </label>
                    <?php endforeach; ?>
                  </div>
                <?php elseif ($item_input == 'select'): ?>
                  <div class="<?php echo $item_input; ?>">
                    <label>
                      <select name="<?php echo $item['key']; ?>" data-filter-trigger>
                        <option value=""></option>
                        <?php foreach ($item['items'] as $subitem): ?>
                          <option value="<?php echo $subitem['id']; ?>" <?php if ($subitem['checked']): ?>selected<?php endif; ?>><?php echo $subitem['total'] ? $subitem['value'] . ' (' . $subitem['total'] . ')' : $subitem['value']; ?></option>
                        <?php endforeach; ?>
                      </select>
                    </label>
                  </div>
                <?php endif; ?>
              <?php endif; ?>
            </div>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
  </div>
</div>
