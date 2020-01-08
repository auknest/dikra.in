<div class="checkout-section section-cvr" v-if="coupon_status || voucher_status || (reward_status && customer_id)">
  <div class="title section-title"><?php echo $j3->settings->get('sectionTitleCouponVoucherReward'); ?></div>

  <div class="section-body">
    <div class="form-group form-coupon" v-if="coupon_status">
      <label class="control-label" for="input-coupon"><?php echo $entry_coupon; ?></label>
      <div class="input-group">
        <input type="text" v-model="coupon" placeholder="<?php echo $entry_coupon; ?>" id="input-coupon" class="form-control"/>
        <span class="input-group-btn">
              <button type="button" v-on:click="save()" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><span><?php echo $button_submit; ?></span></button>
            </span>
      </div>
      <span class="text-danger" v-if="error && error.coupon" v-html="error.coupon"></span>
    </div>

    <div class="form-group form-voucher" v-if="voucher_status">
      <label class="control-label" for="input-voucher"><?php echo $entry_voucher; ?></label>
      <div class="input-group">
        <input type="text" v-model="voucher" placeholder="<?php echo $entry_voucher; ?>" id="input-voucher" class="form-control"/>
        <span class="input-group-btn">
              <button type="button" v-on:click="save()" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><span><?php echo $button_submit; ?></span></button>
            </span>
      </div>
      <span class="text-danger" v-if="error && error.voucher" v-html="error.voucher"></span>
    </div>

    <div class="form-group form-reward" v-if="reward_status && customer_id">
      <label class="control-label" for="input-reward"><?php echo $entry_reward; ?></label>
      <div class="input-group">
        <input type="text" v-model="reward" placeholder="<?php echo $entry_reward; ?>" id="input-reward" class="form-control"/>
        <span class="input-group-btn">
              <button type="button" v-on:click="save()" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><span><?php echo $button_submit; ?></span></button>
            </span>
      </div>
      <span class="text-danger" v-if="error && error.reward" v-html="error.reward"></span>
    </div>
  </div>
</div>
