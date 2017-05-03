#:newcell
module BlogPost::Cell

  class New < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include ActionView::Helpers::FormOptionsHelper
    include SimpleForm::ActionViewExtensions::FormHelper

    # include Formular::RailsHelper
    # include Formular::Helper

    def current_user
      return options[:context][:current_user]
    end

    def user_name
      current_user.firstname.blank? ? current_user.email : current_user.firstname
    end

  end
end
#:newcell end
