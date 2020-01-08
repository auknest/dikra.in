<div class="mobile-header mobile-default mobile-1">
  <div class="mobile-top-bar">
    <div class="mobile-top-menu-wrapper">
      <?php echo $j3->settings->get('mobile_top_menu'); ?>
    </div>
    <?php if($j3->settings->get('mobileLangPosition') === 'top'): ?>
    <div class="language-currency top-menu">
      <div class="mobile-currency-wrapper">
        <?php echo $j3->document->hasClass('mobile-header-active') ? $currency : ''; ?>
      </div>
      <div class="mobile-language-wrapper">
        <?php echo $j3->document->hasClass('mobile-header-active') ? $language : ''; ?>
      </div>
    </div>
    <?php endif; ?>
  </div>
  <div class="mobile-bar sticky-bar">
    <div class="mobile-logo-wrapper">
      <?php if ($j3->document->hasClass('mobile-header-active')): ?>
        <div id="logo">
          <?php if ($j3->settings->get('logo_src')): ?>
            <a href="<?php echo $home; ?>">
              <img src="<?php echo $j3->settings->get('logo_src'); ?>" <?php if ($j3->settings->get('logo2x_src')): ?>srcset="<?php echo $j3->settings->get('logo_src'); ?> 1x, <?php echo $j3->settings->get('logo2x_src'); ?> 2x"<?php endif; ?> width="<?php echo $j3->settings->get('logo_width'); ?>" height="<?php echo $j3->settings->get('logo_height'); ?>" alt="<?php echo $name; ?>" title="<?php echo $name; ?>"/>
            </a>
          <?php else: ?>
            <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
          <?php endif; ?>
        </div>
      <?php endif; ?>
    </div>
    <div class="mobile-bar-group">
      <div class="menu-trigger">
        <button><span>Menu</span></button>
      </div>
      <?php if ($j3->settings->get('mobileCustomMenuStatus1')): ?>
      <a class="mobile-custom-menu mobile-custom-menu-1" href="<?php echo $j3->settings->get('mobileCustomMenuLink1.href'); ?>"<?php echo $j3->linkAttrs($j3->settings->get('mobileCustomMenuLink1.attrs')); ?>>
        <?php echo $j3->countBadge($j3->settings->get('mobileCustomMenuLink1.name'), $j3->cache->update($j3->settings->get('mobileCustomMenuLink1.total')), $j3->settings->get('mobileCustomMenuLink1.classes')); ?>
      </a>
      <?php endif; ?>
      <?php if ($j3->settings->get('mobileCustomMenuStatus2')): ?>
      <a class="mobile-custom-menu mobile-custom-menu-2" href="<?php echo $j3->settings->get('mobileCustomMenuLink2.href'); ?>"<?php echo $j3->linkAttrs($j3->settings->get('mobileCustomMenuLink2.attrs')); ?>>
        <?php echo $j3->countBadge($j3->settings->get('mobileCustomMenuLink2.name'), $j3->cache->update($j3->settings->get('mobileCustomMenuLink2.total')), $j3->settings->get('mobileCustomMenuLink2.classes')); ?>
      </a>
      <?php endif; ?>
      <div class="mobile-search-wrapper mini-search">
        <?php echo $j3->document->hasClass('mobile-header-active') ? $search : ''; ?>
      </div>
      <div class="mobile-cart-wrapper mini-cart">
        <?php echo $j3->document->hasClass('mobile-header-active') ? $cart : ''; ?>
      </div>
    </div>
  </div>
</div>
