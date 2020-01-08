<div class="checkout-section <?php echo $type; ?>-address" v-if="('<?php echo $type; ?>' === 'payment') || (('<?php echo $type; ?>' === 'shipping') && !same_address && shipping_required)">
  <div class="title section-title" v-html="'<?php echo $type; ?>' === 'payment' ? '<?php echo $j3->settings->get('sectionTitlePaymentAddress'); ?>' : '<?php echo $j3->settings->get('sectionTitleShippingAddress'); ?>'"></div>
  <div class="section-body">
    <div class="radio" v-if="customer_id && Object.keys(addresses).length">
      <label>
        <input type="radio" v-model="<?php echo $type; ?>_address_type" v-on:change="save()" value="existing"/>
        <?php echo $text_address_existing; ?></label>
    </div>

    <div id="<?php echo $type; ?>-existing" v-if="customer_id && (<?php echo $type; ?>_address_type === 'existing')">
      <select v-model="order_data.<?php echo $type; ?>_address_id" v-on:change="save()" id="input-<?php echo $type; ?>-address" class="form-control">
        <option v-for="address in addresses" v-bind:value="address.address_id" v-html="address.firstname + ' ' + address.lastname + ' ' + address.address_1 + ' ' + address.city + ' ' + address.zone + ' ' + address.country"></option>
      </select>
    </div>

    <div class="radio" v-if="customer_id && Object.keys(addresses).length">
      <label>
        <input type="radio" v-model="<?php echo $type; ?>_address_type" v-on:change="save()" value="new"/>
        <?php echo $text_address_new; ?></label>
    </div>

    <div v-if="!customer_id || (customer_id && (<?php echo $type; ?>_address_type === 'new'))">
      <div class="form-group required address-firstname" v-if="customer_id || (!customer_id && '<?php echo $type; ?>' === 'shipping')">
        <label class="control-label" for="input-<?php echo $type; ?>-firstname"><?php echo $entry_firstname; ?></label>
        <input v-model="order_data.<?php echo $type; ?>_firstname" v-on:blur="checkSave()" v-on:change="change()" type="text" name="firstname" value="" placeholder="<?php echo $entry_firstname; ?>" id="input-<?php echo $type; ?>-firstname" class="form-control"/>
      </div>

      <div class="form-group required address-lastname" v-if="customer_id || (!customer_id && '<?php echo $type; ?>' === 'shipping')">
        <label class="control-label" for="input-<?php echo $type; ?>-lastname"><?php echo $entry_lastname; ?></label>
        <input v-model="order_data.<?php echo $type; ?>_lastname" v-on:blur="checkSave()" v-on:change="change()" type="text" name="lastname" value="" placeholder="<?php echo $entry_lastname; ?>" id="input-<?php echo $type; ?>-lastname" class="form-control"/>
      </div>

      <div class="form-group address-company">
        <label class="control-label" for="input-<?php echo $type; ?>-company"><?php echo $entry_company; ?></label>
        <input v-model="order_data.<?php echo $type; ?>_company" v-on:blur="checkSave()" v-on:change="change()" type="text" name="company" value="" placeholder="<?php echo $entry_company; ?>" id="input-<?php echo $type; ?>-company" class="form-control"/>
      </div>

      <div class="form-group required address-address-1">
        <label class="control-label" for="input-<?php echo $type; ?>-address-1"><?php echo $entry_address_1; ?></label>
        <input v-model="order_data.<?php echo $type; ?>_address_1" v-on:blur="checkSave()" v-on:change="change()" type="text" name="address_1" value="" placeholder="<?php echo $entry_address_1; ?>" id="input-<?php echo $type; ?>-address-1" class="form-control"/>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_address_1" v-html="error.<?php echo $type; ?>_address_1"></span>
      </div>

      <div class="form-group required address-address-2">
        <label class="control-label" for="input-<?php echo $type; ?>-address-2"><?php echo $entry_address_2; ?></label>
        <input v-model="order_data.<?php echo $type; ?>_address_2" v-on:blur="checkSave()" v-on:change="change()" type="text" name="address_2" value="" placeholder="<?php echo $entry_address_2; ?>" id="input-<?php echo $type; ?>-address-2" class="form-control"/>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_address_2" v-html="error.<?php echo $type; ?>_address_2"></span>
      </div>

      <div class="form-group required address-city">
        <label class="control-label" for="input-<?php echo $type; ?>-city"><?php echo $entry_city; ?></label>
        <input v-model="order_data.<?php echo $type; ?>_city" v-on:blur="checkSave()" v-on:change="change()" type="text" name="city" value="" placeholder="<?php echo $entry_city; ?>" id="input-<?php echo $type; ?>-city" class="form-control"/>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_city" v-html="error.<?php echo $type; ?>_city"></span>
      </div>

      <div class="form-group required address-postcode">
        <label class="control-label" for="input-<?php echo $type; ?>-postcode"><?php echo $entry_postcode; ?></label>
        <input v-model="order_data.<?php echo $type; ?>_postcode" v-on:blur="checkSave()" v-on:change="change()" type="text" name="postcode" value="" placeholder="<?php echo $entry_postcode; ?>" id="input-<?php echo $type; ?>-postcode" class="form-control"/>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_postcode" v-html="error.<?php echo $type; ?>_postcode"></span>
      </div>

      <div class="form-group required address-country">
        <label class="control-label" for="input-<?php echo $type; ?>-country"><?php echo $entry_country; ?></label>
        <select v-model="order_data.<?php echo $type; ?>_country_id" v-on:change="save()" name="country_id" id="input-<?php echo $type; ?>-country" class="form-control">
          <option value=""><?php echo $text_select; ?></option>
          <option v-for="country in countries" v-bind:value="country.country_id" v-html="country.name"></option>
        </select>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_country" v-html="error.<?php echo $type; ?>_country"></span>
      </div>

      <div class="form-group required address-zone">
        <label class="control-label" for="input-<?php echo $type; ?>-zone"><?php echo $entry_zone; ?></label>
        
        <select v-model="order_data.<?php echo $type; ?>_zone_id" v-on:change="save()" name="zone_id" id="input-<?php echo $type; ?>-zone" class="form-control" style="max-width:500px">

          <option v-if="<?php echo $type; ?>_zones.length > 0" value=""><?php echo $text_select; ?></option>
          <option v-if="<?php echo $type; ?>_zones.length == 0" value=""><?php echo $text_none; ?></option>
          <option v-for="zone in <?php echo $type; ?>_zones" v-bind:value="zone.zone_id" v-html="zone.name"></option>
        </select>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_zone" v-html="error.<?php echo $type; ?>_zone"></span>
      </div>

      <?php /* custom fields - select */ ?>

      <div v-for="custom_field in custom_fields.custom_fields.address" v-if="custom_field.type === 'select'" v-bind:id="'<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
        <label class="control-label" v-bind:for="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
        <select v-model="order_data.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-on:change="save()" v-bind:id="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" class="form-control">
          <option value=""><?php echo $text_select; ?></option>
          <option v-for="custom_field_value in custom_field.custom_field_value" v-bind:value="custom_field_value.custom_field_value_id" v-html="custom_field_value.name"></option>
        </select>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_custom_field && error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-html="error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]"></span>
      </div>

      <?php /* custom fields - radio */ ?>

      <div v-for="custom_field in custom_fields.custom_fields.address" v-if="custom_field.type === 'radio'" v-bind:id="'<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
        <label class="control-label" v-html="custom_field.name"></label>
        <div v-bind:id="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id">
          <div class="radio" v-for="custom_field_value in custom_field.custom_field_value">
            <label>
              <input type="radio" v-model="order_data.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-on:change="save()" v-bind:value="custom_field_value.custom_field_value_id"/>
              <span v-html="custom_field_value.name"></span></label>
          </div>
        </div>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_custom_field && error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-html="error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]"></span>
      </div>

      <?php /* custom fields - checkbox */ ?>

      <div v-for="custom_field in custom_fields.custom_fields.address" v-if="custom_field.type === 'checkbox'" v-bind:id="'<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
        <label class="control-label" v-html="custom_field.name"></label>
        <div v-bind:id="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id">
          <div class="checkbox" v-for="custom_field_value in custom_field.custom_field_value">
            <label>
              <input type="checkbox" v-model="order_data.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-on:change="save()" v-bind:value="custom_field_value.custom_field_value_id"/>
              <span v-html="custom_field_value.name"></span></label>
          </div>
        </div>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_custom_field && error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-html="error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]"></span>
      </div>

      <?php /* custom fields - text */ ?>

      <div v-for="custom_field in custom_fields.custom_fields.address" v-if="custom_field.type === 'text'" v-bind:id="'<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
        <label class="control-label" v-bind:for="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
        <input type="text" v-model="order_data.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-on:blur="checkSave()" v-on:change="change()" value="" v-bind:placeholder="custom_field.name" v-bind:id="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" class="form-control"/>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_custom_field && error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-html="error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]"></span>
      </div>

      <?php /* custom fields - textarea */ ?>

      <div v-for="custom_field in custom_fields.custom_fields.address" v-if="custom_field.type === 'textarea'" v-bind:id="'<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
        <label class="control-label" v-bind:for="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
        <textarea v-model="order_data.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-on:blur="checkSave()" v-on:change="change()" rows="5" v-bind:placeholder="custom_field.name" v-bind:id="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" class="form-control"></textarea>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_custom_field && error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-html="error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]"></span>
      </div>

      <?php /* custom fields - file */ ?>

      <div v-for="custom_field in custom_fields.custom_fields.address" v-if="custom_field.type === 'file'" v-bind:id="'<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
        <label class="control-label" v-html="custom_field.name"></label>
        <br/>
        <button type="button" v-bind:id="'<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
        <input type="hidden" v-model="order_data.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-on:change="save()" value="" v-bind:id="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id"/>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_custom_field && error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-html="error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]"></span>
      </div>

      <?php /* custom fields - date */ ?>

      <div v-for="custom_field in custom_fields.custom_fields.address" v-if="custom_field.type === 'date'" v-bind:id="'<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
        <label class="control-label" v-bind:for="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
        <div class="input-group date">
          <input type="text" v-model="order_data.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-on:change="saveDateTime('<?php echo $type; ?>_custom_field', custom_field.custom_field_id, $event)" value="" v-bind:placeholder="custom_field.name" data-date-format="YYYY-MM-DD" v-bind:id="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" class="form-control"/>
          <span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>
        </div>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_custom_field && error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-html="error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]"></span>
      </div>

      <?php /* custom fields - time */ ?>

      <div v-for="custom_field in custom_fields.custom_fields.address" v-if="custom_field.type === 'time'" v-bind:id="'<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
        <label class="control-label" v-bind:for="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
        <div class="input-group time">
          <input type="text" v-model="order_data.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-on:change="saveDateTime('<?php echo $type; ?>_custom_field', custom_field.custom_field_id, $event)" value="" v-bind:placeholder="custom_field.name" data-date-format="HH:mm" v-bind:id="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" class="form-control"/>
          <span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>
        </div>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_custom_field && error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-html="error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]"></span>
      </div>

      <?php /* custom fields - datetime */ ?>

      <div v-for="custom_field in custom_fields.custom_fields.address" v-if="custom_field.type === 'datetime'" v-bind:id="'<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-bind:class="'form-group custom-field' + (custom_field.required ? ' required' : '')">
        <label class="control-label" v-bind:for="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" v-html="custom_field.name"></label>
        <div class="input-group datetime">
          <input type="text" v-model="order_data.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-on:change="saveDateTime('<?php echo $type; ?>_custom_field', custom_field.custom_field_id, $event)" value="" v-bind:placeholder="custom_field.name" data-date-format="YYYY-MM-DD HH:mm" v-bind:id="'input-<?php echo $type; ?>-custom-field' + custom_field.custom_field_id" class="form-control"/>
          <span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span>
        </div>
        <span class="text-danger" v-if="error && error.<?php echo $type; ?>_custom_field && error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]" v-html="error.<?php echo $type; ?>_custom_field[custom_field.custom_field_id]"></span>
      </div>
    </div>
    
           <div v-if="('<?php echo $type; ?>' === 'payment') && shipping_required" class="checkbox hidden">	

      <label>
        <input v-model="same_address" v-on:change="save()" type="checkbox"/>
        <?php echo $entry_shipping; ?></label>
    </div>
  </div>
</div>
