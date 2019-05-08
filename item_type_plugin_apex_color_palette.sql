prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_190100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2019.03.31'
,p_release=>'19.1.0.00.15'
,p_default_workspace_id=>1649663407429859447
,p_default_application_id=>24068
,p_default_owner=>'MEDIS'
);
end;
/
prompt --application/shared_components/plugins/item_type/apex_color_palette
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(41556327815754810652)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'APEX_COLOR_PALETTE'
,p_display_name=>'APEX Color Palette'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render',
'    ( p_item   in            apex_plugin.t_item',
'    , p_plugin in            apex_plugin.t_plugin',
'    , p_param  in            apex_plugin.t_item_render_param',
'    , p_result in out nocopy apex_plugin.t_item_render_result',
'    )',
'as    ',
'    l_escaped_value varchar2(32767) := apex_escape.html(p_param.value);',
'    l_name          apex_plugin.t_input_name;',
'    l_display_value varchar2(32767);',
'    ',
'    l_enter_submit  boolean := (coalesce(p_item.attribute_01, ''N'') = ''Y'');',
'    l_is_disabled   boolean := (coalesce(p_item.attribute_02, ''N'') = ''Y'');',
'    l_save_state    boolean := (coalesce(p_item.attribute_03, ''N'') = ''Y'');',
'    l_color_json    varchar2(32767)  := p_item.attribute_04;',
'begin',
'    if p_param.value_set_by_controller and p_param.is_readonly then',
'        return;',
'    end if;',
'     sys.htp.prn(',
'        ''<span id="''|| p_item.name ||''_bgcolor" style="height: 14px; width: 14px; border-radius: 100%; display: block; position: absolute; pointer-events: none; box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 0px 1px inset; background-color: rgb(255, 255, 255'
||');"></span>''',
'        );',
'        ',
'    if (p_param.is_readonly or p_param.is_printer_friendly) then',
'        if not (l_is_disabled and not l_save_state) then',
'            apex_plugin_util.print_hidden_if_readonly',
'                ( p_item  => p_item',
'                , p_param => p_param',
'                );',
'        end if;',
'        ',
'        l_display_value := l_escaped_value;',
'        ',
'        apex_plugin_util.print_display_only',
'            ( p_item_name        => p_item.name',
'            , p_display_value    => l_display_value',
'            , p_show_line_breaks => false',
'            , p_escape           => false',
'            , p_attributes       => p_item.element_attributes',
'            );',
'    else',
'    ',
'        if not l_is_disabled or (l_is_disabled and l_save_state)',
'        then',
'            l_name := apex_plugin.get_input_name_for_item;',
'        end if;',
'         ',
'        sys.htp.prn(',
'            ''<input type="text" '' ||',
'            apex_plugin_util.get_element_attributes( p_item',
'                                                   , l_name',
'                                                   , ''color-picker apex-item-text'' || case when l_is_disabled then '' apex_disabled'' end',
'                                                   ) ||',
'            ''value="''||l_escaped_value||''" ''||',
'            ''size="''||p_item.element_width||''" ''||',
'            ''maxlength="''||p_item.element_max_length||''" ''||',
'            case when l_enter_submit and not l_is_disabled then ',
'                ''onkeypress="return apex.submit({request:'''''' || p_item.name || '''''',submitIfEnter:event})" '' ',
'            end ||',
'',
'            case when l_is_disabled then ',
'                case when l_save_state then ',
'                    ''readonly="readonly" '' ',
'                else ',
'                    ''disabled="disabled" '' ',
'                end ',
'            end ||',
'',
'            '' />',
'            <button type="button" id="'' || p_item.name || ''_button" class="a-Button a-Button--calendar"><span class="a-Icon icon-color-picker" aria-hidden="true"></span></button>'');',
'',
'            if p_item.icon_css_classes is not null then',
'                sys.htp.prn(''<span class="apex-item-icon fa ''|| apex_escape.html_attribute(p_item.icon_css_classes) ||''" aria-hidden="true"></span>'');',
'            end if;',
'',
'       if l_is_disabled and l_save_state and not p_param.value_set_by_controller then',
'            wwv_flow_plugin_util.print_protected',
'                ( p_item_name => p_item.name',
'                , p_value     => p_param.value',
'                );',
'        end if;',
'        ',
'    end if;',
'    ',
'        APEX_CSS.ADD_FILE(',
'        P_NAME        => ''colorselector'',',
'        P_DIRECTORY   => P_PLUGIN.FILE_PREFIX,',
'        P_VERSION     => NULL,',
'        P_KEY         => ''colorselector.css.scr''',
'    );',
'       APEX_JAVASCRIPT.ADD_LIBRARY(',
'        P_NAME        => ''colorselector.min'',',
'        P_DIRECTORY   => P_PLUGIN.FILE_PREFIX,',
'        P_VERSION     => NULL,',
'        P_KEY         => ''colorselector.scr''',
'    );',
'    ',
'     APEX_JAVASCRIPT.ADD_ONLOAD_CODE( ''colorselector.initialize(''',
'     || APEX_JAVASCRIPT.ADD_VALUE( p_item.name, TRUE ) ',
'     || APEX_JAVASCRIPT.ADD_VALUE( l_color_json, TRUE ) ',
'     || '');'' );',
'        p_result.is_navigable := not l_is_disabled;',
'end render;',
'',
'procedure validate',
'    ( p_item   in            apex_plugin.t_item',
'    , p_plugin in            apex_plugin.t_plugin',
'    , p_param  in            apex_plugin.t_item_validation_param',
'    , p_result in out nocopy apex_plugin.t_item_validation_result',
'    )',
'is',
'    c_trim_spaces      constant varchar2(100) := nvl(p_item.attribute_05, ''BOTH'');',
'    c_restricted_chars constant varchar2(4)   := chr(32) || chr(10) || chr(13) || chr(9);',
'    c_regex            constant varchar2(50)  := ''(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)'';    ',
'    b_regex_result     boolean;',
'    l_value varchar2( 32767 );',
'begin',
'   b_regex_result := REGEXP_LIKE(l_value ,c_regex);',
'   if b_regex_result = false then ',
'    p_result.message := APEX_LANG.MESSAGE (''Invalid Color Format (e.g. #FFFFFF)'');',
'   end if;',
'end validate;'))
,p_api_version=>2
,p_render_function=>'render'
,p_validation_function=>'validate'
,p_standard_attributes=>'VISIBLE:FORM_ELEMENT:READONLY:SOURCE:ELEMENT:FILTER:LINK'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_is_quick_pick=>true
,p_help_text=>'Just add this item to your application and it already works. If you want you can overwrite colors check the help of the  Color Json.'
,p_version_identifier=>'1.0'
,p_files_version=>95
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(21883505525592532865)
,p_plugin_id=>wwv_flow_api.id(41556327815754810652)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Color Json'
,p_attribute_type=>'JAVASCRIPT'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'[  ',
'   {  ',
'      "hex":"#F44336",',
'      "shades":[  ',
'         {  ',
'            "hex":"#FFEBEE"',
'         },',
'         {  ',
'            "hex":"#FFCDD2"',
'         },',
'         {  ',
'            "hex":"#EF9A9A"',
'         },',
'         {  ',
'            "hex":"#E57373"',
'         }',
'      ]',
'   },',
'   {  ',
'      "hex":"#E91E63",',
'      "shades":[  ',
'         {  ',
'            "hex":"#FCE4EC"',
'         },',
'         {  ',
'            "hex":"#F8BBD0"',
'         },',
'         {  ',
'            "hex":"#F48FB1"',
'         },',
'         {  ',
'            "hex":"#F06292"',
'         }',
'      ]',
'   },',
'   {  ',
'      "hex":"#9C27B0",',
'      "shades":[  ',
'         {  ',
'            "hex":"#F3E5F5"',
'         },',
'         {  ',
'            "hex":"#E1BEE7"',
'         },',
'         {  ',
'            "hex":"#CE93D8"',
'         },',
'         {  ',
'            "hex":"#BA68C8"',
'         }',
'      ]',
'   }',
']'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<pre>If you leave the Json field empty, then the material design colors will be used. Alternatively you have the possibility to define your own pallets.',
'Two click variant (first color is preselect and shape is selected):',
'   {  ',
'      "hex":"#F44336",',
'      "shades":[  ',
'         {  ',
'            "hex":"#FFEBEE"',
'         },',
'         {  ',
'            "hex":"#FFCDD2"',
'         },',
'         {  ',
'            "hex":"#EF9A9A"',
'         },',
'         {  ',
'            "hex":"#E57373"',
'         }',
'      ]',
'   },',
'   {  ',
'      "hex":"#E91E63",',
'      "shades":[  ',
'         {  ',
'            "hex":"#FCE4EC"',
'         },',
'         {  ',
'            "hex":"#F8BBD0"',
'         },',
'         {  ',
'            "hex":"#F48FB1"',
'         },',
'         {  ',
'            "hex":"#F06292"',
'         }',
'      ]',
'   },',
'   {  ',
'      "hex":"#9C27B0",',
'      "shades":[  ',
'         {  ',
'            "hex":"#F3E5F5"',
'         },',
'         {  ',
'            "hex":"#E1BEE7"',
'         },',
'         {  ',
'            "hex":"#CE93D8"',
'         },',
'         {  ',
'            "hex":"#BA68C8"',
'         }',
'      ]',
'   }',
']',
'',
'',
'One click:',
'[  ',
'   {  ',
'      "hex":"#F44336"',
'   },',
'   {  ',
'      "hex":"#E91E63"',
'   },',
'   {  ',
'      "hex":"#9C27B0"',
'   }',
']',
'</pre>'))
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E636972636C65207B0D0A20202020626F726465723A2032707820736F6C696420233636363636363B0D0A20202020626F726465722D7261646975733A203530253B0D0A20202020666C6F61743A206C6566743B0D0A2020202077696474683A2032656D';
wwv_flow_api.g_varchar2_table(2) := '3B0D0A202020206865696768743A2032656D3B0D0A202020207A2D696E6465783A2031303030303B0D0A7D0D0A0D0A2E636F6C6F7273656C6563746F72207B0D0A20202020646973706C61793A206E6F6E653B0D0A20202020746578742D616C69676E3A';
wwv_flow_api.g_varchar2_table(3) := '206C6566743B0D0A20202020706F736974696F6E3A2066697865643B0D0A202020206261636B67726F756E643A20234646464646463B0D0A202020207A2D696E6465783A20393939393B0D0A202020206D61782D77696474683A20313030253B0D0A2020';
wwv_flow_api.g_varchar2_table(4) := '202070616464696E672D6C6566743A203270783B0D0A2020202070616464696E672D746F703A203270783B0D0A20202020626F782D73697A696E673A20636F6E74656E742D626F780D0A7D0D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(41556332758850810679)
,p_plugin_id=>wwv_flow_api.id(41556327815754810652)
,p_file_name=>'colorselector.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '76617220636F6C6F7273656C6563746F723D66756E6374696F6E28297B2275736520737472696374223B76617220652C683D7B76657273696F6E3A22312E302E35222C6973415045583A66756E6374696F6E28297B72657475726E22756E646566696E65';
wwv_flow_api.g_varchar2_table(2) := '6422213D747970656F6620617065787D2C64656275673A7B696E666F3A66756E6374696F6E2865297B682E69734150455828292626617065782E64656275672E696E666F2865297D2C6572726F723A66756E6374696F6E2865297B682E69734150455828';
wwv_flow_api.g_varchar2_table(3) := '293F617065782E64656275672E6572726F722865293A636F6E736F6C652E6572726F722865297D7D7D2C783D5B7B6865783A2223463434333336222C7368616465733A5B7B6865783A2223464645424545227D2C7B6865783A2223464643444432227D2C';
wwv_flow_api.g_varchar2_table(4) := '7B6865783A2223454639413941227D2C7B6865783A2223453537333733227D2C7B6865783A2223454635333530227D2C7B6865783A2223463434333336227D2C7B6865783A2223453533393335227D2C7B6865783A2223443332463246227D2C7B686578';
wwv_flow_api.g_varchar2_table(5) := '3A2223433632383238227D2C7B6865783A2223423731433143227D2C7B6865783A2223464638413830227D2C7B6865783A2223464635323532227D2C7B6865783A2223464631373434227D2C7B6865783A2223443530303030227D5D7D2C7B6E616D653A';
wwv_flow_api.g_varchar2_table(6) := '2250494E4B222C6865783A2223453931453633222C7368616465733A5B7B6865783A2223464345344543227D2C7B6865783A2223463842424430227D2C7B6865783A2223463438464231227D2C7B6865783A2223463036323932227D2C7B6865783A2223';
wwv_flow_api.g_varchar2_table(7) := '454334303741227D2C7B6865783A2223453931453633227D2C7B6865783A2223443831423630227D2C7B6865783A2223433231383542227D2C7B6865783A2223414431343537227D2C7B6865783A2223383830453446227D2C7B6865783A222346463830';
wwv_flow_api.g_varchar2_table(8) := '4142227D2C7B6865783A2223464634303831227D2C7B6865783A2223463530303537227D2C7B6865783A2223433531313632227D5D7D2C7B6E616D653A22505552504C45222C6865783A2223394332374230222C7368616465733A5B7B6865783A222346';
wwv_flow_api.g_varchar2_table(9) := '3345354635227D2C7B6865783A2223453142454537227D2C7B6865783A2223434539334438227D2C7B6865783A2223424136384338227D2C7B6865783A2223414234374243227D2C7B6865783A2223394332374230227D2C7B6865783A22233845323441';
wwv_flow_api.g_varchar2_table(10) := '41227D2C7B6865783A2223374231464132227D2C7B6865783A2223364131423941227D2C7B6865783A2223344131343843227D2C7B6865783A2223454138304643227D2C7B6865783A2223453034304642227D2C7B6865783A2223443530304639227D2C';
wwv_flow_api.g_varchar2_table(11) := '7B6865783A2223414130304646227D5D7D2C7B6E616D653A224445455020505552504C45222C6865783A2223363733414237222C7368616465733A5B7B6865783A2223454445374636227D2C7B6865783A2223443143344539227D2C7B6865783A222342';
wwv_flow_api.g_varchar2_table(12) := '3339444442227D2C7B6865783A2223393537354344227D2C7B6865783A2223374535374332227D2C7B6865783A2223363733414237227D2C7B6865783A2223354533354231227D2C7B6865783A2223353132444138227D2C7B6865783A22233435323741';
wwv_flow_api.g_varchar2_table(13) := '30227D2C7B6865783A2223333131423932227D2C7B6865783A2223423338384646227D2C7B6865783A2223374334444646227D2C7B6865783A2223363531464646227D2C7B6865783A2223363230304541227D5D7D2C7B6E616D653A22494E4449474F22';
wwv_flow_api.g_varchar2_table(14) := '2C6865783A2223334635314235222C7368616465733A5B7B6865783A2223453845414636227D2C7B6865783A2223433543414539227D2C7B6865783A2223394641384441227D2C7B6865783A2223373938364342227D2C7B6865783A2223354336424330';
wwv_flow_api.g_varchar2_table(15) := '227D2C7B6865783A2223334635314235227D2C7B6865783A2223333934394142227D2C7B6865783A2223333033463946227D2C7B6865783A2223323833353933227D2C7B6865783A2223314132333745227D2C7B6865783A2223384339454646227D2C7B';
wwv_flow_api.g_varchar2_table(16) := '6865783A2223353336444645227D2C7B6865783A2223334435414645227D2C7B6865783A2223333034464645227D5D7D2C7B6E616D653A22424C5545222C6865783A2223323139364633222C7368616465733A5B7B6865783A2223453346324644227D2C';
wwv_flow_api.g_varchar2_table(17) := '7B6865783A2223424244454642227D2C7B6865783A2223393043414639227D2C7B6865783A2223363442354636227D2C7B6865783A2223343241354635227D2C7B6865783A2223323139364633227D2C7B6865783A2223314538384535227D2C7B686578';
wwv_flow_api.g_varchar2_table(18) := '3A2223313937364432227D2C7B6865783A2223313536354330227D2C7B6865783A2223304434374131227D2C7B6865783A2223383242314646227D2C7B6865783A2223343438414646227D2C7B6865783A2223323937394646227D2C7B6865783A222332';
wwv_flow_api.g_varchar2_table(19) := '3936324646227D5D7D2C7B6E616D653A224C4947485420424C5545222C6865783A2223303341394634222C7368616465733A5B7B6865783A2223453146354645227D2C7B6865783A2223423345354643227D2C7B6865783A2223383144344641227D2C7B';
wwv_flow_api.g_varchar2_table(20) := '6865783A2223344643334637227D2C7B6865783A2223323942364636227D2C7B6865783A2223303341394634227D2C7B6865783A2223303339424535227D2C7B6865783A2223303238384431227D2C7B6865783A2223303237374244227D2C7B6865783A';
wwv_flow_api.g_varchar2_table(21) := '2223303135373942227D2C7B6865783A2223383044384646227D2C7B6865783A2223343043344646227D2C7B6865783A2223303042304646227D2C7B6865783A2223303039314541227D5D7D2C7B6E616D653A224359414E222C6865783A222330304243';
wwv_flow_api.g_varchar2_table(22) := '4434222C7368616465733A5B7B6865783A2223453046374641227D2C7B6865783A2223423245424632227D2C7B6865783A2223383044454541227D2C7B6865783A2223344444304531227D2C7B6865783A2223323643364441227D2C7B6865783A222330';
wwv_flow_api.g_varchar2_table(23) := '3042434434227D2C7B6865783A2223303041434331227D2C7B6865783A2223303039374137227D2C7B6865783A2223303038333846227D2C7B6865783A2223303036303634227D2C7B6865783A2223383446464646227D2C7B6865783A22233138464646';
wwv_flow_api.g_varchar2_table(24) := '46227D2C7B6865783A2223303045354646227D2C7B6865783A2223303042384434227D5D7D2C7B6E616D653A225445414C222C6865783A2223303039363838222C7368616465733A5B7B6865783A2223453046324631227D2C7B6865783A222342324446';
wwv_flow_api.g_varchar2_table(25) := '4442227D2C7B6865783A2223383043424334227D2C7B6865783A2223344442364143227D2C7B6865783A2223323641363941227D2C7B6865783A2223303039363838227D2C7B6865783A2223303038393742227D2C7B6865783A2223303037393642227D';
wwv_flow_api.g_varchar2_table(26) := '2C7B6865783A2223303036393543227D2C7B6865783A2223303034443430227D2C7B6865783A2223413746464542227D2C7B6865783A2223363446464441227D2C7B6865783A2223314445394236227D2C7B6865783A2223303042464135227D5D7D2C7B';
wwv_flow_api.g_varchar2_table(27) := '6E616D653A22475245454E222C6865783A2223344341463530222C7368616465733A5B7B6865783A2223453846354539227D2C7B6865783A2223433845364339227D2C7B6865783A2223413544364137227D2C7B6865783A2223383143373834227D2C7B';
wwv_flow_api.g_varchar2_table(28) := '6865783A2223363642423641227D2C7B6865783A2223344341463530227D2C7B6865783A2223343341303437227D2C7B6865783A2223333838453343227D2C7B6865783A2223324537443332227D2C7B6865783A2223314235453230227D2C7B6865783A';
wwv_flow_api.g_varchar2_table(29) := '2223423946364341227D2C7B6865783A2223363946304145227D2C7B6865783A2223303045363736227D2C7B6865783A2223303043383533227D5D7D2C7B6E616D653A224C4947485420475245454E222C6865783A2223384243333441222C7368616465';
wwv_flow_api.g_varchar2_table(30) := '733A5B7B6865783A2223463146384539227D2C7B6865783A2223444345444338227D2C7B6865783A2223433545314135227D2C7B6865783A2223414544353831227D2C7B6865783A2223394343433635227D2C7B6865783A2223384243333441227D2C7B';
wwv_flow_api.g_varchar2_table(31) := '6865783A2223374342333432227D2C7B6865783A2223363839463338227D2C7B6865783A2223353538423246227D2C7B6865783A2223333336393145227D2C7B6865783A2223434346463930227D2C7B6865783A2223423246463539227D2C7B6865783A';
wwv_flow_api.g_varchar2_table(32) := '2223373646463033227D2C7B6865783A2223363444443137227D5D7D2C7B6E616D653A224C494D45222C6865783A2223434444433339222C7368616465733A5B7B6865783A2223463946424537227D2C7B6865783A2223463046344333227D2C7B686578';
wwv_flow_api.g_varchar2_table(33) := '3A2223453645453943227D2C7B6865783A2223444345373735227D2C7B6865783A2223443445313537227D2C7B6865783A2223434444433339227D2C7B6865783A2223433043413333227D2C7B6865783A2223414642343242227D2C7B6865783A222339';
wwv_flow_api.g_varchar2_table(34) := '4539443234227D2C7B6865783A2223383237373137227D2C7B6865783A2223463446463831227D2C7B6865783A2223454546463431227D2C7B6865783A2223433646463030227D2C7B6865783A2223414545413030227D5D7D2C7B6E616D653A2259454C';
wwv_flow_api.g_varchar2_table(35) := '4C4F57222C6865783A2223464645423342222C7368616465733A5B7B6865783A2223464646444537227D2C7B6865783A2223464646394334227D2C7B6865783A2223464646353944227D2C7B6865783A2223464646313736227D2C7B6865783A22234646';
wwv_flow_api.g_varchar2_table(36) := '45453538227D2C7B6865783A2223464645423342227D2C7B6865783A2223464444383335227D2C7B6865783A2223464243303244227D2C7B6865783A2223463941383235227D2C7B6865783A2223463537463137227D2C7B6865783A2223464646463844';
wwv_flow_api.g_varchar2_table(37) := '227D2C7B6865783A2223464646463030227D2C7B6865783A2223464645413030227D2C7B6865783A2223464644363030227D5D7D2C7B6E616D653A22414D424552222C6865783A2223464643313037222C7368616465733A5B7B6865783A222346464638';
wwv_flow_api.g_varchar2_table(38) := '4531227D2C7B6865783A2223464645434233227D2C7B6865783A2223464645303832227D2C7B6865783A2223464644353446227D2C7B6865783A2223464643413238227D2C7B6865783A2223464643313037227D2C7B6865783A2223464642333030227D';
wwv_flow_api.g_varchar2_table(39) := '2C7B6865783A2223464641303030227D2C7B6865783A2223464638463030227D2C7B6865783A2223464636463030227D2C7B6865783A2223464645353746227D2C7B6865783A2223464644373430227D2C7B6865783A2223464643343030227D2C7B6865';
wwv_flow_api.g_varchar2_table(40) := '783A2223464641423030227D5D7D2C7B6E616D653A224F52414E4745222C6865783A2223464639383030222C7368616465733A5B7B6865783A2223464646334530227D2C7B6865783A2223464645304232227D2C7B6865783A2223464643433830227D2C';
wwv_flow_api.g_varchar2_table(41) := '7B6865783A2223464642373444227D2C7B6865783A2223464641373236227D2C7B6865783A2223464639383030227D2C7B6865783A2223464238433030227D2C7B6865783A2223463537433030227D2C7B6865783A2223454636433030227D2C7B686578';
wwv_flow_api.g_varchar2_table(42) := '3A2223453635313030227D2C7B6865783A2223464644313830227D2C7B6865783A2223464641423430227D2C7B6865783A2223464639313030227D2C7B6865783A2223464636443030227D5D7D2C7B6E616D653A2244454550204F52414E4745222C6865';
wwv_flow_api.g_varchar2_table(43) := '783A2223464635373232222C7368616465733A5B7B6865783A2223464245394537227D2C7B6865783A2223464643434243227D2C7B6865783A2223464641423931227D2C7B6865783A2223464638413635227D2C7B6865783A2223464637303433227D2C';
wwv_flow_api.g_varchar2_table(44) := '7B6865783A2223464635373232227D2C7B6865783A2223463435313145227D2C7B6865783A2223453634413139227D2C7B6865783A2223443834333135227D2C7B6865783A2223424633363043227D2C7B6865783A2223464639453830227D2C7B686578';
wwv_flow_api.g_varchar2_table(45) := '3A2223464636453430227D2C7B6865783A2223464633443030227D2C7B6865783A2223444432433030227D5D7D2C7B6E616D653A2242524F574E222C6865783A2223373935353438222C7368616465733A5B7B6865783A2223454645424539227D2C7B68';
wwv_flow_api.g_varchar2_table(46) := '65783A2223443743434338227D2C7B6865783A2223424341414134227D2C7B6865783A2223413138383746227D2C7B6865783A2223384436453633227D2C7B6865783A2223373935353438227D2C7B6865783A2223364434433431227D2C7B6865783A22';
wwv_flow_api.g_varchar2_table(47) := '23354434303337227D2C7B6865783A2223344533343245227D2C7B6865783A2223334532373233227D5D7D2C7B6E616D653A2247524559222C6865783A2223394539453945222C7368616465733A5B7B6865783A2223464146414641227D2C7B6865783A';
wwv_flow_api.g_varchar2_table(48) := '2223463546354635227D2C7B6865783A2223454545454545227D2C7B6865783A2223453045304530227D2C7B6865783A2223424442444244227D2C7B6865783A2223394539453945227D2C7B6865783A2223373537353735227D2C7B6865783A22233631';
wwv_flow_api.g_varchar2_table(49) := '36313631227D2C7B6865783A2223343234323432227D2C7B6865783A2223323132313231227D5D7D2C7B6E616D653A22424C55452047524559222C6865783A2223363037443842222C7368616465733A5B7B6865783A2223454345464631227D2C7B6865';
wwv_flow_api.g_varchar2_table(50) := '783A2223434644384443227D2C7B6865783A2223423042454335227D2C7B6865783A2223393041344145227D2C7B6865783A2223373839303943227D2C7B6865783A2223363037443842227D2C7B6865783A2223353436453741227D2C7B6865783A2223';
wwv_flow_api.g_varchar2_table(51) := '343535413634227D2C7B6865783A2223333734373446227D2C7B6865783A2223323633323338227D5D7D5D2C463D7B7069636B65723A7B73686F773A66756E6374696F6E28782C73297B7472797B313D3D242822236D617444657369676E436F6C6F7273';
wwv_flow_api.g_varchar2_table(52) := '22292E6C656E677468262628242822236D617444657369676E436F6C6F727322292E666164654F757428292C242822236D617444657369676E436F6C6F727322292E72656D6F76652829292C242822236D617444657369676E436F6C6F727322292E6461';
wwv_flow_api.g_varchar2_table(53) := '74612822626C7572616374697665222C2130293B76617220453D24282223222B73292E6F666673657428292C6F3D452E6C6566742B227078222C723D452E746F702B227078222C433D2428223C6469763E3C2F6469763E22292E6174747228226964222C';
wwv_flow_api.g_varchar2_table(54) := '226D617444657369676E436F6C6F727322292E63737328226D61782D7769647468222C2239302522292E6373732822706F736974696F6E222C226162736F6C75746522292E6373732822746F70222C72292E63737328226C656674222C6F292E63737328';
wwv_flow_api.g_varchar2_table(55) := '227A2D696E646578222C223939393922292E637373282270616464696E67222C223130707822292E6373732822646973706C6179222C22626C6F636B22292E63737328226F766572666C6F772D77726170222C22627265616B2D776F726422292E637373';
wwv_flow_api.g_varchar2_table(56) := '2822776F72642D77726170222C22627265616B2D776F726422292E63737328222D6D732D68797068656E73222C226175746F22292E63737328222D6D6F7A2D68797068656E73222C226175746F22292E63737328222D7765626B69742D68797068656E73';
wwv_flow_api.g_varchar2_table(57) := '222C226175746F22292E637373282268797068656E73222C226175746F22293B242822626F647922292E617070656E642843292C242E6561636828782C66756E6374696F6E28682C78297B242822236D617444657369676E436F6C6F727322292E617070';
wwv_flow_api.g_varchar2_table(58) := '656E6428273C64697620636C6173733D22636972636C652070726522207374796C65203D226261636B67726F756E642D636F6C6F723A272B782E6865782B27223E266E6273703B3C2F6469763E27292C242822236D617444657369676E436F6C6F727322';
wwv_flow_api.g_varchar2_table(59) := '292E6368696C6472656E28292E6C61737428292E6F6E2822636C69636B222C66756E6374696F6E2865297B782E6861734F776E50726F7065727479282273686164657322293F28242E6561636828782E7368616465732C66756E6374696F6E28652C6829';
wwv_flow_api.g_varchar2_table(60) := '7B242822236D617444657369676E436F6C6F727322292E617070656E6428273C64697620636C6173733D22636972636C6522207374796C65203D226261636B67726F756E642D636F6C6F723A272B682E6865782B27223E266E6273703B3C2F6469763E27';
wwv_flow_api.g_varchar2_table(61) := '292C242822236D617444657369676E436F6C6F727322292E6368696C6472656E28292E6C61737428292E6F6E2822636C69636B222C66756E6374696F6E2865297B462E7069636B65722E736574436F6C6F7228732C682E686578297D297D292C24282264';
wwv_flow_api.g_varchar2_table(62) := '697622292E72656D6F766528222E70726522292C24282223222B73292E666F6375732829293A462E7069636B65722E736574436F6C6F7228732C782E686578297D292C242822236D617444657369676E436F6C6F727322292E6F6E28226D6F757365656E';
wwv_flow_api.g_varchar2_table(63) := '746572222C66756E6374696F6E2865297B242822236D617444657369676E436F6C6F727322292E646174612822626C7572616374697665222C2131297D292C242822236D617444657369676E436F6C6F727322292E6F6E28226D6F7573656C6561766522';
wwv_flow_api.g_varchar2_table(64) := '2C66756E6374696F6E2865297B242822236D617444657369676E436F6C6F727322292E646174612822626C7572616374697665222C2130297D292C24282223222B73292E6F6E2822626C7572222C66756E6374696F6E2868297B242822236D6174446573';
wwv_flow_api.g_varchar2_table(65) := '69676E436F6C6F727322292E646174612822626C75726163746976652229262628242822236D617444657369676E436F6C6F727322292E666164654F757428292C242822236D617444657369676E436F6C6F727322292E72656D6F766528292C462E7069';
wwv_flow_api.g_varchar2_table(66) := '636B65722E736574436F6C6F7228732C6529297D297D292C242822236D617444657369676E436F6C6F727322292E63737328227669736962696C697479222C2276697369626C6522297D63617463682865297B682E64656275672E6572726F7228224572';
wwv_flow_api.g_varchar2_table(67) := '726F72207768696C652074727920746F2073686F7720636F6C6F727322292C682E64656275672E6572726F722865297D7D2C72656D6F76653A66756E6374696F6E28297B242822236D617444657369676E436F6C6F727322292E72656D6F766528297D2C';
wwv_flow_api.g_varchar2_table(68) := '736574436F6C6F723A66756E6374696F6E28682C78297B242822236D617444657369676E436F6C6F727322292E666164654F757428292C242822236D617444657369676E436F6C6F727322292E72656D6F766528292C617065782E6974656D2868292E73';
wwv_flow_api.g_varchar2_table(69) := '657456616C75652878292C24282223222B682B225F6267636F6C6F7222292E63737328226261636B67726F756E642D636F6C6F72222C78292C653D787D7D7D3B72657475726E7B696E697469616C697A653A66756E6374696F6E28652C73297B76617220';
wwv_flow_api.g_varchar2_table(70) := '453B7472797B453D6E756C6C3D3D737C7C303D3D732E6C656E6774683F783A4A534F4E2E70617273652873293B766172206F3D2223222B652C723D24286F293B2166756E6374696F6E2868297B2F285E235B302D39412D465D7B367D24297C285E235B30';
wwv_flow_api.g_varchar2_table(71) := '2D39412D465D7B337D24292F692E746573742868293F462E7069636B65722E736574436F6C6F7228652C68293A462E7069636B65722E736574436F6C6F7228652C222346464646464622297D2824282223222B65292E76616C2829293B76617220433D72';
wwv_flow_api.g_varchar2_table(72) := '2E636C6F7365737428222E742D466F726D2D6974656D5772617070657222292E68656967687428293B24282223222B652B225F6267636F6C6F7222292E63737328226D617267696E222C432F322D37292C722E637373282270616464696E672D6C656674';
wwv_flow_api.g_varchar2_table(73) := '222C43292C24282223222B652B225F444953504C415922292E637373282270616464696E672D6C656674222C43292C722E636C69636B2866756E6374696F6E2868297B462E7069636B65722E73686F7728452C65297D292C24282223222B652B225F6275';
wwv_flow_api.g_varchar2_table(74) := '74746F6E22292E636C69636B2866756E6374696F6E2868297B462E7069636B65722E73686F7728452C65297D297D63617463682865297B682E64656275672E6572726F7228224572726F72207768696C652074727920746F2073686F7720636F6C6F7273';
wwv_flow_api.g_varchar2_table(75) := '22292C682E64656275672E6572726F722865297D7D7D7D28293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(41564408942766285139)
,p_plugin_id=>wwv_flow_api.id(41556327815754810652)
,p_file_name=>'colorselector.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done