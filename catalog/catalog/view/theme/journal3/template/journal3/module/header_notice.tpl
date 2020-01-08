<div class="notice-module <?php echo $j3->classes($classes); ?>" data-options='<?php echo json_encode($options, JSON_FORCE_OBJECT); ?>'>
  <div class="module-body">
    <div class="hn-body">
      <div class="hn-content"><?php echo $content; ?></div>
      <?php if ($closeButton): ?>
        <div class="header-notice-close-button">
          <button class="btn hn-close">
            <?php if ($closeText): ?>
              <span class="btn-text"><?php echo $closeText; ?></span>
            <?php endif; ?>
          </button>
        </div>
      <?php endif; ?>
    </div>
  </div>
</div>
