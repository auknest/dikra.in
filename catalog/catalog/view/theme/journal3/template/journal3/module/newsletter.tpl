<div class="<?php echo $j3->classes($classes); ?>">
  <?php if ($title): ?>
    <h3 class="title module-title"><?php echo $title; ?></h3>
  <?php endif; ?>
  <div class="module-body">
    <?php if ($text): ?>
      <div class="newsletter-text"><?php echo $text; ?></div>
    <?php endif; ?>
    <div class="newsletter-form">
      <form action="<?php echo $action; ?>">
        <div class="input-group">
          <input type="text" name="email" placeholder="<?php echo $placeholder; ?>" class="form-control newsletter-email"/>
          <span class="input-group-btn">
              <button class="btn btn-primary" <?php if (($buttonType == "icon") && $tooltipStatus): ?>data-toggle="tooltip" data-tooltip-class="newsletter-tooltip-<?php echo $module_id; ?>" data-placement="<?php echo $tooltipPosition; ?>" title="<?php echo $tooltipText; ?>"<?php endif; ?> data-loading-text="<span><?php echo $buttonText; ?></span>"><span><?php echo $buttonText; ?></span></button>
            </span>
        </div>
        <?php if ($agree_data): ?>
          <div class="checkbox">
            <label>
              <input type="checkbox" name="agree" value="1"/>
              <?php echo $agree_data['text']; ?>
            </label>
          </div>
        <?php endif; ?>
      </form>
    </div>
  </div>
</div>
