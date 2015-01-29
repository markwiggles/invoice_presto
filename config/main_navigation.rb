SimpleNavigation::Configuration.run do |navigation|


  navigation.items do |primary|

    primary.item :home, 'HOME', '/home'
    primary.item :settings, 'SETTINGS', account_settings_path
    primary.item :invoice, 'INVOICING', account_invoices_path

    primary.dom_class = 'nav navbar-nav'

  end

end