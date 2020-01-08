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
<?php echo $j3->loadController('journal3/layout', 'bottom'); ?>

<?php if (!$j3->document->isPopup()): ?>
<footer class="top-row">
  <?php echo $footer_menu; ?>
</footer>

<?php endif; ?>
</div><!-- .site-wrapper -->

<?php echo $j3->loadController('journal3/layout', 'bottom_menu'); ?>

<?php echo $j3->loadController('journal3/layout', 'side_menu'); ?>

<?php echo $j3->loadController('journal3/layout', 'notification'); ?>

<?php foreach ($j3->document->getScripts('footer') as $script): ?>
<script src="<?php echo $j3->document->staticUrl($script, false); ?>" <?php if ($j3->settings->get('performanceJSDefer')): ?>defer<?php endif; ?>></script>
<?php endforeach; ?>

<?php if ($j3->canLiveReload()): ?>
<script src="http://<?php echo $j3->getHost(); ?>:35729/livereload.js?snipver=1" async></script>
<?php endif; ?>

<?php if ($j3->settings->get('customJS')): ?>
<script type="text/javascript"><?php echo $j3->settings->get('customJS'); ?></script>
<?php endif; ?>

<?php if (!$j3->document->isPopup() && $j3->settings->get('customCodeFooter')): ?>
<?php echo $j3->settings->get('customCodeFooter'); ?>
<?php endif; ?>

<?php if (!$j3->document->isPopup() && $j3->settings->get('scrollTop')): ?>
<div class="scroll-top">
  <i class="fa fa-angle-up"></i>
</div>
<?php endif; ?>

<?php if ($j3->document->hasFonts() && $j3->settings->get('performanceAsyncFontsStatus')): ?>
  <script>
    (function () {
      var wf = document.createElement('script');
      wf.src = 'https://ajax.googleapis.com/ajax/libs/webfont/1.6.26/webfont.js';
      wf.type = 'text/javascript';
      wf.async = 'true';
      var s = document.getElementsByTagName('script')[0];
      s.parentNode.insertBefore(wf, s);
    })();
  </script>
<?php endif; ?>

</body>
</html>
