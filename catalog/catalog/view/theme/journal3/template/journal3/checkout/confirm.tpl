<div class="checkout-section confirm-section">
  <div class="title section-title"><?php echo $j3->settings->get('sectionTitleConfirm'); ?></div>

  <div class="section-body">
    <div>
      <textarea class="form-control" v-model="order_data.comment" placeholder="<?php echo $text_comments; ?>"></textarea>
    </div>

    <?php if ($newsletter): ?>
      <div class="checkbox">
        <label><input v-model="newsletter" type="checkbox"/><?php echo $newsletter; ?></label>
      </div>
    <?php endif; ?>

    <?php if ($privacy): ?>
      <div class="checkbox">
        <label><input v-model="privacy" type="checkbox"/><?php echo $privacy; ?></label>
        <span class="text-danger" v-if="error && error.privacy" v-html="error.privacy"></span>
      </div>
    <?php endif; ?>

    <?php if ($agree): ?>
      <div class="checkbox">
        <label><input v-model="agree" type="checkbox"/><?php echo $agree; ?></label>
        <span class="text-danger" v-if="error && error.agree" v-html="error.agree"></span>
      </div>
    <?php endif; ?>

    <div class="buttons confirm-buttons">
      <div class="pull-right">
        <button type="button" v-on:click="save(true)" data-loading-text="<span><?php echo $j3->settings->get('confirmOrderLoadingText') ? $j3->settings->get('confirmOrderLoadingText') : $j3->settings->get('confirmOrderLanguage'); ?></span>" class="btn btn-primary" id="quick-checkout-button-confirm"><span><?php echo $j3->settings->get('confirmOrderLanguage'); ?></span></button>
      </div>
    </div>
  </div>
</div>
