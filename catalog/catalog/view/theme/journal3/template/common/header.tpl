<?php if (!isset($j3)): ?>
<style>
  body {
    display: none !important;
  }
</style>
<script>
  window.location = 'index.php?route=journal3/startup/error';
</script>
<?php endif; ?>
<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="<?php echo implode(' ', $j3->document->getClasses()); ?>" data-jv="<?php echo JOURNAL3_VERSION; ?>" data-ov="<?php echo VERSION; ?>">
<head typeof="og:website">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description): ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php endif; ?>
<?php if ($keywords): ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php endif; ?>
<?php if (!$j3->document->isPopup()): ?>
<?php foreach ($j3->loadController('journal3/seo/meta_tags') as $key => $tag): ?>
<meta <?php echo $tag['type']; ?>="<?php echo $key; ?>" content="<?php echo $tag['content']; ?>"/>
<?php endforeach; ?>
<?php endif; ?>
<script>window['Journal'] = <?php echo json_encode($j3->document->getJs()); ?>;</script>
<?php if (!$j3->document->isPopup()): ?>
<script><?php echo $j3->loadController('journal3/mql'); ?></script>
<?php endif; ?>
<?php if ($j3->document->hasFonts()): ?>
<?php if ($j3->settings->get('performanceAsyncFontsStatus')): ?>
<script>WebFontConfig = { google: { families: <?php echo $j3->document->getFonts(true); ?> } };</script>
<?php else: ?>
<link href="https://fonts.googleapis.com/css?family=<?php echo $j3->document->getFonts(false); ?>" type="text/css" rel="stylesheet"/>
<?php endif; ?>
<?php endif; ?>
<?php foreach ($j3->document->getStyles($styles) as $style): ?>
<?php if (isset($style['content'])): ?>
<style><?php echo $style['content']; ?></style>
<?php else: ?>
<link href="<?php echo $j3->document->staticUrl($style['href'], false); ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="all" />
<?php endif; ?>
<?php endforeach; ?>
<?php foreach ($links as $link): ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php endforeach; ?>
<?php foreach ($analytics as $analytic): ?>
<?php echo $analytic; ?>
<?php endforeach; ?>
<style><?php echo $j3->document->getCss(); ?></style>
<?php if ($j3->settings->get('customCSS')): ?>
<style><?php echo $j3->settings->get('customCSS'); ?></style>
<?php endif; ?>
<?php foreach ($j3->document->getScripts('header', $scripts) as $script): ?>
<script src="<?php echo $j3->document->staticUrl($script, false); ?>" <?php if ($j3->settings->get('performanceJSDefer')): ?>defer<?php endif; ?>></script>
<?php endforeach; ?>
<?php if ($j3->settings->get('customCodeHeader')): ?>
<?php echo $j3->settings->get('customCodeHeader'); ?>
<?php endif; ?>
</head>
<body class="<?php echo $class; ?>" <?php if ($j3->document->isMobile()): ?>ontouchstart<?php endif; ?>>

<?php if ($j3->settings->get('oldBrowserStatus')): ?>
<div class="old-browser">
  <div class="ob-content">
    <h2 class="ob-title"><?php echo $j3->settings->get('oldBrowserTitle'); ?></h2>
    <span class="ob-text"><?php echo $j3->settings->get('oldBrowserText'); ?></span>
    <div class="ob-links">
      <a href="https://www.google.com/chrome/" target="_blank" rel="nofollow">
        <img src="<?php echo $j3->settings->get('oldBrowserChrome'); ?>" alt="Chrome" />
        <span class="ob-name">Chrome</span>
      </a>
      <a href="https://www.mozilla.org/firefox/new/" target="_blank" rel="nofollow">
        <img src="<?php echo $j3->settings->get('oldBrowserFirefox'); ?>" alt="Firefox" />
        <span class="ob-name">Firefox</span>
      </a>
      <a href="https://www.microsoft.com/en-us/windows/microsoft-edge" target="_blank" rel="nofollow">
        <img src="<?php echo $j3->settings->get('oldBrowserEdge'); ?>" alt="edge" />
        <span class="ob-name">Microsoft Edge</span>
      </a>
      <a href="https://www.opera.com/" target="_blank" rel="nofollow">
        <img src="<?php echo $j3->settings->get('oldBrowserOpera'); ?>" alt="opera" />
        <span class="ob-name">Opera</span>
      </a>
      <a href="https://www.apple.com/lae/safari/" target="_blank" rel="nofollow">
        <img src="<?php echo $j3->settings->get('oldBrowserSafari'); ?>" alt="safari" />
        <span class="ob-name">Safari on Mac</span>
      </a>
    </div>
  </div>
</div>
<?php endif; ?>

<?php if (!$j3->document->isPopup()): ?>
  <div class="mobile-container mobile-main-menu-container">
    <div class="mobile-wrapper-header">
      <span><?php echo $j3->settings->get('headerMobileMenuTitle'); ?></span>
        <?php if($j3->settings->get('mobileLangPosition') === 'menu'): ?>
            <div class="language-currency top-menu">
                <div class="mobile-currency-wrapper">
                    <?php echo $j3->document->hasClass('mobile-header-active') ? $currency : ''; ?>
                </div>
                <div class="mobile-language-wrapper">
                    <?php echo $j3->document->hasClass('mobile-header-active') ? $language : ''; ?>
                </div>
            </div>
        <?php endif; ?>
      <a class="x"></a>
    </div>
    <div class="mobile-main-menu-wrapper">
      <?php echo $j3->document->isPhone() || ($j3->document->isTablet() && $j3->settings->get('mobileHeaderOn') == 'tablet') ? $j3->settings->get('mobile_main_menu') : ''; ?>
    </div>
  </div>

  <div class="mobile-container mobile-filter-container">
    <div class="mobile-wrapper-header"></div>
    <div class="mobile-filter-wrapper"></div>
  </div>

  <div class="mobile-container mobile-cart-content-container">
    <div class="mobile-wrapper-header">
      <span><?php echo $j3->settings->get('headerMobileCartTitle'); ?></span>
      <a class="x"></a>
    </div>
    <div class="mobile-cart-content-wrapper cart-content"></div>
  </div>
<?php endif; ?>

<?php echo $j3->loadController('journal3/layout', 'popup'); ?>

<div class="site-wrapper">

  <?php echo $j3->loadController('journal3/layout', 'header_notice'); ?>

  <?php if (!$j3->document->isPopup() && ($j3->settings->get('headerType') || $j3->settings->get('mobileHeaderType'))): ?>
    <header class="header-<?php echo $j3->settings->get('headerType'); ?>">
      <?php if (!$j3->document->hasClass('mobile-header-active') && $j3->settings->get('headerType')): ?>
        <?php include($j3->incl('journal3/headers/desktop/' . $j3->settings->get('headerType') . '.tpl')); ?>
      <?php endif; ?>
      <?php if ($j3->settings->get('mobileHeaderType')): ?>
        <?php include($j3->incl('journal3/headers/mobile/header_mobile_' . $j3->settings->get('mobileHeaderType') . '.tpl')); ?>
      <?php endif; ?>
    </header>
  <?php endif; ?>

  <?php echo $j3->loadController('journal3/layout', 'fullscreen_slider'); ?>
