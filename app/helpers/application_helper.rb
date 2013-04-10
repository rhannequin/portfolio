module ApplicationHelper

  def fil_ariane(page, title, is_portfolio = false)
    fil = '<a href="/">Accueil</a>'
    if page != 'home'
      fil += is_portfolio ? ' - <a href="/portfolio">Portfolio</a> - ' : ' - '
      fil += title
    end
    return fil.html_safe;
  end

end
