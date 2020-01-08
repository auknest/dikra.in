<div class="checkout-section section-login" v-if="!customer_id">
  <div class="title section-title"><?php echo $j3->settings->get('sectionTitleLogin'); ?></div>
  <div class="section-body">
    
              
                <div class="form-group login-options hidden">
			
      <div class="radio">
        <label><input v-model="account" type="radio" name="account" value=""/><?php echo $j3->settings->get('sectionLoginText'); ?></label>
      </div>
      <div class="radio">
        <label><input v-model="account" type="radio" name="account" value="register"/><?php echo $j3->settings->get('sectionRegisterText'); ?></label>
      </div>
      <div class="radio" v-if="guest">
        <label><input v-model="account" type="radio" name="account" value="guest"/><?php echo $j3->settings->get('sectionGuestText'); ?></label>
      </div>
    </div>
    <div class="login-form">
      <div v-if="account === ''" class="form-group">
        <label class="control-label" for="input-login-email"><?php echo $entry_email; ?></label>
        <input type="text" v-model="login_email" placeholder="<?php echo $entry_email; ?>" id="input-login-email" class="form-control"/>
      </div>
      <div v-if="account === ''" class="form-group">
        <label class="control-label" for="input-login-password"><?php echo $entry_password; ?></label>
        <input type="password" v-model="login_password" placeholder="<?php echo $entry_password; ?>" id="input-login-password" class="form-control"/>
        <div><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></div>
      </div>
      <div class="buttons" v-if="account === ''">

              
              <div class="pull-right">
            <a class="btn btn-primary" href="javascript:open_register_popup()"><span class="links-text">Register</span></a>
        </div>
			
        <div class="pull-right">
          <button type="button" id="button-login" v-on:click="login()" data-loading-text="<span><?php echo $button_login; ?></span>" class="btn btn-primary"><span><?php echo $button_login; ?></span></button>
        </div>
      </div>
    </div>
  </div>
</div>
