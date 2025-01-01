import 'package:flutter_test/flutter_test.dart';
import 'package:json_getter/json_getter.dart';

void main() {
  group('JsonGetter Class Tests', () {
    group('get', () {
      test('get processes filters on a JSON string', () {
        const jsonString = '{"key1": "value1", "key2": "value2"}';
        final filters = Filters(
          filters: [
            const Filter(
              selectorType: SelectorType.getValueByKey,
              key: 'key1',
            ),
          ],
        );

        final result = JsonGetter.get(filters: filters, json: jsonString);

        expect(result, 'value1');
      });

      test('get processes multiple filters on a JSON map', () {
        final json = {
          'key1': {
            'nestedKey': 'nestedValue',
          },
          'key2': 'value2',
        };
        final filters = Filters(
          filters: [
            const Filter(
              selectorType: SelectorType.getValueByKey,
              key: 'key1',
            ),
            const Filter(
              selectorType: SelectorType.getValueByKey,
              key: 'nestedKey',
            ),
          ],
        );

        final result = JsonGetter.get(filters: filters, json: json);

        expect(result, 'nestedValue');
      });

      test('get value from big JSON and multiple filters', () {
        const jsonString =
            "{\"id\":337,\"name\":\"Customised Vintage Fit Ripped Jeans\",\"slug\":\"customised-vintage-fit-ripped-jeans-2\",\"permalink\":\"https://demo.mstore.io/product/customised-vintage-fit-ripped-jeans-2/\",\"date_created\":\"2024-06-20T16:55:22\",\"date_created_gmt\":\"2024-06-20T09:55:22\",\"date_modified\":\"2024-12-31T16:02:51\",\"date_modified_gmt\":\"2024-12-31T09:02:51\",\"type\":\"simple\",\"status\":\"publish\",\"featured\":false,\"catalog_visibility\":\"visible\",\"description\":\"<ul>\\n<li>Non-stretch denim</li>\\n<li>Button fly</li>\\n<li>Classic five pocket styling</li>\\n<li>Ripped detail</li>\\n<li>Regular fit - true to size</li>\\n<li>100% Cotton</li>\\n<li>Machine wash</li>\\n<li>100% Cotton</li>\\n<li>Our model wears a UK 8/EU 36/US 4 and is 178 cm/5'10” tall</li>\\n</ul>\\n\",\"short_description\":\"\",\"sku\":\"\",\"price\":20,\"regular_price\":20,\"sale_price\":null,\"date_on_sale_from\":null,\"date_on_sale_from_gmt\":null,\"date_on_sale_to\":null,\"date_on_sale_to_gmt\":null,\"on_sale\":false,\"purchasable\":true,\"total_sales\":11,\"virtual\":false,\"downloadable\":false,\"downloads\":[],\"download_limit\":0,\"download_expiry\":0,\"external_url\":\"\",\"button_text\":\"\",\"tax_status\":\"taxable\",\"tax_class\":\"\",\"manage_stock\":false,\"stock_quantity\":null,\"in_stock\":true,\"backorders\":\"no\",\"backorders_allowed\":false,\"backordered\":false,\"sold_individually\":false,\"weight\":\"\",\"dimensions\":{\"length\":\"\",\"width\":\"\",\"height\":\"\"},\"shipping_required\":true,\"shipping_taxable\":true,\"shipping_class\":\"\",\"shipping_class_id\":0,\"reviews_allowed\":true,\"average_rating\":\"0.00\",\"rating_count\":0,\"upsell_ids\":[],\"cross_sell_ids\":[],\"parent_id\":0,\"purchase_note\":\"\",\"categories\":[{\"id\":24,\"name\":\"Clothing\",\"slug\":\"clothing\"},{\"id\":18,\"name\":\"Jeans\",\"slug\":\"jeans\"},{\"id\":17,\"name\":\"Women\",\"slug\":\"women\"}],\"tags\":[{\"id\":52,\"name\":\"jean\",\"slug\":\"jean\"},{\"id\":53,\"name\":\"women\",\"slug\":\"women\"}],\"images\":[{\"id\":51,\"date_created\":\"2024-06-20T22:48:33\",\"date_created_gmt\":\"2024-06-20T08:48:33\",\"date_modified\":\"2024-06-20T22:48:33\",\"date_modified_gmt\":\"2024-06-20T08:48:33\",\"src\":\"https://demo.mstore.io/wp-content/uploads/2024/06/image4xxl-4.jpg\",\"name\":\"image4xxl-4.jpg\",\"alt\":\"\",\"position\":0},{\"id\":404,\"date_created\":\"2024-06-20T23:57:23\",\"date_created_gmt\":\"2024-06-20T09:57:23\",\"date_modified\":\"2024-06-20T23:57:23\",\"date_modified_gmt\":\"2024-06-20T09:57:23\",\"src\":\"https://demo.mstore.io/wp-content/uploads/2024/06/image3xxl-4.jpg\",\"name\":\"image3xxl-4.jpg\",\"alt\":\"\",\"position\":1},{\"id\":49,\"date_created\":\"2024-06-20T22:48:26\",\"date_created_gmt\":\"2024-06-20T08:48:26\",\"date_modified\":\"2024-06-20T22:48:26\",\"date_modified_gmt\":\"2024-06-20T08:48:26\",\"src\":\"https://demo.mstore.io/wp-content/uploads/2024/06/image2xxl-5.jpg\",\"name\":\"image2xxl-5.jpg\",\"alt\":\"\",\"position\":2},{\"id\":48,\"date_created\":\"2024-06-20T22:48:24\",\"date_created_gmt\":\"2024-06-20T08:48:24\",\"date_modified\":\"2024-06-20T22:48:24\",\"date_modified_gmt\":\"2024-06-20T08:48:24\",\"src\":\"https://demo.mstore.io/wp-content/uploads/2024/06/image1xxl-5.jpg\",\"name\":\"image1xxl-5.jpg\",\"alt\":\"\",\"position\":3}],\"attributes\":[],\"default_attributes\":[],\"variations\":[],\"grouped_products\":[],\"menu_order\":26,\"price_html\":\"<span class=\\\"woocs_price_code\\\" data-currency=\\\"\\\" data-redraw-id=\\\"677579aa2eb81\\\"  data-product-id=\\\"337\\\"><span class=\\\"woocommerce-Price-amount amount\\\"><bdi>20,00<span class=\\\"woocommerce-Price-currencySymbol\\\">&#36;</span></bdi></span></span>\",\"related_ids\":[32,34,20,33,19],\"meta_data\":[{\"id\":16120,\"key\":\"slide_template\",\"value\":\"default\"},{\"id\":16121,\"key\":\"sbg_selected_sidebar_replacement\",\"value\":\"\"},{\"id\":16122,\"key\":\"_wpml_media_duplicate\",\"value\":\"\"},{\"id\":16123,\"key\":\"_wpml_media_featured\",\"value\":\"\"},{\"id\":16124,\"key\":\"mwb_product_points_enable\",\"value\":\"\"},{\"id\":16125,\"key\":\"mwb_points_product_value\",\"value\":\"\"},{\"id\":16126,\"key\":\"_minmax_product_min_quantity\",\"value\":\"\"},{\"id\":16127,\"key\":\"_minmax_product_max_quantity\",\"value\":\"\"},{\"id\":16128,\"key\":\"_minmax_product_min_price\",\"value\":\"\"},{\"id\":16129,\"key\":\"_minmax_product_max_price\",\"value\":\"\"},{\"id\":16130,\"key\":\"_minmax_ignore_global\",\"value\":\"\"},{\"id\":16131,\"key\":\"_wcml_custom_prices_status\",\"value\":\"\"},{\"id\":16132,\"key\":\"_product_addons_exclude_global\",\"value\":\"0\"},{\"id\":16133,\"key\":\"woopos_product_last_set_stock\",\"value\":\"\"},{\"id\":16134,\"key\":\"ihc_mb_type\",\"value\":\"\"},{\"id\":16135,\"key\":\"ihc_mb_who\",\"value\":\"\"},{\"id\":16136,\"key\":\"ihc_mb_block_type\",\"value\":\"\"},{\"id\":16137,\"key\":\"ihc_mb_redirect_to\",\"value\":\"\"},{\"id\":16138,\"key\":\"ihc_replace_content\",\"value\":\"\"},{\"id\":16139,\"key\":\"ihc_drip_content\",\"value\":\"\"},{\"id\":16140,\"key\":\"ihc_drip_start_type\",\"value\":\"\"},{\"id\":16141,\"key\":\"ihc_drip_end_type\",\"value\":\"\"},{\"id\":16142,\"key\":\"ihc_drip_start_numeric_type\",\"value\":\"\"},{\"id\":16143,\"key\":\"ihc_drip_start_numeric_value\",\"value\":\"\"},{\"id\":16144,\"key\":\"ihc_drip_end_numeric_type\",\"value\":\"\"},{\"id\":16145,\"key\":\"ihc_drip_end_numeric_value\",\"value\":\"\"},{\"id\":16146,\"key\":\"ihc_drip_start_certain_date\",\"value\":\"\"},{\"id\":16147,\"key\":\"ihc_drip_end_certain_date\",\"value\":\"\"},{\"id\":16148,\"key\":\"_mstore_video_url\",\"value\":\"\"},{\"id\":16149,\"key\":\"_mstore_video_title\",\"value\":\"\"},{\"id\":16150,\"key\":\"_mstore_video_description\",\"value\":\"\"},{\"id\":16151,\"key\":\"_wcmmq_min_qty\",\"value\":\"\"},{\"id\":16152,\"key\":\"_wcmmq_max_qty\",\"value\":\"\"},{\"id\":16153,\"key\":\"_wcmmq_step\",\"value\":\"\"},{\"id\":16154,\"key\":\"_wcmmq_disable\",\"value\":\"\"},{\"id\":16155,\"key\":\"_wcmmq_enable\",\"value\":\"\"},{\"id\":16156,\"key\":\"wholesale_customer_wholesale_price\",\"value\":\"\"},{\"id\":16157,\"key\":\"wholesale_customer_have_wholesale_price\",\"value\":\"\"},{\"id\":16158,\"key\":\"onesignal_meta_box_present\",\"value\":\"1\"},{\"id\":16159,\"key\":\"onesignal_send_notification\",\"value\":\"\"},{\"id\":16160,\"key\":\"algolia_searchable_posts_records_count\",\"value\":\"1\"},{\"id\":16161,\"key\":\"_wc_max_points_earned\",\"value\":\"\"},{\"id\":16162,\"key\":\"_wc_min_points_earned\",\"value\":\"\"},{\"id\":16163,\"key\":\"_cashback_type\",\"value\":\"\"},{\"id\":16164,\"key\":\"_cashback_amount\",\"value\":\"\"},{\"id\":16165,\"key\":\"wwpp_post_meta_enable_quantity_discount_rule\",\"value\":\"\"},{\"id\":16166,\"key\":\"wholesale_customer_variable_level_wholesale_minimum_order_quantity\",\"value\":\"\"},{\"id\":16167,\"key\":\"wholesale_customer_variable_level_wholesale_order_quantity_step\",\"value\":\"\"},{\"id\":16168,\"key\":\"wwpp_ignore_cat_level_wholesale_discount\",\"value\":\"\"},{\"id\":16169,\"key\":\"wwpp_ignore_role_level_wholesale_discount\",\"value\":\"\"},{\"id\":16170,\"key\":\"wwpp_product_hash\",\"value\":\"\"},{\"id\":16171,\"key\":\"_wc_min_max_quantities_min_qty\",\"value\":\"\"},{\"id\":16172,\"key\":\"_wc_min_max_quantities_max_qty\",\"value\":\"\"},{\"id\":16173,\"key\":\"_wc_min_max_quantities_step\",\"value\":\"\"},{\"id\":16174,\"key\":\"_wc_min_max_quantities_excluded\",\"value\":\"\"},{\"id\":16175,\"key\":\"_wc_min_max_quantities_override\",\"value\":\"\"},{\"id\":16176,\"key\":\"yith_sl_show_find_in_stores\",\"value\":\"\"},{\"id\":16177,\"key\":\"yith_sl_override_global_settings\",\"value\":\"\"},{\"id\":16178,\"key\":\"wwpp_product_wholesale_visibility_filter\",\"value\":\"\"},{\"id\":16179,\"key\":\"_wp_old_date\",\"value\":\"\"},{\"id\":16180,\"key\":\"wholesale_customer_wholesale_minimum_order_quantity\",\"value\":\"\"},{\"id\":16181,\"key\":\"wholesale_customer_wholesale_order_quantity_step\",\"value\":\"\"},{\"id\":16182,\"key\":\"_min_variation_price\",\"value\":\"\"},{\"id\":16183,\"key\":\"_max_variation_price\",\"value\":\"\"},{\"id\":16184,\"key\":\"_min_price_variation_id\",\"value\":\"\"},{\"id\":16185,\"key\":\"_max_price_variation_id\",\"value\":\"\"},{\"id\":16186,\"key\":\"_min_variation_regular_price\",\"value\":\"\"},{\"id\":16187,\"key\":\"_max_variation_regular_price\",\"value\":\"\"},{\"id\":16188,\"key\":\"_min_regular_price_variation_id\",\"value\":\"\"},{\"id\":16189,\"key\":\"_max_regular_price_variation_id\",\"value\":\"\"},{\"id\":16190,\"key\":\"_min_variation_sale_price\",\"value\":\"\"},{\"id\":16191,\"key\":\"_max_variation_sale_price\",\"value\":\"\"},{\"id\":16192,\"key\":\"_min_sale_price_variation_id\",\"value\":\"\"},{\"id\":16193,\"key\":\"_max_sale_price_variation_id\",\"value\":\"\"},{\"id\":16194,\"key\":\"mwb_wpr_variable_points\",\"value\":\"\"},{\"id\":16195,\"key\":\"_ywbc_barcode_protocol\",\"value\":\"\"},{\"id\":16196,\"key\":\"_ywbc_barcode_value\",\"value\":\"\"},{\"id\":16197,\"key\":\"_ywbc_barcode_display_value\",\"value\":\"\"},{\"id\":16198,\"key\":\"ywbc_barcode_display_value_custom_field\",\"value\":\"\"},{\"id\":16199,\"key\":\"_ywbc_barcode_image\",\"value\":\"\"},{\"id\":16200,\"key\":\"_ywbc_barcode_filename\",\"value\":\"\"},{\"id\":16201,\"key\":\"_wc_appointment_has_price_label\",\"value\":\"\"},{\"id\":16202,\"key\":\"_wc_appointment_price_label\",\"value\":\"\"},{\"id\":16203,\"key\":\"_wc_appointment_has_pricing\",\"value\":\"\"},{\"id\":16204,\"key\":\"_wc_appointment_qty\",\"value\":\"\"},{\"id\":16205,\"key\":\"_wc_appointment_qty_min\",\"value\":\"\"},{\"id\":16206,\"key\":\"_wc_appointment_qty_max\",\"value\":\"\"},{\"id\":16207,\"key\":\"_wc_appointment_duration_unit\",\"value\":\"\"},{\"id\":16208,\"key\":\"_wc_appointment_duration\",\"value\":\"\"},{\"id\":16209,\"key\":\"_wc_appointment_interval_unit\",\"value\":\"\"},{\"id\":16210,\"key\":\"_wc_appointment_interval\",\"value\":\"\"},{\"id\":16211,\"key\":\"_wc_appointment_padding_duration_unit\",\"value\":\"\"},{\"id\":16212,\"key\":\"_wc_appointment_padding_duration\",\"value\":\"\"},{\"id\":16213,\"key\":\"_wc_appointment_min_date_unit\",\"value\":\"\"},{\"id\":16214,\"key\":\"_wc_appointment_min_date\",\"value\":\"\"},{\"id\":16215,\"key\":\"_wc_appointment_max_date_unit\",\"value\":\"\"},{\"id\":16216,\"key\":\"_wc_appointment_max_date\",\"value\":\"\"},{\"id\":16217,\"key\":\"_wc_appointment_user_can_cancel\",\"value\":\"\"},{\"id\":16218,\"key\":\"_wc_appointment_cancel_limit_unit\",\"value\":\"\"},{\"id\":16219,\"key\":\"_wc_appointment_cancel_limit\",\"value\":\"\"},{\"id\":16220,\"key\":\"_wc_appointment_user_can_reschedule\",\"value\":\"\"},{\"id\":16221,\"key\":\"_wc_appointment_reschedule_limit_unit\",\"value\":\"\"},{\"id\":16222,\"key\":\"_wc_appointment_reschedule_limit\",\"value\":\"\"},{\"id\":16223,\"key\":\"_wc_appointment_requires_confirmation\",\"value\":\"\"},{\"id\":16224,\"key\":\"_wc_appointment_customer_timezones\",\"value\":\"\"},{\"id\":16225,\"key\":\"_wc_appointment_cal_color\",\"value\":\"\"},{\"id\":16226,\"key\":\"_wc_appointment_availability_span\",\"value\":\"\"},{\"id\":16227,\"key\":\"_wc_appointment_availability_autoselect\",\"value\":\"\"},{\"id\":16228,\"key\":\"_wc_appointment_has_restricted_days\",\"value\":\"\"},{\"id\":16229,\"key\":\"_wc_appointment_restricted_days\",\"value\":\"\"},{\"id\":16230,\"key\":\"_wc_appointment_staff_label\",\"value\":\"\"},{\"id\":16231,\"key\":\"_wc_appointment_staff_assignment\",\"value\":\"\"},{\"id\":16232,\"key\":\"_wc_appointment_staff_nopref\",\"value\":\"\"},{\"id\":16233,\"key\":\"_yith_wcbm_badge_from_date\",\"value\":\"\"},{\"id\":16234,\"key\":\"_yith_wcbm_badge_to_date\",\"value\":\"\"},{\"id\":16235,\"key\":\"_yith_wcbm_badge_schedule\",\"value\":\"0\"},{\"id\":16236,\"key\":\"_product_url\",\"value\":\"\"},{\"id\":16237,\"key\":\"_subscription_payment_sync_date\",\"value\":\"\"},{\"id\":16238,\"key\":\"easyweb_webnus_views\",\"value\":\"\"},{\"id\":16239,\"key\":\"_video_url\",\"value\":\"\"},{\"id\":16240,\"key\":\"_video_image_url\",\"value\":\"\"},{\"id\":16241,\"key\":\"_min_max_variation_ids_hash\",\"value\":\"\"},{\"id\":16242,\"key\":\"_subscription_limit\",\"value\":\"\"},{\"id\":16243,\"key\":\"_subscription_one_time_shipping\",\"value\":\"\"},{\"id\":16244,\"key\":\"attr_label_translations\",\"value\":\"\"},{\"id\":16245,\"key\":\"_wpas_done_all\",\"value\":\"\"},{\"id\":16246,\"key\":\"_wp_attachment_metadata\",\"value\":\"\"},{\"id\":16247,\"key\":\"wpml_media_processed\",\"value\":\"1\"},{\"id\":16248,\"key\":\"_wp_attached_file\",\"value\":\"\"},{\"id\":16249,\"key\":\"_wcml_duplicate_of_variation\",\"value\":\"\"},{\"id\":44519,\"key\":\"onesignal_modify_title_and_content\",\"value\":\"\"},{\"id\":44522,\"key\":\"_product_addons\",\"value\":[]},{\"id\":\"_yith_wcbm_badges\",\"key\":\"_yith_wcbm_badges\",\"value\":[{\"id\":652,\"title\":\"\",\"enabled\":\"yes\",\"type\":\"css\",\"uploaded_image_id\":\"\",\"uploaded_image_width\":0,\"image\":\"1.svg\",\"css\":\"8.svg\",\"advanced\":\"1.svg\",\"advanced_display\":\"amount\",\"text\":\"<p>New!</p>\",\"background_color\":\"#e1542d\",\"text_color\":\"#FFFFFF\",\"size\":{\"dimensions\":{\"width\":\"150\",\"height\":\"50\"},\"linked\":\"no\",\"unit\":\"px\"},\"padding\":{\"dimensions\":{\"top\":\"0\",\"right\":\"0\",\"bottom\":\"0\",\"left\":\"0\"},\"linked\":\"no\",\"unit\":\"px\"},\"border_radius\":{\"dimensions\":{\"top-left\":\"0\",\"top-right\":\"0\",\"bottom-right\":\"0\",\"bottom-left\":\"0\"},\"linked\":\"no\",\"unit\":\"px\"},\"margin\":{\"dimensions\":{\"top\":0,\"bottom\":0,\"right\":0,\"left\":0},\"linked\":\"no\",\"unit\":\"px\"},\"opacity\":100,\"rotation\":{\"x\":\"0\",\"x-input\":\"0\",\"y\":\"0\",\"y-input\":\"0\",\"z\":\"0\",\"z-input\":\"0\"},\"use_flip_text\":\"no\",\"flip_text\":\"vertical\",\"position_type\":\"fixed\",\"anchor_point\":\"top-left\",\"position_values\":{\"dimensions\":{\"top\":\"0\",\"bottom\":\"0\",\"right\":\"0\",\"left\":\"0\"},\"unit\":\"px\"},\"position\":\"top\",\"alignment\":\"right\",\"scale_on_mobile\":1,\"meta_data\":[{\"id\":42535,\"key\":\"_edit_lock\",\"value\":\"1730693376:2\"},{\"id\":42536,\"key\":\"_edit_last\",\"value\":\"2\"}]}]},{\"id\":\"_yith-wcbm-hide-on-single-product\",\"key\":\"_yith-wcbm-hide-on-single-product\",\"value\":false}],\"brands\":[{\"id\":58,\"name\":\"Brands\",\"slug\":\"hi\"}],\"is_purchased\":false,\"attributesData\":[],\"is_wallet_product\":false,\"_links\":{\"self\":[{\"href\":\"https://demo.mstore.io/wp-json/wc/v2/products/337\",\"targetHints\":{\"allow\":[\"GET\",\"POST\",\"PUT\",\"PATCH\",\"DELETE\"]}}],\"collection\":[{\"href\":\"https://demo.mstore.io/wp-json/wc/v2/products\"}]}}";
        final filters = FiltersMapper.fromJson(
          '{"filters":[{"selectorType":"getValueByKey","filterBy":null,"key":"categories","operator":null,"value":null},{"selectorType":"getItemsFromWhere","filterBy":"value","key":"name","operator":"notEqual","value":"Women"},{"selectorType":"getValueFromWhere","filterBy":"value","key":"name","operator":"isNotEmpty","value":null},{"selectorType":"join","filterBy":null,"key":null,"operator":null,"value":", "}]}',
        );

        final result = JsonGetter.get(filters: filters, json: jsonString);

        expect(result, 'Clothing, Jeans');
      });
    });

    group('getFromFilter', () {
      test('getFromFilter parses JSON string correctly', () {
        const jsonString =
            '{"key1": {"nestedKey": "nestedValue"}, "key2": "value2"}';
        const filter = Filter(
          selectorType: SelectorType.getValueByKey,
          key: 'key1',
        );

        final result =
            JsonGetter.getFromFilter(filter: filter, json: jsonString);

        expect(result, {'nestedKey': 'nestedValue'});
      });

      test('getFromFilter handles getValueByKey', () {
        final json = {'key1': 'value1', 'key2': 'value2'};
        const filter = Filter(
          selectorType: SelectorType.getValueByKey,
          key: 'key1',
        );

        final result = JsonGetter.getFromFilter(filter: filter, json: json);

        expect(result, 'value1');
      });

      test('getFromFilter handles getAllKeys', () {
        final json = {'key1': 'value1', 'key2': 'value2'};
        const filter = Filter(
          selectorType: SelectorType.getAllKeys,
        );

        final result = JsonGetter.getFromFilter(filter: filter, json: json);

        expect(result, ['key1', 'key2']);
      });

      test('getFromFilter handles getAllValues', () {
        final json = {'key1': 'value1', 'key2': 'value2'};
        const filter = Filter(
          selectorType: SelectorType.getAllValues,
        );

        final result = JsonGetter.getFromFilter(filter: filter, json: json);

        expect(result, ['value1', 'value2']);
      });

      test('getFromFilter works with equal operator for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.equal,
          value: 'value1',
        );
        final json = {'key1': 'value1', 'key2': 'value2'};
        final result = JsonGetter.getFromFilter(filter: filter, json: json);
        expect(result, 'value1');
      });

      test('getFromFilter works with contains operator for String', () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.contains,
          value: 'value',
        );
        final json = {'key1': 'value1'};
        final result = JsonGetter.getFromFilter(filter: filter, json: json);
        expect(result, 'value1');
      });

      test('getFromFilter returns null for unsupported operator', () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          key: 'key1',
          operator: Operator.greaterThan,
          value: 1,
        );
        final json = {'key1': 2};
        final result = JsonGetter.getFromFilter(filter: filter, json: json);
        expect(result, isNull);
      });
    });
    test('getFromFilter handles getLength', () {
      final json = {'key1': 'value1', 'key2': 'value2'};
      const filter = Filter(
        selectorType: SelectorType.getLength,
      );

      final result = JsonGetter.getFromFilter(filter: filter, json: json);

      expect(result, 2);
    });

    test('getFromFilter handles getValueAt for lists', () {
      final json = ['a', 'b', 'c'];
      const filter = Filter(
        selectorType: SelectorType.getValueAt,
        value: '1',
      );

      final result = JsonGetter.getFromFilter(filter: filter, json: json);

      expect(result, 'b');
    });

    test('getFromFilter handles getValueFirst for lists', () {
      final json = ['a', 'b', 'c'];
      const filter = Filter(
        selectorType: SelectorType.getValueFirst,
      );

      final result = JsonGetter.getFromFilter(filter: filter, json: json);

      expect(result, 'a');
    });

    test('getFromFilter handles getValueLast for lists', () {
      final json = ['a', 'b', 'c'];
      const filter = Filter(
        selectorType: SelectorType.getValueLast,
      );

      final result = JsonGetter.getFromFilter(filter: filter, json: json);

      expect(result, 'c');
    });

    test('getFromFilter handles join for lists', () {
      final json = ['a', 'b', 'c'];
      const filter = Filter(
        selectorType: SelectorType.join,
        value: '-',
      );

      final result = JsonGetter.getFromFilter(filter: filter, json: json);

      expect(result, 'a-b-c');
    });

    test('getFromFilter returns unmodified JSON for unsupported selectorType',
        () {
      final json = {'key1': 'value1', 'key2': 'value2'};
      const filter = Filter(
        selectorType: null,
      );

      final result = JsonGetter.getFromFilter(filter: filter, json: json);

      expect(result, json);
    });

    test('getFromFilter handles getItemsFromWhere for lists', () {
      final json = [
        {'key1': 'value1', 'key2': 'value2'},
        {'key1': 'value3', 'key2': 'value4'},
      ];
      const filter = Filter(
        selectorType: SelectorType.getItemsFromWhere,
        filterBy: FilterBy.value,
        key: 'key2',
        operator: Operator.contains,
        value: 'value4',
      );

      final result = JsonGetter.getFromFilter(filter: filter, json: json);

      expect(result, [
        {'key1': 'value3', 'key2': 'value4'},
      ]);
    });
  });
}
