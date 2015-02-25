require Rails.root.join('lib', 'rails_admin','ordershow.rb')

RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::Ordershow)

#RailsAdmin.config {|c| c.label_methods << :user}
RailsAdmin.config do |config|

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.included_models = [ Product,Order,User,OrderStatus,Event ]



  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
     ordershow 

    show
    edit
    delete
    show_in_app
    charts
    import
    toggle
    ## With an audit adapter, you can add:
    # history_index
    # history_show

     # Set the custom action here
 

  end
end
