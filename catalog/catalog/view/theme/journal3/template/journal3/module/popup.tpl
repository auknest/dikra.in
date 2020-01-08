<?php if ($iframe): ?>
  <?php if ($contentType === 'image'): ?>
    <div class="popup-content">
      <img src="<?php echo $image; ?>" alt="" width="<?php echo $imageDimensions['width']; ?>" height="<?php echo $imageDimensions['height']; ?>"/>
    </div>
  <?php elseif ($contentType === 'text'): ?>
    <div class="popup-content">
      <?php echo $text; ?>
    </div>
  <?php else: ?>
    <?php echo $content; ?>
  <?php endif; ?>
<?php else: ?>
  <div class="popup-wrapper <?php echo $j3->classes($classes); ?>" data-options='<?php echo json_encode($options, JSON_FORCE_OBJECT); ?>'>
    <div class="popup-container">
      <?php if ($closeButton): ?>
        <button class="btn popup-close"></button>
      <?php endif; ?>
      <div class="popup-body">
        <div class="popup-inner-body">
          <?php if ($headerText): ?>
            <div class="title popup-header"><?php echo $headerText; ?></div>
          <?php endif; ?>

          <?php if ($ajax && $contentType === 'grid'): ?>
            <div class="journal-loading"><i class="fa fa-spinner fa-spin"></i></div>
            <iframe src="index.php?route=journal3/popup/page&module_id=<?php echo $module_id; ?>&popup=module" width="100%" height="100%" frameborder="0" onload="$(this).prev('.journal-loading').fadeOut();"></iframe>
          <?php elseif ($contentType === 'image'): ?>
            <div class="popup-content">
              <img src="<?php echo $image; ?>" alt="" width="<?php echo $imageDimensions['width']; ?>" height="<?php echo $imageDimensions['height']; ?>"/>
            </div>
          <?php elseif ($contentType === 'text'): ?>
            <div class="popup-content">
              <?php echo $text; ?>
            </div>
          <?php else: ?>
            <?php echo $content; ?>
          <?php endif; ?>

          <?php if ($footer): ?>
            <div class="popup-footer">
              <?php if ($button1 || $button2): ?>
                <div class="popup-buttons">
                  <?php if ($button1): ?>
                    <a class="btn btn-popup btn-popup-1"<?php if ($button1Link['href']): ?> href="<?php echo $button1Link['href']; ?>"<?php endif; ?>><span class="btn-text"><?php echo $button1Text; ?></span></a>
                  <?php endif; ?>

                  <?php if ($button2): ?>
                    <a class="btn btn-popup btn-popup-2"<?php if ($button2Link['href']): ?> href="<?php echo $button2Link['href']; ?>"<?php endif; ?>><span class="btn-text"><?php echo $button2Text; ?></span></a>
                  <?php endif; ?>
                </div>
              <?php endif; ?>
              <?php if (!$ajax && $doNotShowAgain): ?>
                <label class="popup-dont-show">
                  <input type="checkbox"/>
                  <span><?php echo $doNotShowAgainText; ?></span>
                </label>
              <?php endif; ?>
            </div>
          <?php endif; ?>
        </div>
      </div>
    </div>
    <div class="popup-bg <?php if ($closeButton): ?>popup-bg-closable<?php endif; ?>"></div>
  </div>
<?php endif; ?>
