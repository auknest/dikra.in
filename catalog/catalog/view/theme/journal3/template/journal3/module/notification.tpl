<div class="notification-wrapper notification-wrapper-bottom">
  <div class="<?php echo $j3->classes($classes); ?>" data-options='<?php echo json_encode($options, JSON_FORCE_OBJECT); ?>'>
    <button class="btn notification-close"><?php echo $notificationCloseText; ?></button>
    <div class="notification-content">
      <div>
        <div class="notification-title"><?php echo $title; ?></div>
        <div class="notification-text"><?php echo $text; ?></div>
      </div>
    </div>
  </div>
</div>
