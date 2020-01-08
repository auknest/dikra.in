<form class="form-horizontal" id="form-review">
  <div id="review"></div>
  <?php if ($review_status): ?>
  <h4><?php echo $text_write; ?></h4>
  <?php if ($review_guest): ?>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
      <div class="col-sm-10">
        <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name" class="form-control" />
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-review"><?php echo $entry_review; ?></label>
      <div class="col-sm-10">
        <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
        <div class="help-block"><?php echo $text_note; ?></div>
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label"><?php echo $entry_rating; ?></label>

      <div class="col-sm-10 rate">
        <span><?php echo $entry_bad; ?></span>
        <input type="radio" name="rating" value="1" />

        <input type="radio" name="rating" value="2" />

        <input type="radio" name="rating" value="3" />

        <input type="radio" name="rating" value="4" />

        <input type="radio" name="rating" value="5" />
        <span><?php echo $entry_good; ?></span>
      </div>
    </div>
    <?php echo $captcha; ?>
    <div class="buttons clearfix">
      <div class="pull-right">
        <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
      </div>
    </div>
  <?php else: ?>
    <?php echo $text_login; ?>
  <?php endif; ?>
  <?php endif; ?>
</form>
