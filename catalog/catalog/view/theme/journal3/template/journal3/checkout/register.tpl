<div class="checkout-section section-register" v-if="!customer_id">
  <div class="title section-title"><?php echo $j3->settings->get('sectionTitlePersonal'); ?></div>
  <div class="section-body">
    <div class="form-group account-customer-group" style="display: <?php if (count($customer_groups) > 1): ?>block<?php else: ?>none<?php endif; ?>;">
      <label class="control-label"><?php echo $entry_customer_group; ?></label>
      <?php foreach ($customer_groups as $customer_group): ?>
        <div class="radio">
          <label>
            <input v-model="order_data.customer_group_id" v-on:change="save()" type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked"/>
            <?php echo $customer_group['name']; ?></label>
        </div>
      <?php endforeach; ?>
    </div>

    <?php /* customer firstname */ ?>

    <div class="form-group required account-firstname">
      <label class="control-label" for="input-firstname"><?php echo $entry_firstname; ?></label>
      <input v-model="order_data.payment_firstname" v-on:blur="checkSave()" v-on:change="change()" type="text" name="firstname" value="" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="form-control"/>
      <span class="text-danger" v-if="error && error.payment_firstname" v-html="error.payment_firstname"></span>
    </div>

    <?php /* customer lastname */ ?>

    <div class="form-group required account-lastname">
      <label class="control-label" for="input-lastname"><?php echo $entry_lastname; ?></label>
      <input v-model="order_data.payment_lastname" v-on:blur="checkSave()" v-on:change="change()" type="text" name="lastname" value="" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="form-control"/>
      <span class="text-danger" v-if="error && error.payment_lastname" v-html="error.payment_lastname"></span>
    </div>

    <?php /* customer email */ ?>

    <div class="form-group required account-email">
      <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
      <input v-model="order_data.email" v-on:blur="checkSave()" v-on:change="change()" type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control"/>
      <span class="text-danger" v-if="error && error.email" v-html="error.email"></span>
    </div>

    <?php /* customer telephone */ ?>

    <div class="form-group required account-telephone">
      <label class="control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
      <input v-model="order_data.telephone" v-on:blur="checkSave()" v-on:change="change()" type="text" name="telephone" value="" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control"/>
      <span class="text-danger" v-if="error && error.telephone" v-html="error.telephone"></span>
    </div>

    <?php /* customer fax */ ?>

    <div class="form-group account-fax">
      <label class="control-label" for="input-fax"><?php echo $entry_fax; ?></label>
      <input v-model="order_data.fax" v-on:blur="checkSave()" v-on:change="change()" type="text" name="fax" value="" placeholder="<?php echo $entry_fax; ?>" id="input-fax" class="form-control"/>
      <span class="text-danger" v-if="error && error.fax" v-html="error.fax"></span>
    </div>

    <?php /* customer password */ ?>

    <div v-if="account === 'register'" class="form-group required account-pass">
      <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
      <input v-model="password" type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control"/>
      <span class="text-danger" v-if="error && error.password" v-html="error.password"></span>
    </div>

    <div v-if="account === 'register'" class="form-group required account-pass2">
      <label class="control-label" for="input-confirm"><?php echo $entry_confirm; ?></label>
      <input v-model="password2" type="password" name="confirm" value="" placeholder="<?php echo $entry_confirm; ?>" id="input-confirm" class="form-control"/>
      <span class="text-danger" v-if="error && error.password2" v-html="error.password2"></span>
    </div>

    <?php /* custom fields - select */ ?>

    <div v-for="custom_field in custom_fields.custom_fields.account" v-if="custom_field.type === 'select'" v-bind:id="'account-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
      <label class="control-label" v-bind:for="'input-account-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
      <select v-model="order_data.custom_field[custom_field.custom_field_id]" v-on:change="save()" v-bind:id="'input-account-custom-field' + custom_field.custom_field_id" class="form-control">
        <option value=""><?php echo $text_select; ?></option>
        <option v-for="custom_field_value in custom_field.custom_field_value" v-bind:value="custom_field_value.custom_field_value_id" v-html="custom_field_value.name"></option>
      </select>
      <span class="text-danger" v-if="error && error.custom_field && error.custom_field[custom_field.custom_field_id]" v-html="error.custom_field[custom_field.custom_field_id]"></span>
    </div>

    <?php /* custom fields - radio */ ?>

    <div v-for="custom_field in custom_fields.custom_fields.account" v-if="custom_field.type === 'radio'" v-bind:id="'account-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
      <label class="control-label" v-html="custom_field.name"></label>
      <div v-bind:id="'input-account-custom-field' + custom_field.custom_field_id">
        <div class="radio" v-for="custom_field_value in custom_field.custom_field_value">
          <label>
            <input type="radio" v-model="order_data.custom_field[custom_field.custom_field_id]" v-on:change="save()" v-bind:value="custom_field_value.custom_field_value_id"/>
            <span v-html="custom_field_value.name"></span></label>
        </div>
      </div>
      <span class="text-danger" v-if="error && error.custom_field && error.custom_field[custom_field.custom_field_id]" v-html="error.custom_field[custom_field.custom_field_id]"></span>
    </div>

    <?php /* custom fields - checkbox */ ?>

    <div v-for="custom_field in custom_fields.custom_fields.account" v-if="custom_field.type === 'checkbox'" v-bind:id="'account-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
      <label class="control-label" v-html="custom_field.name"></label>
      <div v-bind:id="'input-account-custom-field' + custom_field.custom_field_id">
        <div class="checkbox" v-for="custom_field_value in custom_field.custom_field_value">
          <label>
            <input type="checkbox" v-model="order_data.custom_field[custom_field.custom_field_id]" v-on:change="save()" v-bind:value="custom_field_value.custom_field_value_id"/>
            <span v-html="custom_field_value.name"></span></label>
        </div>
      </div>
      <span class="text-danger" v-if="error && error.custom_field && error.custom_field[custom_field.custom_field_id]" v-html="error.custom_field[custom_field.custom_field_id]"></span>
    </div>

    <?php /* custom fields - text */ ?>

    <div v-for="custom_field in custom_fields.custom_fields.account" v-if="custom_field.type === 'text'" v-bind:id="'account-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
      <label class="control-label" v-bind:for="'input-account-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
      <input type="text" v-model="order_data.custom_field[custom_field.custom_field_id]" v-on:blur="checkSave()" v-on:change="change()" value="" v-bind:placeholder="custom_field.name" v-bind:id="'input-account-custom-field' + custom_field.custom_field_id" class="form-control"/>
      <span class="text-danger" v-if="error && error.custom_field && error.custom_field[custom_field.custom_field_id]" v-html="error.custom_field[custom_field.custom_field_id]"></span>
    </div>

    <?php /* custom fields - textarea */ ?>

    <div v-for="custom_field in custom_fields.custom_fields.account" v-if="custom_field.type === 'textarea'" v-bind:id="'account-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
      <label class="control-label" v-bind:for="'input-account-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
      <textarea v-model="order_data.custom_field[custom_field.custom_field_id]" v-on:blur="checkSave()" v-on:change="change()" rows="5" v-bind:placeholder="custom_field.name" v-bind:id="'input-account-custom-field' + custom_field.custom_field_id" class="form-control"></textarea>
      <span class="text-danger" v-if="error && error.custom_field && error.custom_field[custom_field.custom_field_id]" v-html="error.custom_field[custom_field.custom_field_id]"></span>
    </div>

    <?php /* custom fields - file */ ?>

<!--    <div v-for="custom_field in custom_fields.custom_fields.account" v-if="custom_field.type === 'file'" v-bind:id="'account-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">-->
<!--      <label class="control-label" v-html="custom_field.name"></label>-->
<!--      <br/>-->
<!--      <button type="button" id="button-account-custom-field--><?php //echo $custom_field['custom_field_id']; ?><!--" data-loading-text="--><?php //echo $text_loading; ?><!--" class="btn btn-default"><i class="fa fa-upload"></i> --><?php //echo $button_upload; ?><!--</button>-->
<!--      <input type="hidden" v-model="order_data.custom_field[custom_field.custom_field_id]" v-on:change="save()" value="" v-bind:id="'input-account-custom-field' + custom_field.custom_field_id"/>-->
<!--      <span class="text-danger" v-if="error && error.custom_field && error.custom_field[custom_field.custom_field_id]" v-html="error.custom_field[custom_field.custom_field_id]"></span>-->
<!--    </div>-->

    <?php /* custom fields - date */ ?>

    <div v-for="custom_field in custom_fields.custom_fields.account" v-if="custom_field.type === 'date'" v-bind:id="'account-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
      <label class="control-label" v-bind:for="'input-account-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
      <div class="input-group date">
        <input type="text" v-model="order_data.custom_field[custom_field.custom_field_id]" v-on:change="saveDateTime('custom_field', custom_field.custom_field_id, $event)" value="" v-bind:placeholder="custom_field.name" data-date-format="YYYY-MM-DD" v-bind:id="'input-account-custom-field' + custom_field.custom_field_id" class="form-control"/>
        <span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>
      </div>
      <span class="text-danger" v-if="error && error.custom_field && error.custom_field[custom_field.custom_field_id]" v-html="error.custom_field[custom_field.custom_field_id]"></span>
    </div>

    <?php /* custom fields - time */ ?>

    <div v-for="custom_field in custom_fields.custom_fields.account" v-if="custom_field.type === 'time'" v-bind:id="'account-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
      <label class="control-label" v-bind:for="'input-account-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
      <div class="input-group time">
        <input type="text" v-model="order_data.custom_field[custom_field.custom_field_id]" v-on:change="saveDateTime('custom_field', custom_field.custom_field_id, $event)" value="" v-bind:placeholder="custom_field.name" data-date-format="HH:mm" v-bind:id="'input-account-custom-field' + custom_field.custom_field_id" class="form-control"/>
        <span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>
      </div>
      <span class="text-danger" v-if="error && error.custom_field && error.custom_field[custom_field.custom_field_id]" v-html="error.custom_field[custom_field.custom_field_id]"></span>
    </div>

    <?php /* custom fields - datetime */ ?>

    <div v-for="custom_field in custom_fields.custom_fields.account" v-if="custom_field.type === 'datetime'" v-bind:id="'account-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
      <label class="control-label" v-bind:for="'input-account-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
      <div class="input-group datetime">
        <input type="text" v-model="order_data.custom_field[custom_field.custom_field_id]" v-on:change="saveDateTime('custom_field', custom_field.custom_field_id, $event)" value="" v-bind:placeholder="custom_field.name" data-date-format="YYYY-MM-DD HH:mm" v-bind:id="'input-account-custom-field' + custom_field.custom_field_id" class="form-control"/>
        <span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>
      </div>
      <span class="text-danger" v-if="error && error.custom_field && error.custom_field[custom_field.custom_field_id]" v-html="error.custom_field[custom_field.custom_field_id]"></span>
    </div>
  </div>
</div>
