<div class="header header-compact header-sm">
  <div class="top-bar navbar-nav">
    <?php echo $j3->settings->get('desktop_top_menu'); ?>
    <?php if ($j3->settings->get('langPosition') == 'top'): ?>
    <div class="language-currency top-menu">
      <div class="desktop-language-wrapper">
        <?php echo $language; ?>
      </div>
      <div class="desktop-currency-wrapper">
        <?php echo $currency; ?>
      </div>
    </div>
    <?php endif; ?>
    <?php echo $j3->settings->get('desktop_top_menu_3'); ?>
    <?php if ($j3->settings->get('secondaryMenuPosition') == 'top'): ?>
      <div class="top-menu secondary-menu"><?php echo $j3->settings->get('desktop_top_menu_2'); ?></div>
    <?php endif; ?>
  </div>
  <div class="mid-bar navbar-nav">
    <div class="desktop-main-menu-wrapper">
      <?php echo $j3->document->hasClass('mobile-header-active') ? '' : $j3->settings->get('desktop_main_menu'); ?>
    </div>
    <div class="desktop-logo-wrapper">
      <div id="logo">
        <?php if ($j3->settings->get('logo_src')): ?>
          <a href="<?php echo $home; ?>">
            <img src="<?php echo $j3->settings->get('logo_src'); ?>" <?php if ($j3->settings->get('logo2x_src')): ?>srcset="<?php echo $j3->settings->get('logo_src'); ?> 1x, <?php echo $j3->settings->get('logo2x_src'); ?> 2x"<?php endif; ?> width="<?php echo $j3->settings->get('logo_width'); ?>" height="<?php echo $j3->settings->get('logo_height'); ?>" alt="<?php echo $name; ?>" title="<?php echo $name; ?>"/>
          </a>
        <?php else: ?>
          <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
        <?php endif; ?>
      </div>
    </div>
    <div class="desktop-search-wrapper full-search">
      <?php echo $search; ?>
    </div>

    <div class="header-cart-group">
      <?php if ($j3->settings->get('langPosition') == 'search'): ?>
        <div class="language-currency top-menu">
          <div class="desktop-language-wrapper">
            <?php echo $language; ?>
          </div>
          <div class="desktop-currency-wrapper">
            <?php echo $currency; ?>
          </div>
        </div>
      <?php endif; ?>
      <?php if ($j3->settings->get('secondaryMenuPosition') == 'cart'): ?>
        <div class="top-menu secondary-menu"><?php echo $j3->settings->get('desktop_top_menu_2'); ?></div>
      <?php endif; ?>
      <div class="desktop-cart-wrapper">
        <?php echo $cart; ?>
      </div>
    </div>
  </div>
</div>
