module ApplicationHelper

  # returns a message - call to action for the invoice e.g. 'Select a Biller'
  def add_select_message component

    pronoun = component.first == 'I' ? 'an' : 'a'

    "Select #{pronoun} #{component} &#xf0d7;".html_safe
  
  end


# returns the CRUD action for the headers in the forms e.g. 'Edit Biller'
  def format_name params

    action = params[:action]
    controller = params[:controller]

    action = action.capitalize

    controller.slice! 'account/'

    controller.gsub! '_', ' '

    controller = controller.split.map(&:capitalize).join(' ')

    controller.chomp! 's'

    "#{action} #{controller}"

  end

end
