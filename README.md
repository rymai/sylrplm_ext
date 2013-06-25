# sylrplm_ext

Various PLM extensions.

## Installation

Add the gem to your Gemfile:

```ruby
gem 'sylrplm_ext', github: 'sylvani/sylrplm_ext'
```

## Documentation

### Select in/out

#### Role

Create two combobox with an arrow to transfer selected values from the left (possible values) to the right (selected values).

#### Arguments

* +form+ Formulaire html created by edition view
* +object+ \Object being edited
* +values+ Array of objects defining the values
* +field+ The field of value to show in select
* +assoc_name+ name of the association between object and "object value" / example :ongroup for subscription to groups. Contient le nom de l'association, example :ongroup pour subscription vers les groupes

#### Usage

```ruby
<%= select_inout(form, @subscription, @ongroups, :name, :ongroup) %>
```

Note: in case of no velues, the default is the first object in list of values / Si pas de valeur, on prend le nom par defaut dans la le 1er objet de la liste des valeurs :group

### Select in list

#### Role

This function permit a selection in a list of objects in another window (*the field in a first window is updated with the value selected in the second*).

#### Arguments

# * +sym_objfrom+ - \Object name to edit
# * +sym_objto+ - \Object to select
# * +val_objtoselect+ - Actual value of the object to select
# * +:control+ - Controller of the object to select

#### Usage

During datafile edition, I want to choose the responsible:

```ruby
<%= f.label t("label_responsible") %>
<%= select_in_list(:datafile, :owner, @datafile.owner.login, :users) %>
```

will generate:

```ruby
hidden_field("datafile" , "owner_id")
text_field_tag("datafile_owner_display", value of @datafile.owner.login, :disabled => true)
link_to(h_img_btn("btn_select"), {:controller => "users", :todo => "select", :html_ident => "datafile_owner"} , {:target => "_blank", :class => 'menu_bas'})"
```

#### Impact on other components

The 'index' view of the object to select can be modified to show or not the menus or anything else:

```ruby
<% unless param_equals?("todo", "select") %>
```
