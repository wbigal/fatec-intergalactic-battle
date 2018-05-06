RailsAdmin.config do |config|
  config.main_app_name = ['Batalha Intergalática', 'BackOffice']
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version'
  #   PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['SpacecraftShape', 'Team']
    end
    # export
    bulk_delete
    show
    edit do
      except ['SpacecraftShape']
    end
    delete do
      except ['SpacecraftShape', 'Team']
    end
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.included_models = [Player, PlayerAvatar, Scenery, SpacecraftShape,
                           Team, User]

  config.model 'Player' do
    navigation_label 'Jogadores'
    list do
      sort_by :nickname
      field :nickname
      field :avatar do
        pretty_value do
          bindings[:view].tag(
            :img,
            src: bindings[:object].avatar.image.url(:thumb)
          )
        end
      end
      field :email
      field :updated_at
    end

    edit do
      field :nickname
      field :avatar
      field :email
      field :password
    end

    show do
      field :nickname
      field :avatar do
        pretty_value do
          bindings[:view].tag(
            :img,
            src: bindings[:object].avatar.image.url(:thumb)
          )
        end
      end
      field :email
      field :created_at
      field :updated_at
    end
  end

  config.model 'PlayerAvatar' do
    navigation_label 'Jogadores'
    list do
      sort_by :name
      field :name
      field :image
      field :updated_at
    end

    edit do
      field :name
      field :image do
        help 'Obrigatório. Image jpg, png ou gif com dimensão de 83x110px'
      end
    end

    show do
      field :name
      field :image
      field :created_at
      field :updated_at
    end
  end

  config.model 'Scenery' do
    navigation_label 'Jogabilidade'
    list do
      sort_by :name
      field :name
      field :rows
      field :columns
      field :image
      field :updated_at
    end

    edit do
      field :name
      field :rows
      field :columns
      field :image
    end

    show do
      field :name
      field :rows
      field :columns
      field :image
      field :created_at
      field :updated_at
    end
  end

  config.model 'SpacecraftShape' do
    navigation_label 'Jogabilidade'
    list do
      sort_by :name
      field :name
      field :spacecraft_width
      field :spacecraft_height
      field :template
      field :updated_at
    end

    show do
      field :name
      field :spacecraft_width
      field :spacecraft_height
      field :template
      field :targets
      field :created_at
      field :updated_at
    end
  end

  config.model 'Team' do
    navigation_label 'Jogabilidade'
    list do
      sort_by :name
      field :name
      field :updated_at
    end

    edit do
      field :name
    end

    show do
      field :name
    end
  end

  config.model 'User' do
    navigation_label 'Administradores'
    list do
      sort_by :name
      field :name
      field :email
      field :updated_at
    end

    edit do
      field :name
      field :email
      field :password
    end

    show do
      field :name
      field :email
      field :created_at
      field :updated_at
    end
  end
end
