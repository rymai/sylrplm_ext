module SylrplmExt
  module SylrplmExtensionsHelper
    #
    # == Role: this function permit a selection in a list of objects in another window
    # <em>the field in a first window is updated with the value selected in the second</em>
    #
    # == Arguments
    # * +sym_objfrom+ - \Object name to edit
    # * +sym_objto+ - \Object to select
    # * +val_objtoselect+ - Actual value of the object to select
    # * +:controller+ - Controller of the object to select
    #
    # == Usage
    #
    # === Calling view
    # During datafile edition, I want to choose the responsible:
    # <%= f.label t("label_responsible") %>
    # <%= \select_in_list(:datafile, :owner, @datafile.owner.login, :users) %>
    #
    # === the html result is
    # hidden_field("datafile" , "owner_id")
    # text_field_tag("datafile_owner_display", value of @datafile.owner.login, :disabled => true)
    # link_to(h_img_btn("btn_select"), {:controller => "users", :todo => "select", :html_ident => "datafile_owner"} , {:target => "_blank", :class => 'menu_bas'})"
    #
    # == Impact on other components
    # the 'index' view  of the object to select can be modified to show or not the menus or anything else
    # <% unless param_equals?("todo", "select") %>
    #
    def select_in_list (sym_objfrom, sym_objto, val_objtoselect, controller)
      ret=""
      ret<< hidden_field(sym_objfrom , "#{sym_objto}_id")
      ret<< text_field_tag("#{sym_objfrom}_#{sym_objto}_display", val_objtoselect, :disabled => true)
      ret<< link_to("...", {:controller => controller, :todo => "select", :html_ident => "#{sym_objfrom}_#{sym_objto}"} , {:target => "_blank", :class => 'menu_bas',:title=>t("btn_select")})
      ret.html_safe
    end

    def select_button(object)
      ret=""
      ret<<"<input type='button' value='select' class='btn-select'"
      ret<<" onclick=\"callSelect('#{@myparams["html_ident"]}','#{object.id}','#{object.ident}')\" />"
      ret.html_safe
    end

    #
    # == Role: create two combobox with an arrow to transfer selected values from the left (possible values) to the right (selected values)
    # == Arguments
    # * +form+ Formulaire html created by edition view
    # * +object+ \Object being edited
    # * +values+ Array of objects defining the values
    # * +field+ The field of value to show in select
    # * +assoc_name+ name of the association between object and "object value" / example :ongroup for subscription to groups. Contient le nom de l'association, example :ongroup pour subscription vers les groupes
    # == Usage
    # === Calling view
    # <%= select_inout(form, @subscription, @ongroups, :name, :ongroup) %>
    # Note: in case of no velues, the default is the first object in list of values / Si pas de valeur, on prend le nom par defaut dans la le 1er objet de la liste des valeurs :group
    #
    def select_inout(form, object, values, field, assoc_name=nil)
      fname = "#{self.class.name}.#{__method__}"
      #LOG.debug (fname){"object=#{object}"}
      #LOG.debug (fname){"values=#{values}, field=#{field}"}
      html = ""
      unless values.nil? || values.count == 0
        #user
        mdl_object=object.class.name.underscore
        #group
        if assoc_name.nil?
        mdl_assoc = values[0].class.name.underscore
        else
        mdl_assoc = assoc_name
        end
        #user_groups
        select_id="#{mdl_object}_#{mdl_assoc}_ids"
        #user[role_ids][]
        select_name="#{mdl_object}[#{mdl_assoc}_ids][]"
        #role_ids
        method=("#{mdl_assoc}_ids").to_sym
       #the_selected=object.method(method).call: ko dans certains cas (securite!!)
        the_selected=object.send(method)
         #label_user_groups_out, label_user_groups_in
        label_out=t("label_"+select_id+"_out")
        label_in=t("label_"+select_id+"_in")
        nb=[values.count+1, 10].min
        html += "<div style='display: none;'>"
        html += form.collection_select(method, values, :id, field, {}, {:id => select_id, :size => nb, :multiple => :true, :name => select_name, :selected => the_selected})
        html += "</div>"
        html += "<table>"
        html += "<tr>"
        html += "<th>#{label_out}</th>"
        html += "<th></th>"
        html += "<th>#{label_in}</th>"
        html += "</tr>"
        html += "<tr>"
        #html += "<td>mdl_object:#{mdl_object} mdl_assoc:#{mdl_assoc} select_id:#{select_id} select_name:#{select_name} method:#{method} : #{the_selected.inspect}</td>"
        html += "<td><select id='#{select_id}_out' multiple='multiple' name='#{select_id}_out' size=#{nb}></select></td>"
        html += "<td><a onclick=\"selectInOutAdd('#{select_id}'); return true;\" title=\"#{t('button_add')}\">#{h_img('select_inout/select_add')}</a>"
        html += "<br/>"
        html += "<a onclick= \"selectInOutRemove('#{select_id}'); return true;\" title=\"#{t('button_remove')}\">#{h_img('select_inout/select_remove')}</a></td>"
        html += "<td><select id='#{select_id}_in' multiple='multiple' name='#{select_id}_in' size=#{nb}></select></td>"
        html += "</tr>"
        html += "</table>"
        html += "<script>selectInOutFill('#{select_id}')</script>"
      end
      html.html_safe
    end

    #
    # combo box: select able to return null value
    #
    def select_with_empty(form, object, attribute, values, id, method)
      # id du select = role_father_id
      select_id = object.class.name.underscore+'_'+attribute.to_s
      html = "<p>#{t(:label_select_active)}</p>"
      html += check_box_tag(:select_active, "no", "false", :onclick=>"selectActive(this, '#{select_id}'); return true;")
      html += form.collection_select(attribute, values, id, method)
      html.html_safe
    end

    # select_relation_attribute(f, @ui_table, @columns, :ident, :ui_column_ids, :rank) %>
    def select_relation_attribute(form, object_from,values,field,relation_name,relation_attribute , nblinesmaxi=20)
      fname = "#{self.class.name}.#{__method__}"
      #LOG.debug(fname){"=====>object_from=#{object_from.ident}"}
      #LOG.debug(fname){"values=#{values}"}
      #LOG.debug(fname){"field=#{field}"}
      #LOG.debug(fname){"relation_name=#{relation_name}"}
      #LOG.debug(fname){"relation_attribute=#{relation_attribute}"}
      #LOG.debug(fname){"nblinesmaxi=#{nblinesmaxi}"}
      nblines=values.size
      nblines=nblinesmaxi if  nblinesmaxi>20
      ret=""
      unless object_from.nil?
        unless values.blank?
          array_idents=columns_to_array(object_from, values,:ident)
          #LOG.debug(fname){"array_idents=#{array_idents}"}
          #ret+="<br/><table>"
          ret+="<table>"
          #(0..nblines-1).each do |ind|
          ind=0
          array_idents.each do |infocol|
            key=infocol[0]
            #idcol=infocol[1]
            col=UiColumn.find_by_ident(key)
            #LOG.debug(fname){"#{ind} key=#{key} col=#{col.inspect}"}
            idcol=col.id
            # select ident on values
            #LOG.debug(fname){"#{ind} key=#{key} idcol=#{idcol}"}
            default_ident=key
            #LOG.debug(fname){"======== #{ind} array_idents=#{array_idents} default_ident=#{default_ident}"}
            options=options_for_select(array_idents,default_ident)
            #LOG.debug(fname){"#{ind} options=#{options}"}
            #
            default_rank=idcol
            #LOG.debug(fname){"#{ind} default_rank=#{default_rank}"}
            ret+="<tr>"
            ret += "<td>#{ind}</td>"
            ret += "<td>"
            ret+= select_tag("#{relation_name}[]",options,{autocomplete:"off"})
            ret+="</td>"
            # edit relation attribute
            ret += "<td>"
            ret+= number_field_tag("#{relation_attribute}[]",default_rank,{min:-1,max:nblines})
            ret+="</td>"
            ret += "</tr>"
            ind+=1
          end
          ret+="</table>"
        end
      end
      #LOG.debug(fname){"<=====#{object_from.ident}, field=#{field}, ret=#{ret}"}
      ret.html_safe
    end

    def columns_to_array(object_from, objects, field)
      fname = "#{self.class.name}.#{__method__}"
      #LOG.debug(fname){"====>#{objects.size} objects"}
      ret=[]
      unless objects.nil?
        ind=0
        objects.each do |obj|
          #LOG.debug(fname){"==== object =#{obj.inspect}"}
          colfieldident=obj.ident
          tabcol=::UiTablesUiColumn.get_from_table_and_colid(object_from, obj.id)
          #LOG.debug(fname){"tabcol=#{tabcol.inspect}"}
          unless tabcol.blank?
          #colfieldvalue=eval "#{tabcol[0]}.#{field}"
          #TODO utiliser eval avec le field
          colfieldvalue= tabcol[0].rank
          colfieldvalue=ind if colfieldvalue.blank?
          #unless (tabcol[0].nil? || tabcol[0].respond_to?( field))
          else
          colfieldvalue=ind
          end
          #LOG.debug(fname){"colfieldident=#{colfieldident} , colfieldvalue=#{colfieldvalue.inspect}"}
          ret << [colfieldident , colfieldvalue]
          ind+=1
        end
      end
      #LOG.debug(fname){"<====#{objects.size} objects, ret=#{ret}"}
      ret
    end
  end

  
end